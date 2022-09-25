# Functions (Checkers)

&nbsp;

The functions on this page allow you to check the state of verbs for each player. Input allows you to check verbs in multiple different ways, ranging from simple pressed/released to more complex behaviours like double taps.

If you're looking for ways to return two-dimensional information for top-down movement or aiming, please see the [2D Checkers](Functions-(2D-Checkers)) page. What verbs are available for use is defined via [default profiles](Profiles) in [`__input_config_profiles_and_bindings()`](Configuration?id=profiles-and-bindings).

&nbsp;

## `input_check(verb, [playerIndex], [bufferDuration])`

*Returns:* Boolean, if the verb is currently active

|Name              |Datatype                        |Purpose                                                                                                   |
|------------------|--------------------------------|----------------------------------------------------------------------------------------------------------|
|`verb`            |[verb](Verbs-and-Bindings)/array|[Verb](Verbs-and-Bindings) to check, or an array of [verbs](Verbs-and-Bindings) (see below)               |
|`[playerIndex]`   |integer                         |Player to target. If not specified, player 0 is used                                                      |
|`[bufferDuration]`|frames/milliseconds             |Input buffering duration, the units of which are determined by [`INPUT_TIMER_MILLISECONDS`](Configuration)|

If an array of [verbs](Verbs-and-Bindings) is provided for the `verb` parameter, this function will return `true` if **any** of the verbs are currently active for the player.

&nbsp;

## `input_check_pressed(verb, [playerIndex], [bufferDuration])`

*Returns:* Boolean, if the verb is newly activated this frame

|Name              |Datatype                        |Purpose                                                                                                   |
|------------------|--------------------------------|----------------------------------------------------------------------------------------------------------|
|`verb`            |[verb](Verbs-and-Bindings)/array|[Verb](Verbs-and-Bindings) to check, or an array of [verbs](Verbs-and-Bindings) (see below)               |
|`[playerIndex]`   |integer                         |Player to target. If not specified, player 0 is used                                                      |
|`[bufferDuration]`|frames/milliseconds             |Input buffering duration, the units of which are determined by [`INPUT_TIMER_MILLISECONDS`](Configuration)|

If an array of [verbs](Verbs-and-Bindings) is provided for the `verb` parameter, this function will return `true` if **any** of the verbs are newly activated this frame for the player.

&nbsp;

## `input_check_released(verb, [playerIndex], [bufferDuration])`

*Returns:* Boolean, if the verb is newly deactivated this frame

|Name              |Datatype                        |Purpose                                                                                                   |
|------------------|--------------------------------|----------------------------------------------------------------------------------------------------------|
|`verb`            |[verb](Verbs-and-Bindings)/array|[Verb](Verbs-and-Bindings) to check, or an array of [verbs](Verbs-and-Bindings) (see below)               |
|`[playerIndex]`   |integer                         |Player to target. If not specified, player 0 is used                                                      |
|`[bufferDuration]`|frames/milliseconds             |Input buffering duration, the units of which are determined by [`INPUT_TIMER_MILLISECONDS`](Configuration)|

If an array of [verbs](Verbs-and-Bindings) is provided for the `verb` parameter, this function will return `true` if **any** of the verbs are newly deactivated this frame for the player.

&nbsp;

## `input_check_repeat(verb, [playerIndex], [delay], [predelay])`

*Returns:* Boolean, if the verb has been re-triggered by a repeater behaviour

|Name           |Datatype                        |Purpose                                                                                                                      |
|---------------|--------------------------------|-----------------------------------------------------------------------------------------------------------------------------|
|`verb`         |[verb](Verbs-and-Bindings)      |[Verb](Verbs-and-Bindings) to check                                                                                          |
|`[playerIndex]`|integer                         |Player to target. If not specified, player 0 is used                                                                         |
|`[delay]`      |frames/milliseconds             |Time between re-triggers; if not specified, this will default to [`INPUT_REPEAT_DEFAULT_DELAY`](Configuration). The units of this value are determined by [`INPUT_TIMER_MILLISECONDS`](Configuration)|
|`[predelay]`   |frames/milliseconds             |Time before the first re-trigger; if not specified, this will default to [`INPUT_REPEAT_DEFAULT_DELAY`](Configuration). The units of this value are determined by [`INPUT_TIMER_MILLISECONDS`](Configuration)|

