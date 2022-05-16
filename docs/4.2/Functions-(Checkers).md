# Functions (Checkers)

---

### `input_check(verb, [playerIndex], [bufferDuration])`

*Returns:* Boolean, if the verb is currently active

|Name              |Datatype                                  |Purpose                                                                                                                      |
|------------------|------------------------------------------|-----------------------------------------------------------------------------------------------------------------------------|
|`verb`            |[verb](Verbs-and-Alternate-Bindings)/array|[Verb](Verbs-and-Alternate-Bindings) to check, or an array of [verbs](Verbs-and-Alternate-Bindings) (see below)              |
|`[playerIndex]`   |integer                                   |Player to target. If not specified, player 0 is used                                                                         |
|`[bufferDuration]`|frames/milliseconds                       |Input buffering duration, the units of which are determined by [`INPUT_TIMER_MILLISECONDS`](Configuration)|

If an array of [verbs](Verbs-and-Alternate-Bindings) is provided for the `verb` parameter, this function will return `true` if **any** of the verbs are currently active for the player.

&nbsp;
---
&nbsp;

### `input_check_pressed(verb, [playerIndex], [bufferDuration])`

*Returns:* Boolean, if the verb is newly activated this frame

|Name              |Datatype                                  |Purpose                                                                                                                      |
|------------------|------------------------------------------|-----------------------------------------------------------------------------------------------------------------------------|
|`verb`            |[verb](Verbs-and-Alternate-Bindings)/array|[Verb](Verbs-and-Alternate-Bindings) to check, or an array of [verbs](Verbs-and-Alternate-Bindings) (see below)              |
|`[playerIndex]`   |integer                                   |Player to target. If not specified, player 0 is used                                                                         |
|`[bufferDuration]`|frames/milliseconds                       |Input buffering duration, the units of which are determined by [`INPUT_TIMER_MILLISECONDS`](Configuration)|

If an array of [verbs](Verbs-and-Alternate-Bindings) is provided for the `verb` parameter, this function will return `true` if **any** of the verbs are newly activated this frame for the player.

&nbsp;
---
&nbsp;

### `input_check_released(verb, [playerIndex], [bufferDuration])`

*Returns:* Boolean, if the verb is newly deactivated this frame

|Name              |Datatype                                  |Purpose                                                                                                                      |
|------------------|------------------------------------------|-----------------------------------------------------------------------------------------------------------------------------|
|`verb`            |[verb](Verbs-and-Alternate-Bindings)/array|[Verb](Verbs-and-Alternate-Bindings) to check, or an array of [verbs](Verbs-and-Alternate-Bindings) (see below)              |
|`[playerIndex]`   |integer                                   |Player to target. If not specified, player 0 is used                                                                         |
|`[bufferDuration]`|frames/milliseconds                       |Input buffering duration, the units of which are determined by [`INPUT_TIMER_MILLISECONDS`](Configuration)|

If an array of [verbs](Verbs-and-Alternate-Bindings) is provided for the `verb` parameter, this function will return `true` if **any** of the verbs are newly deactivated this frame for the player.

&nbsp;
---
&nbsp;

### `input_check_repeat(verb, [playerIndex], [delay], [predelay])`

*Returns:* Boolean, if the verb has been re-triggered by a repeater behaviour

|Name           |Datatype                                  |Purpose                                                                                                                      |
|---------------|------------------------------------------|-----------------------------------------------------------------------------------------------------------------------------|
|`verb`         |[verb](Verbs-and-Alternate-Bindings)/array|[Verb](Verbs-and-Alternate-Bindings) to check, or an array of [verbs](Verbs-and-Alternate-Bindings) (see below)              |
|`[playerIndex]`|integer                                   |Player to target. If not specified, player 0 is used                                                                         |
|`[delay]`      |frames/milliseconds                       |Time between re-triggers; if not specified, this will default to [`INPUT_REPEAT_DEFAULT_DELAY`](Configuration). The units of this value are determined by [`INPUT_REPEAT_DEFAULT_DELAY`](Configuration)|
|`[predelay]`   |frames/milliseconds                       |Time before the first re-trigger; if not specified, this will default to [`INPUT_REPEAT_DEFAULT_DELAY`](Configuration). The units of this value are determined by [`INPUT_REPEAT_DEFAULT_PREDELAY`](Configuration)|

This function will **not** return `true` on the same frame a verb is activated (unless `predelay` is set to 0). You'll probably want to combine this function with [`input_check_pressed()`](Functions-(Checkers)#input_check_pressedverb-playerindex-bufferduration).

&nbsp;
---
&nbsp;

### `input_check_double(verb, [playerIndex], [bufferDuration])`

*Returns:* Boolean, if the verb is currently active

