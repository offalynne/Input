# Functions (Extended Verbs)

&nbsp;

The functions on this page allow you to create complex verbs. These verbs can be checked using the standard [verb checkers](Functions-(Checkers)) but, due to their complexity, they require custom definition code.

Chord- and combo-type verbs exist "globally": once defined, every player will have access to these verbs. They cannot be modified with the normal [binding access functions](Functions-(Binding-Access)).

&nbsp;

## `input_chord_create(name, maxTimeBetweenPresses, verb1, verb2, ...)`

*Returns:* N/A (`undefined`)

|Name                   |Datatype                  |Purpose                                                                                                                        |
|-----------------------|--------------------------|-------------------------------------------------------------------------------------------------------------------------------|
|`name`                 |string                    |Name of the chord verb to create                                                                                               |
|`maxTimeBetweenPresses`|number                    |Maximum time allowed between verb activations, the units of which are determined by [`INPUT_TIMER_MILLISECONDS`](Configuration)|
|`verb1`                |[verb](Verbs-and-Bindings)|Name of a required [verb](Verbs-and-Bindings)                                                                                  |
|`verb2`                |[verb](Verbs-and-Bindings)|Name of a required [verb](Verbs-and-Bindings)                                                                                  |
|...                    |                          |etc.                                                                                                                           |

A "chord" is a set of verbs that must be pressed together, for example `ctrl + alt + delete` or `ctrl + S`. When all of the specified verbs are pressed together, the chord verb itself is activated. If there is too much time between individual key presses, determined by the `maxTimeBetweenPresses` argument, then the chord verb will fail to activate.

&nbsp;

## `input_combo_create(name, [phaseTimeout])`

*Returns:* Struct, a combo verb builder

|Name            |Datatype|Purpose                                                                                                                                                                                     |
|----------------|--------|--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
|`name`          |string  |Name of the combo verb to create                                                                                                                                                            |
|`[phaseTimeout]`|number  |Maximum time allowed between phases, the units of which are determined by [`INPUT_TIMER_MILLISECONDS`](Configuration). If not specified, the value defaults to 20 frames or 333 milliseconds|

Combos are made from multiple phases. As a player completes the button/key presses required to complete the combo, the combo phase advances. Each phase requires some sort of change in verb state from the player, either a press, a release, or a hold.

This function returns a struct that has a number of methods attached to it that allow you to define phases. Calling a method will add a new phase to the combo; the number of phases in a combo is equal to the number of methods you call. The methods used to define phases is as follows:

### `.press(verb)`

The verb must be pressed.

### `.release(verb)`

The verb must be released.

### `.press_or_release(verb)`

The verb must be either pressed or released.

### `.hold(verb)`

The given has to be held for this phase and all subsequent phases (or until `.release()` is called for this specific verb).

&nbsp;

Here is an example of the Konami Code:

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
.press("accept");
```

&nbsp;

## `input_combo_get_phase(verb, [playerIndex])`

*Returns:* Integer, the current phase for the combo verb for the given player

|Name              |Datatype|Purpose                                             |
|------------------|--------|----------------------------------------------------|
|`verb`            |string  |Combo verb to check                                 |
|`[playerIndex]`   |integer |Player to target. If not specified, player 0 is used|

This function returns which phase of the combo the player is on. If the player has not started entering a combo, this function returns `0`; if the player has completed the first phase, this function returns `1`; and so on. The maximum value, indicating that the player has completed the combo, that this function can return is equal to `input_combo_get_phase_count()` (see below).

&nbsp;

## `input_combo_get_phase_count(verb)`

*Returns:* Integer, the number of phases defined for the combo verb

|Name  |Datatype|Purpose                        |
|------|--------|-------------------------------|
|`verb`|string  |Name of the combo verb to check|