This function will **not** return `true` on the same frame a verb is activated (unless `predelay` is set to 0). You'll probably want to combine this function with [`input_check_pressed()`](Functions-(Checkers)#input_check_pressedverb-playerindex-bufferduration).

&nbsp;

## `input_check_double(verb, [playerIndex], [bufferDuration])`

*Returns:* Boolean, if the verb is currently active

|Name              |Datatype                        |Purpose                                                                                                   |
|------------------|--------------------------------|----------------------------------------------------------------------------------------------------------|
|`verb`            |[verb](Verbs-and-Bindings)/array|[Verb](Verbs-and-Bindings) to check, or an array of [verbs](Verbs-and-Bindings) (see below)               |
|`[playerIndex]`   |integer                         |Player to target. If not specified, player 0 is used                                                      |
|`[bufferDuration]`|frames/milliseconds             |Input buffering duration, the units of which are determined by [`INPUT_TIMER_MILLISECONDS`](Configuration)|

If an array of [verbs](Verbs-and-Bindings) is provided for the `verb` parameter, this function will return `true` if **any** of the verbs are currently active for the player. The maximum delay between button presses to activate this function is given by [`INPUT_DOUBLE_DELAY`](Configuration).

&nbsp;

## `input_check_double_pressed(verb, [playerIndex], [bufferDuration])`

*Returns:* Boolean, if the verb is newly active

|Name              |Datatype                        |Purpose                                                                                                   |
|------------------|--------------------------------|----------------------------------------------------------------------------------------------------------|
|`verb`            |[verb](Verbs-and-Bindings)/array|[Verb](Verbs-and-Bindings) to check, or an array of [verbs](Verbs-and-Bindings) (see below)               |
|`[playerIndex]`   |integer                         |Player to target. If not specified, player 0 is used                                                      |
|`[bufferDuration]`|frames/milliseconds             |Input buffering duration, the units of which are determined by [`INPUT_TIMER_MILLISECONDS`](Configuration)|

If an array of [verbs](Verbs-and-Bindings) is provided for the `verb` parameter, this function will return `true` if **any** of the verbs are newly activated this frame for the player. The maximum delay between button presses to activate this function is given by [`INPUT_DOUBLE_DELAY`](Configuration).

&nbsp;

## `input_check_double_released(verb, [playerIndex], [bufferDuration])`

*Returns:* Boolean, if the verb is newly deactivated this frame

|Name              |Datatype                        |Purpose                                                                                                   |
|------------------|--------------------------------|----------------------------------------------------------------------------------------------------------|
|`verb`            |[verb](Verbs-and-Bindings)/array|[Verb](Verbs-and-Bindings) to check, or an array of [verbs](Verbs-and-Bindings) (see below)               |
|`[playerIndex]`   |integer                         |Player to target. If not specified, player 0 is used                                                      |
|`[bufferDuration]`|frames/milliseconds             |Input buffering duration, the units of which are determined by [`INPUT_TIMER_MILLISECONDS`](Configuration)|

If an array of [verbs](Verbs-and-Bindings) is provided for the `verb` parameter, this function will return `true` if **any** of the verbs are newly deactivated this frame for the player. The maximum delay between button presses to activate this function is given by [`INPUT_DOUBLE_DELAY`](Configuration).

&nbsp;

## `input_check_long(verb, [playerIndex], [bufferDuration])`

*Returns:* Boolean, if the verb is currently active

|Name              |Datatype                        |Purpose                                                                                                   |
|------------------|--------------------------------|----------------------------------------------------------------------------------------------------------|
|`verb`            |[verb](Verbs-and-Bindings)/array|[Verb](Verbs-and-Bindings) to check, or an array of [verbs](Verbs-and-Bindings) (see below)               |
|`[playerIndex]`   |integer                         |Player to target. If not specified, player 0 is used                                                      |
|`[bufferDuration]`|frames/milliseconds             |Input buffering duration, the units of which are determined by [`INPUT_TIMER_MILLISECONDS`](Configuration)|