|Name              |Datatype                                  |Purpose                                                                                                                      |
|------------------|------------------------------------------|-----------------------------------------------------------------------------------------------------------------------------|
|`verb`            |[verb](Verbs-and-Alternate-Bindings)/array|[Verb](Verbs-and-Alternate-Bindings) to check, or an array of [verbs](Verbs-and-Alternate-Bindings) (see below)              |
|`[playerIndex]`   |integer                                   |Player to target. If not specified, player 0 is used                                                                         |
|`[bufferDuration]`|frames/milliseconds                       |Input buffering duration, the units of which are determined by [`INPUT_TIMER_MILLISECONDS`](Configuration)|

If an array of [verbs](Verbs-and-Alternate-Bindings) is provided for the `verb` parameter, this function will return `true` if **any** of the verbs are currently active for the player. The maximum delay between button presses to activate this function is given by [`INPUT_DOUBLE_DELAY`](Configuration).

&nbsp;
---
&nbsp;

### `input_check_double_pressed(verb, [playerIndex], [bufferDuration])`

*Returns:* Boolean, if the verb is newly active

|Name              |Datatype                                  |Purpose                                                                                                                      |
|------------------|------------------------------------------|-----------------------------------------------------------------------------------------------------------------------------|
|`verb`            |[verb](Verbs-and-Alternate-Bindings)/array|[Verb](Verbs-and-Alternate-Bindings) to check, or an array of [verbs](Verbs-and-Alternate-Bindings) (see below)              |
|`[playerIndex]`   |integer                                   |Player to target. If not specified, player 0 is used                                                                         |
|`[bufferDuration]`|frames/milliseconds                       |Input buffering duration, the units of which are determined by [`INPUT_TIMER_MILLISECONDS`](Configuration)|

If an array of [verbs](Verbs-and-Alternate-Bindings) is provided for the `verb` parameter, this function will return `true` if **any** of the verbs are newly activated this frame for the player. The maximum delay between button presses to activate this function is given by [`INPUT_DOUBLE_DELAY`](Configuration).

&nbsp;
---
&nbsp;

### `input_check_double_released(verb, [playerIndex], [bufferDuration])`

*Returns:* Boolean, if the verb is newly deactivated this frame

|Name              |Datatype                                  |Purpose                                                                                                                      |
|------------------|------------------------------------------|-----------------------------------------------------------------------------------------------------------------------------|
|`verb`            |[verb](Verbs-and-Alternate-Bindings)/array|[Verb](Verbs-and-Alternate-Bindings) to check, or an array of [verbs](Verbs-and-Alternate-Bindings) (see below)              |
|`[playerIndex]`   |integer                                   |Player to target. If not specified, player 0 is used                                                                         |
|`[bufferDuration]`|frames/milliseconds                       |Input buffering duration, the units of which are determined by [`INPUT_TIMER_MILLISECONDS`](Configuration)|

If an array of [verbs](Verbs-and-Alternate-Bindings) is provided for the `verb` parameter, this function will return `true` if **any** of the verbs are newly deactivated this frame for the player. The maximum delay between button presses to activate this function is given by [`INPUT_DOUBLE_DELAY`](Configuration).

&nbsp;
---
&nbsp;

### `input_check_long(verb, [playerIndex], [bufferDuration])`

*Returns:* Boolean, if the verb is currently active

|Name              |Datatype                                  |Purpose                                                                                                                      |
|------------------|------------------------------------------|-----------------------------------------------------------------------------------------------------------------------------|
|`verb`            |[verb](Verbs-and-Alternate-Bindings)/array|[Verb](Verbs-and-Alternate-Bindings) to check, or an array of [verbs](Verbs-and-Alternate-Bindings) (see below)              |
|`[playerIndex]`   |integer                                   |Player to target. If not specified, player 0 is used                                                                         |
|`[bufferDuration]`|frames/milliseconds                       |Input buffering duration, the units of which are determined by [`INPUT_TIMER_MILLISECONDS`](Configuration)|

If an array of [verbs](Verbs-and-Alternate-Bindings) is provided for the `verb` parameter, this function will return `true` if **any** of the verbs are currently active for the player. The hold time required to activate this function is given by [`INPUT_LONG_DELAY`](Configuration).

&nbsp;
---
&nbsp;

### `input_check_long_pressed(verb, [playerIndex], [bufferDuration])`

*Returns:* Boolean, if the verb is newly activated this frame

