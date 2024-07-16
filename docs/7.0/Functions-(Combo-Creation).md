# Functions (Combo Creation)

&nbsp;

In Input, a "combo" is a sequence of inputs that need to be executed in a timely fashion to trigger some sort of player action. These are ubiquitous (and perhaps synonymous) with fighting games that regularly use a long chains of button inputs to skilltest the most powerful attacks. Less stringent combos are also found in other games that have some sort of skill mastery and combat component. Finally, combos are occasionally useful for triggering cheat codes.

Input offers a compact but powerful API to manage combos, including charge moves and directionality. This page will describe how to create combos. Getter functions specifically associated with combos can be found [here](Functions-(Combo-Getters)).

?> You can and should check for the completion of a combo using the standard [verb checkers](Functions-(Checkers)) e.g. `input_check_pressed("combo name")`

Combos are arranged in "phases". Each phase represents a condition that needs to be met before advancing to the next phase. Once all phases have been completed, the combo as a whole is complete. You can check whether a combo has been completed by using the standard verb getters e.g. `input_check_pressed("combo name")` will return `true` the same frame that a combo is evaluated as complete.

There are 5 types of phase:
1. Press a verb
2. Release a verb
3. Press or release a verb
4. Hold a verb (and keep holding it down)
5. Charge a verb for an indeterminate amount of time

Phases are built by executing methods on the combo definition struct returned by `input_combo_create()`. Each method call is a single phase. Each phase returns the combo struct itself which means methods can be chained together. For example:

```gml
input_combo_create("konami")
.press("up")
.press("up")
.press("down")
.press("down")
.press("left")
.press("right")
.press("left")
.press("right")
.press("cancel")
.press("accept")
.press("pause");
```

It's often useful to define one combo and have it apply no matter what direction the player is facing in. Input supports both side-on games (fighting games / platformers) and top-down games. You will need to tell Input what sort of game you're making via the [`input_combo_params_set_side_on()` or `input_combo_params_set_top_down()`](Functions-(Combo-Parameters)) functions. Once you've done that, any combo that is defined as being directional (via the `directional` argument for `input_combo_create()`) will automatically allow phases that use directional verbs to be triggered by other directional verbs.

For example, if we execute the following code...

```gml
input_combo_params_set_side_on("right", "left", 0);

input_combo_create("fireball")
.hold("down")
.press("right")
.release("down")
.press_or_release("punch");
```

...and a player inputs `down, down+right, right, punch` then the combo will be given direction `0`. However, if the player inputs `dow, down+left, left, punch` then the combo will still work, but has direction `180`. This works in a similar way for top-down games.

&nbsp;

## …combo_create

`input_combo_create(name, [phaseTimeout=default], [directional=true])`

<!-- tabs:start -->

#### **Description**

**Returns:** Struct, the container for the combo definition

|Name            |Datatype|Purpose                                                                                                                                                                          |
|----------------|--------|---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
|`name`          |string  |Verb to use to indicate the forward direction                                                                                                                                    |
|`[phaseTimeout]`|number  |Amount of time that the player has to enter the next input. Units are determined by `INPUT_TIMER_MILLISECONDS`. If not specified, defaults to `INPUT_COMBO_DEFAULT_PHASE_TIMEOUT`|
|`[directional]` |boolean |Whether to treat the combo as directional, see below. If not specified, defaults to `true`                                                                                       |

#### **Example**

```gml

```

<!-- tabs:end -->

&nbsp;

----------

&nbsp;

&nbsp;

## .press

`<combo struct>.press(verb)`

<!-- tabs:start -->

#### **Description**

**Returns:** `self` (the combo struct)

|Name  |Datatype|Purpose                            |
|------|--------|-----------------------------------|
|`verb`|string  |Verb that the player needs to press|

#### **Example**

```gml

```

<!-- tabs:end -->

&nbsp;

## .release

`<combo struct>.release(verb)`

<!-- tabs:start -->

#### **Description**

**Returns:** `self` (the combo struct)

|Name  |Datatype|Purpose                              |
|------|--------|-------------------------------------|
|`verb`|string  |Verb that the player needs to release|

#### **Example**

```gml

```

<!-- tabs:end -->

&nbsp;

## .press_or_release

`<combo struct>.press_or_release(verb)`

<!-- tabs:start -->

#### **Description**

**Returns:** `self` (the combo struct)

|Name  |Datatype|Purpose                                       |
|------|--------|----------------------------------------------|
|`verb`|string  |Verb that the player needs to press or release|

#### **Example**

```gml

```

<!-- tabs:end -->

&nbsp;

## .hold

`<combo struct>.hold(verb)`

<!-- tabs:start -->

#### **Description**

**Returns:** `self` (the combo struct)

|Name  |Datatype|Purpose                                |
|------|--------|---------------------------------------|
|`verb`|string  |Verb that the player needs to hold down|

`.hold()` phases will require that the player holds down the given verb until either: the end of the combo, or that specific verb is indicated to be released in a `.release()` phase.

#### **Example**

```gml
input_combo_create("hadouken")
.hold("down")
.press("right")
.release("down")
.press_or_release("punch");
```

<!-- tabs:end -->

&nbsp;

## .charge

`<combo struct>.charge(verb, [minTime=default])`

<!-- tabs:start -->

#### **Description**

**Returns:** `self` (the combo struct)

|Name       |Datatype|Purpose                                                                                                                   |
|-----------|--------|--------------------------------------------------------------------------------------------------------------------------|
|`verb`     |string  |Verb that the player needs to hold to charge                                                                              |
|`[minTime]`|number  |Minimum amount of time that a charge needs to be held. If not specified, defaults to `INPUT_COMBO_DEFAULT_MIN_CHARGE_TIME`|

#### **Example**

```gml
//Create a combo that is a double tap with a charge
//The attack gets more powerful the longer the second tap is held before releasing
input_combo_create("coup de grace")
.press("attack")
.release("attack")
.charge("attack")
.release("attack");
```

<!-- tabs:end -->

&nbsp;

## .ignore

`<combo struct>.ignore(verbArray)`

<!-- tabs:start -->

#### **Description**

**Returns:** `self` (the combo struct)

|Name       |Datatype|Purpose                                    |
|-----------|--------|-------------------------------------------|
|`verbArray`|array   |Array of verbs that the combo should ignore|

This method, unlike the phase creation methods, will set verbs of your choice to be "ignored" by the combo. An ignored verb will not cause a failure of the combo; for example, if you ignore the `"up"` verb then accidentally activating that verb in the middle of the combo will not cause the combo to fail. Ignored verbs will respect directionality. If a verb is used in any phase of a combo then it cannot be ignored.

?> You can also pass GameMaker keyboard `all` into this function to ignore all basic verbs.

#### **Example**

```gml

```

<!-- tabs:end -->