If an array of [verbs](Verbs-and-Bindings) is provided for the `verb` parameter, this function will return `true` if **any** of the verbs are currently active for the player. The hold time required to activate this function is given by [`INPUT_LONG_DELAY`](Configuration).

&nbsp;

## `input_check_long_pressed(verb, [playerIndex], [bufferDuration])`

*Returns:* Boolean, if the verb is newly activated this frame

|Name              |Datatype                        |Purpose                                                                                                   |
|------------------|--------------------------------|----------------------------------------------------------------------------------------------------------|
|`verb`            |[verb](Verbs-and-Bindings)/array|[Verb](Verbs-and-Bindings) to check, or an array of [verbs](Verbs-and-Bindings) (see below)               |
|`[playerIndex]`   |integer                         |Player to target. If not specified, player 0 is used                                                      |
|`[bufferDuration]`|frames/milliseconds             |Input buffering duration, the units of which are determined by [`INPUT_TIMER_MILLISECONDS`](Configuration)|

If an array of [verbs](Verbs-and-Bindings) is provided for the `verb` parameter, this function will return `true` if **any** of the verbs are newly activated this frame for the player. The hold time required to activate this function is given by [`INPUT_LONG_DELAY`](Configuration).

&nbsp;

## `input_check_long_released(verb, [playerIndex], [bufferDuration])`

*Returns:* Boolean, if the verb is newly deactivated this frame

|Name              |Datatype                        |Purpose                                                                                                   |
|------------------|--------------------------------|----------------------------------------------------------------------------------------------------------|
|`verb`            |[verb](Verbs-and-Bindings)/array|[Verb](Verbs-and-Bindings) to check, or an array of [verbs](Verbs-and-Bindings) (see below)               |
|`[playerIndex]`   |integer                         |Player to target. If not specified, player 0 is used                                                      |
|`[bufferDuration]`|frames/milliseconds             |Input buffering duration, the units of which are determined by [`INPUT_TIMER_MILLISECONDS`](Configuration)|

If an array of [verbs](Verbs-and-Bindings) is provided for the `verb` parameter, this function will return `true` if **any** of the verbs are newly deactivated this frame for the player. The hold time required to activate this function is given by [`INPUT_LONG_DELAY`](Configuration).

&nbsp;

## `input_check_opposing(verbNegative, verbPositive, [playerIndex], [mostRecent])`

*Returns:* Real, the sign of the result of the negative and positive active verbs

|Name              |Datatype                  |Purpose                                                                                                   |
|------------------|--------------------------|----------------------------------------------------------------------------------------------------------|
|`verbNegative`    |[verb](Verbs-and-Bindings)|[Verb](Verbs-and-Bindings) to check as negative component                                                 |
|`verbPositive`    |[verb](Verbs-and-Bindings)|[Verb](Verbs-and-Bindings) to check as positive component                                                 |
|`[playerIndex]`   |integer                   |Player to target. If not specified, player 0 is used                                                      |
|`[mostRecent]`    |boolean                   |Whether to use the most recent input instead of returning `false` when two verbs conflict. False if unspecified|

&nbsp;

## `input_check_opposing_repeat(verbNegative, verbPositive, [playerIndex], [mostRecent], [delay], [predelay])`

*Returns:* Real, the sign of the result of the negative and positive active verbs as re-triggered by a repeater behaviour

|Name           |Datatype                        |Purpose                                                                                                                      |
|---------------|--------------------------------|-----------------------------------------------------------------------------------------------------------------------------|
|`verbNegative` |[verb](Verbs-and-Bindings)      |[Verb](Verbs-and-Bindings) to check as negative component                                                                    |
|`verbPositive` |[verb](Verbs-and-Bindings)      |[Verb](Verbs-and-Bindings) to check as positive component                                                                    |
|`[playerIndex]`|integer                         |Player to target. If not specified, player 0 is used                                                                         |
|`[mostRecent]` |boolean                         |Whether to use the most recent input instead of returning `false` when two verbs conflict. False if unspecified            |
|`[delay]`      |frames/milliseconds             |Time between re-triggers; if not specified, this will default to [`INPUT_REPEAT_DEFAULT_DELAY`](Configuration). The units of this value are determined by [`INPUT_TIMER_MILLISECONDS`](Configuration)|
|`[predelay]`   |frames/milliseconds             |Time before the first re-trigger; if not specified, this will default to [`INPUT_REPEAT_DEFAULT_DELAY`](Configuration). The units of this value are determined by [`INPUT_TIMER_MILLISECONDS`](Configuration)|