|Name              |Datatype                                  |Purpose                                                                                                                      |
|------------------|------------------------------------------|-----------------------------------------------------------------------------------------------------------------------------|
|`verb`            |[verb](Verbs-and-Alternate-Bindings)/array|[Verb](Verbs-and-Alternate-Bindings) to check, or an array of [verbs](Verbs-and-Alternate-Bindings) (see below)              |
|`[playerIndex]`   |integer                                   |Player to target. If not specified, player 0 is used                                                                         |
|`[bufferDuration]`|frames/milliseconds                       |Input buffering duration, the units of which are determined by [`INPUT_TIMER_MILLISECONDS`](Configuration)|

If an array of [verbs](Verbs-and-Alternate-Bindings) is provided for the `verb` parameter, this function will return `true` if **any** of the verbs are newly activated this frame for the player. The hold time required to activate this function is given by [`INPUT_LONG_DELAY`](Configuration).

&nbsp;
---
&nbsp;

### `input_check_long_released(verb, [playerIndex], [bufferDuration])`

*Returns:* Boolean, if the verb is newly deactivated this frame

|Name              |Datatype                                  |Purpose                                                                                                                      |
|------------------|------------------------------------------|-----------------------------------------------------------------------------------------------------------------------------|
|`verb`            |[verb](Verbs-and-Alternate-Bindings)/array|[Verb](Verbs-and-Alternate-Bindings) to check, or an array of [verbs](Verbs-and-Alternate-Bindings) (see below)              |
|`[playerIndex]`   |integer                                   |Player to target. If not specified, player 0 is used                                                                         |
|`[bufferDuration]`|frames/milliseconds                       |Input buffering duration, the units of which are determined by [`INPUT_TIMER_MILLISECONDS`](Configuration)|

If an array of [verbs](Verbs-and-Alternate-Bindings) is provided for the `verb` parameter, this function will return `true` if **any** of the verbs are newly deactivated this frame for the player. The hold time required to activate this function is given by [`INPUT_LONG_DELAY`](Configuration).

&nbsp;
---
&nbsp;

### `input_value(verb, [playerIndex])`

*Returns:* Real, the analogue value of the input (after calculating the threshold)

|Name              |Datatype                                  |Purpose                                                                                                        |
|------------------|------------------------------------------|---------------------------------------------------------------------------------------------------------------|
|`verb`            |[verb](Verbs-and-Alternate-Bindings)/array|[Verb](Verbs-and-Alternate-Bindings) to check, or an array of [verbs](Verbs-and-Alternate-Bindings) (see below)|
|`[playerIndex]`   |integer                                   |Player to target. If not specified, player 0 is used                                                           |

For on/off inputs, this function will return `0.0` or `1.0`.

If an array of [verbs](Verbs-and-Alternate-Bindings) is provided for the `verb` parameter, this function will return the **sum** of the verb values for the player.

&nbsp;
---
&nbsp;

### `input_held_time(verb, [playerIndex])`

*Returns:* Number, the length of time that a verb has been active (held)

|Name           |Datatype                            |Purpose                                             |
|---------------|------------------------------------|----------------------------------------------------|
|`verb`         |[verb](Verbs-and-Alternate-Bindings)|[Verb](Verbs-and-Alternate-Bindings) to check       |
|`[playerIndex]`|integer                             |Player to target. If not specified, player 0 is used|

The units returned by this function is determined by `INPUT_TIMER_MILLISECONDS`.

&nbsp;
---
&nbsp;

### `input_is_analogue(verb, [playerIndex])`

*Returns:* Boolean, if the verb was last triggered by an analogue input (a gamepad axis)

|Name              |Datatype                                  |Purpose                                                                                                        |
|------------------|------------------------------------------|---------------------------------------------------------------------------------------------------------------|
|`verb`            |[verb](Verbs-and-Alternate-Bindings)/array|[Verb](Verbs-and-Alternate-Bindings) to check, or an array of [verbs](Verbs-and-Alternate-Bindings) (see below)|
|`[playerIndex]`   |integer                                   |Player to target. If not specified, player 0 is used                                                           |

If an array of [verbs](Verbs-and-Alternate-Bindings) is provided for the `verb` parameter, this function will return `true` if **any** of the verbs was last triggered by an analogue input.

&nbsp;
---
&nbsp;

### `input_check_press_most_recent([array], [playerIndex])`

*Returns:* Most recent [verb](Verbs-and-Alternate-Bindings) pressed in the specified array, or `undefined` if no verb is active

|Name              |Datatype                                  |Purpose                                                                                                                                                        |
|------------------|------------------------------------------|---------------------------------------------------------------------------------------------------------------------------------------------------------------|
|`[array]`         |[verb](Verbs-and-Alternate-Bindings) array|Array of [verbs](Verbs-and-Alternate-Bindings) to check. If keyword `all` is used, or this argument is not specified, then all verbs for the player are checked|
|`[playerIndex]`   |integer                                   |Player to target. If not specified, player 0 is used                                                                                                           |
