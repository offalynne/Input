# Functions (Checkers)

&nbsp;

The functions on this page allow you to check the state of verbs for each player. Input allows you to check verbs in multiple different ways, ranging from simple pressed/released to more complex behaviours like double taps.

If you're looking for ways to return two-dimensional information for top-down movement or aiming, please see the [2D Checkers](Functions-(2D-Checkers)) page. What verbs are available for use is defined via [default profiles](Profiles) in [`__input_config_profiles_and_bindings()`](Configuration?id=profiles-and-bindings).

&nbsp;

## …check

`input_check(verb, [playerIndex], [bufferDuration])`

<!-- tabs:start -->

#### **Description**

**Returns:** Boolean, if the verb is currently active

|Name              |Datatype                        |Purpose                                                                                                   |
|------------------|--------------------------------|----------------------------------------------------------------------------------------------------------|
|`verb`            |[verb](Verbs-and-Bindings)/array|[Verb](Verbs-and-Bindings) to check, or an array of [verbs](Verbs-and-Bindings) (see below)               |
|`[playerIndex]`   |integer                         |Player to target. If not specified, player 0 is used                                                      |
|`[bufferDuration]`|frames/milliseconds             |Input buffering duration, the units of which are determined by [`INPUT_TIMER_MILLISECONDS`](Configuration)|

If an array of [verbs](Verbs-and-Bindings) is provided for the `verb` parameter, this function will return `true` if **any** of the verbs are currently active for the player.

#### **Example**

```gml
//TODO lol
```

<!-- tabs:end -->

&nbsp;

## …check_pressed

`input_check_pressed(verb, [playerIndex], [bufferDuration])`

<!-- tabs:start -->

#### **Description**

**Returns:** Boolean, if the verb is newly activated this frame

|Name              |Datatype                        |Purpose                                                                                                   |
|------------------|--------------------------------|----------------------------------------------------------------------------------------------------------|
|`verb`            |[verb](Verbs-and-Bindings)/array|[Verb](Verbs-and-Bindings) to check, or an array of [verbs](Verbs-and-Bindings) (see below)               |
|`[playerIndex]`   |integer                         |Player to target. If not specified, player 0 is used                                                      |
|`[bufferDuration]`|frames/milliseconds             |Input buffering duration, the units of which are determined by [`INPUT_TIMER_MILLISECONDS`](Configuration)|

If an array of [verbs](Verbs-and-Bindings) is provided for the `verb` parameter, this function will return `true` if **any** of the verbs are newly activated this frame for the player.

#### **Example**

```gml
//TODO lol
```

<!-- tabs:end -->

&nbsp;

## …check_released

`input_check_released(verb, [playerIndex], [bufferDuration])`

<!-- tabs:start -->

#### **Description**

**Returns:** Boolean, if the verb is newly deactivated this frame

|Name              |Datatype                        |Purpose                                                                                                   |
|------------------|--------------------------------|----------------------------------------------------------------------------------------------------------|
|`verb`            |[verb](Verbs-and-Bindings)/array|[Verb](Verbs-and-Bindings) to check, or an array of [verbs](Verbs-and-Bindings) (see below)               |
|`[playerIndex]`   |integer                         |Player to target. If not specified, player 0 is used                                                      |
|`[bufferDuration]`|frames/milliseconds             |Input buffering duration, the units of which are determined by [`INPUT_TIMER_MILLISECONDS`](Configuration)|

If an array of [verbs](Verbs-and-Bindings) is provided for the `verb` parameter, this function will return `true` if **any** of the verbs are newly deactivated this frame for the player.

#### **Example**

```gml
//TODO lol
```

<!-- tabs:end -->

&nbsp;

## …check_repeat

`input_check_repeat(verb, [playerIndex], [delay], [predelay])`

<!-- tabs:start -->

#### **Description**

**Returns:** Boolean, if the verb has been re-triggered by a repeater behaviour

|Name           |Datatype                        |Purpose                                                                                                                      |
|---------------|--------------------------------|-----------------------------------------------------------------------------------------------------------------------------|
|`verb`         |[verb](Verbs-and-Bindings)      |[Verb](Verbs-and-Bindings) to check                                                                                          |
|`[playerIndex]`|integer                         |Player to target. If not specified, player 0 is used                                                                         |
|`[delay]`      |frames/milliseconds             |Time between re-triggers; if not specified, this will default to [`INPUT_REPEAT_DEFAULT_DELAY`](Configuration). The units of this value are determined by [`INPUT_TIMER_MILLISECONDS`](Configuration)|
|`[predelay]`   |frames/milliseconds             |Time before the first re-trigger; if not specified, this will default to [`INPUT_REPEAT_DEFAULT_DELAY`](Configuration). The units of this value are determined by [`INPUT_TIMER_MILLISECONDS`](Configuration)|

This function will **not** return `true` on the same frame a verb is activated (unless `predelay` is set to 0). You'll probably want to combine this function with [`input_check_pressed()`](Functions-(Checkers)#input_check_pressedverb-playerindex-bufferduration).

#### **Example**

```gml
//TODO lol
```

<!-- tabs:end -->

&nbsp;

## …value

`input_value(verb, [playerIndex])`

<!-- tabs:start -->

#### **Description**

**Returns:** Real, the analogue value of the input (after calculating the threshold)

|Name              |Datatype                        |Purpose                                                                                    |
|------------------|--------------------------------|-------------------------------------------------------------------------------------------|
|`verb`            |[verb](Verbs-and-Bindings)/array|[Verb](Verbs-and-Bindings) to check, or an array of [verbs](Verbs-and-Bindings) (see below)|
|`[playerIndex]`   |integer                         |Player to target. If not specified, player 0 is used                                       |

For on/off inputs, this function will return `0.0` or `1.0`.

If an array of [verbs](Verbs-and-Bindings) is provided for the `verb` parameter, this function will return the **sum** of the verb values for the player.

#### **Example**

```gml
//TODO lol
```

<!-- tabs:end -->

&nbsp;

## …is_analogue

`input_is_analogue(verb, [playerIndex])`

<!-- tabs:start -->

#### **Description**

**Returns:** Boolean, if the verb was last triggered by an analogue input (a gamepad axis)

|Name              |Datatype                        |Purpose                                                                                    |
|------------------|--------------------------------|-------------------------------------------------------------------------------------------|
|`verb`            |[verb](Verbs-and-Bindings)/array|[Verb](Verbs-and-Bindings) to check, or an array of [verbs](Verbs-and-Bindings) (see below)|
|`[playerIndex]`   |integer                         |Player to target. If not specified, player 0 is used                                       |

If an array of [verbs](Verbs-and-Bindings) is provided for the `verb` parameter, this function will return `true` if **any** of the verbs was last triggered by an analogue input.

#### **Example**

```gml
//TODO lol
```

<!-- tabs:end -->