This function will **not** return `true` on the same frame a verb is activated (unless `predelay` is set to 0). You'll probably want to combine this function with [`input_check_pressed()`](Functions-(Checkers)#input_check_pressedverb-playerindex-bufferduration).

&nbsp;

## `input_check_opposing_pressed(verbNegative, verbPositive, [playerIndex], [mostRecent])`

*Returns:* Real, the sign of the result of the negative and positive newly active verbs

|Name              |Datatype                  |Purpose                                                                                                   |
|------------------|--------------------------|----------------------------------------------------------------------------------------------------------|
|`verbNegative`    |[verb](Verbs-and-Bindings)|[Verb](Verbs-and-Bindings) to check as negative component                                                 |
|`verbPositive`    |[verb](Verbs-and-Bindings)|[Verb](Verbs-and-Bindings) to check as positive component                                                 |
|`[playerIndex]`   |integer                   |Player to target. If not specified, player 0 is used                                                      |
|`[mostRecent]`    |boolean                   |Whether to use the most recent input instead of returning `false` when two verbs conflict. False if unspecified|

&nbsp;

## `input_value(verb, [playerIndex])`

*Returns:* Real, the analogue value of the input (after calculating the threshold)

|Name              |Datatype                        |Purpose                                                                                    |
|------------------|--------------------------------|-------------------------------------------------------------------------------------------|
|`verb`            |[verb](Verbs-and-Bindings)/array|[Verb](Verbs-and-Bindings) to check, or an array of [verbs](Verbs-and-Bindings) (see below)|
|`[playerIndex]`   |integer                         |Player to target. If not specified, player 0 is used                                       |

For on/off inputs, this function will return `0.0` or `1.0`.

If an array of [verbs](Verbs-and-Bindings) is provided for the `verb` parameter, this function will return the **sum** of the verb values for the player.

&nbsp;

## `input_held_time(verb, [playerIndex])`

*Returns:* Number, the length of time that a verb has been active (held)

|Name           |Datatype                  |Purpose                                             |
|---------------|--------------------------|----------------------------------------------------|
|`verb`         |[verb](Verbs-and-Bindings)|[Verb](Verbs-and-Bindings) to check                 |
|`[playerIndex]`|integer                   |Player to target. If not specified, player 0 is used|

The units returned by this function is determined by `INPUT_TIMER_MILLISECONDS`.

&nbsp;

## `input_is_analogue(verb, [playerIndex])`

*Returns:* Boolean, if the verb was last triggered by an analogue input (a gamepad axis)

|Name              |Datatype                        |Purpose                                                                                    |
|------------------|--------------------------------|-------------------------------------------------------------------------------------------|
|`verb`            |[verb](Verbs-and-Bindings)/array|[Verb](Verbs-and-Bindings) to check, or an array of [verbs](Verbs-and-Bindings) (see below)|
|`[playerIndex]`   |integer                         |Player to target. If not specified, player 0 is used                                       |

If an array of [verbs](Verbs-and-Bindings) is provided for the `verb` parameter, this function will return `true` if **any** of the verbs was last triggered by an analogue input.

&nbsp;

## `input_check_press_most_recent([array], [playerIndex])`

*Returns:* Most recent [verb](Verbs-and-Bindings) pressed in the specified array, or `undefined` if no verb is active

|Name              |Datatype                        |Purpose                                                                                                                                              |
|------------------|--------------------------------|-----------------------------------------------------------------------------------------------------------------------------------------------------|
|`[array]`         |[verb](Verbs-and-Bindings) array|Array of [verbs](Verbs-and-Bindings) to check. If keyword `all` is used, or this argument is not specified, then all verbs for the player are checked|
|`[playerIndex]`   |integer                         |Player to target. If not specified, player 0 is used                                                                                                 |
