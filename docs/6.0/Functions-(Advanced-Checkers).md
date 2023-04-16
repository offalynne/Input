# Functions (Advanced Checkers)

&nbsp;

These functions expand upon the [basic verb checkers](Functions-(Checkers)) and give you access to more complex verb behaviours built in to Input.

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

## …check_double

`input_check_double(verb, [playerIndex], [bufferDuration])`

<!-- tabs:start -->

#### **Description**

**Returns:** Boolean, if the verb is currently active

|Name              |Datatype                        |Purpose                                                                                                   |
|------------------|--------------------------------|----------------------------------------------------------------------------------------------------------|
|`verb`            |[verb](Verbs-and-Bindings)/array|[Verb](Verbs-and-Bindings) to check, or an array of [verbs](Verbs-and-Bindings) (see below)               |
|`[playerIndex]`   |integer                         |Player to target. If not specified, player 0 is used                                                      |
|`[bufferDuration]`|frames/milliseconds             |Input buffering duration, the units of which are determined by [`INPUT_TIMER_MILLISECONDS`](Configuration)|

If an array of [verbs](Verbs-and-Bindings) is provided for the `verb` parameter, this function will return `true` if **any** of the verbs are currently active for the player. The maximum delay between button presses to activate this function is given by [`INPUT_DOUBLE_DELAY`](Configuration).

#### **Example**

```gml
//TODO lol
```

<!-- tabs:end -->

&nbsp;

## …check_double_pressed

`input_check_double_pressed(verb, [playerIndex], [bufferDuration])`

<!-- tabs:start -->

#### **Description**

**Returns:** Boolean, if the verb is newly active

|Name              |Datatype                        |Purpose                                                                                                   |
|------------------|--------------------------------|----------------------------------------------------------------------------------------------------------|
|`verb`            |[verb](Verbs-and-Bindings)/array|[Verb](Verbs-and-Bindings) to check, or an array of [verbs](Verbs-and-Bindings) (see below)               |
|`[playerIndex]`   |integer                         |Player to target. If not specified, player 0 is used                                                      |
|`[bufferDuration]`|frames/milliseconds             |Input buffering duration, the units of which are determined by [`INPUT_TIMER_MILLISECONDS`](Configuration)|

If an array of [verbs](Verbs-and-Bindings) is provided for the `verb` parameter, this function will return `true` if **any** of the verbs are newly activated this frame for the player. The maximum delay between button presses to activate this function is given by [`INPUT_DOUBLE_DELAY`](Configuration).

#### **Example**

```gml
//TODO lol
```

<!-- tabs:end -->

&nbsp;

## …check_double_released

`input_check_double_released(verb, [playerIndex], [bufferDuration])`

<!-- tabs:start -->

#### **Description**

**Returns:** Boolean, if the verb is newly deactivated this frame

|Name              |Datatype                        |Purpose                                                                                                   |
|------------------|--------------------------------|----------------------------------------------------------------------------------------------------------|
|`verb`            |[verb](Verbs-and-Bindings)/array|[Verb](Verbs-and-Bindings) to check, or an array of [verbs](Verbs-and-Bindings) (see below)               |
|`[playerIndex]`   |integer                         |Player to target. If not specified, player 0 is used                                                      |
|`[bufferDuration]`|frames/milliseconds             |Input buffering duration, the units of which are determined by [`INPUT_TIMER_MILLISECONDS`](Configuration)|

If an array of [verbs](Verbs-and-Bindings) is provided for the `verb` parameter, this function will return `true` if **any** of the verbs are newly deactivated this frame for the player. The maximum delay between button presses to activate this function is given by [`INPUT_DOUBLE_DELAY`](Configuration).

#### **Example**

```gml
//TODO lol
```

<!-- tabs:end -->

&nbsp;

## …check_long

`input_check_long(verb, [playerIndex], [bufferDuration])`

<!-- tabs:start -->

#### **Description**

**Returns:** Boolean, if the verb is currently active

|Name              |Datatype                        |Purpose                                                                                                   |
|------------------|--------------------------------|----------------------------------------------------------------------------------------------------------|
|`verb`            |[verb](Verbs-and-Bindings)/array|[Verb](Verbs-and-Bindings) to check, or an array of [verbs](Verbs-and-Bindings) (see below)               |
|`[playerIndex]`   |integer                         |Player to target. If not specified, player 0 is used                                                      |
|`[bufferDuration]`|frames/milliseconds             |Input buffering duration, the units of which are determined by [`INPUT_TIMER_MILLISECONDS`](Configuration)|

If an array of [verbs](Verbs-and-Bindings) is provided for the `verb` parameter, this function will return `true` if **any** of the verbs are currently active for the player. The hold time required to activate this function is given by [`INPUT_LONG_DELAY`](Configuration).

#### **Example**

```gml
//TODO lol
```

<!-- tabs:end -->

&nbsp;

## …check_long_pressed

`input_check_long_pressed(verb, [playerIndex], [bufferDuration])`

<!-- tabs:start -->

#### **Description**

**Returns:** Boolean, if the verb is newly activated this frame

|Name              |Datatype                        |Purpose                                                                                                   |
|------------------|--------------------------------|----------------------------------------------------------------------------------------------------------|
|`verb`            |[verb](Verbs-and-Bindings)/array|[Verb](Verbs-and-Bindings) to check, or an array of [verbs](Verbs-and-Bindings) (see below)               |
|`[playerIndex]`   |integer                         |Player to target. If not specified, player 0 is used                                                      |
|`[bufferDuration]`|frames/milliseconds             |Input buffering duration, the units of which are determined by [`INPUT_TIMER_MILLISECONDS`](Configuration)|

If an array of [verbs](Verbs-and-Bindings) is provided for the `verb` parameter, this function will return `true` if **any** of the verbs are newly activated this frame for the player. The hold time required to activate this function is given by [`INPUT_LONG_DELAY`](Configuration).

#### **Example**

```gml
//TODO lol
```

<!-- tabs:end -->

&nbsp;

## …check_long_released

`input_check_long_released(verb, [playerIndex], [bufferDuration])`

<!-- tabs:start -->

#### **Description**

**Returns:** Boolean, if the verb is newly deactivated this frame

|Name              |Datatype                        |Purpose                                                                                                   |
|------------------|--------------------------------|----------------------------------------------------------------------------------------------------------|
|`verb`            |[verb](Verbs-and-Bindings)/array|[Verb](Verbs-and-Bindings) to check, or an array of [verbs](Verbs-and-Bindings) (see below)               |
|`[playerIndex]`   |integer                         |Player to target. If not specified, player 0 is used                                                      |
|`[bufferDuration]`|frames/milliseconds             |Input buffering duration, the units of which are determined by [`INPUT_TIMER_MILLISECONDS`](Configuration)|

If an array of [verbs](Verbs-and-Bindings) is provided for the `verb` parameter, this function will return `true` if **any** of the verbs are newly deactivated this frame for the player. The hold time required to activate this function is given by [`INPUT_LONG_DELAY`](Configuration).

#### **Example**

```gml
//TODO lol
```

<!-- tabs:end -->

&nbsp;

## …check_quick_pressed

`input_check_quick_pressed(verb, [playerIndex], [bufferDuration])`

<!-- tabs:start -->

#### **Description**

**Returns:** Boolean, whether the given verb has been actived by a quick tap on an analogue (thumbstick/trigger) axis this frame

|Name              |Datatype                        |Purpose                                                                                                   |
|------------------|--------------------------------|----------------------------------------------------------------------------------------------------------|
|`verb`            |[verb](Verbs-and-Bindings)/array|[Verb](Verbs-and-Bindings) to check, or an array of [verbs](Verbs-and-Bindings) (see below)               |
|`[playerIndex]`   |integer                         |Player to target. If not specified, player 0 is used                                                      |
|`[bufferDuration]`|frames/milliseconds             |Input buffering duration, the units of which are determined by [`INPUT_TIMER_MILLISECONDS`](Configuration)|

If an array of [verbs](Verbs-and-Bindings) is provided for the `verb` parameter, this function will return `true` if **any** of the verbs are quick tapped this frame for the player.

!> This function will only work with anaologue input. Digital input (buttons, keys etc.) cannot trigger a quick tap.

#### **Example**

```gml
//TODO lol
```

<!-- tabs:end -->

&nbsp;

## …check_opposing

`input_check_opposing(verbNegative, verbPositive, [playerIndex], [mostRecent])`

<!-- tabs:start -->

#### **Description**

**Returns:** Real, the sign of the result of the negative and positive active verbs

|Name              |Datatype                  |Purpose                                                                                                   |
|------------------|--------------------------|----------------------------------------------------------------------------------------------------------|
|`verbNegative`    |[verb](Verbs-and-Bindings)|[Verb](Verbs-and-Bindings) to check as negative component                                                 |
|`verbPositive`    |[verb](Verbs-and-Bindings)|[Verb](Verbs-and-Bindings) to check as positive component                                                 |
|`[playerIndex]`   |integer                   |Player to target. If not specified, player 0 is used                                                      |
|`[mostRecent]`    |boolean                   |Whether to use the most recent input instead of returning `false` when two verbs conflict. False if unspecified|

#### **Example**

```gml
//TODO lol
```

<!-- tabs:end -->

&nbsp;

## …check_opposing_repeat

`input_check_opposing_repeat(verbNegative, verbPositive, [playerIndex], [mostRecent], [delay], [predelay])`

<!-- tabs:start -->

#### **Description**

**Returns:** Real, the sign of the result of the negative and positive active verbs as re-triggered by a repeater behaviour

|Name           |Datatype                        |Purpose                                                                                                                      |
|---------------|--------------------------------|-----------------------------------------------------------------------------------------------------------------------------|
|`verbNegative` |[verb](Verbs-and-Bindings)      |[Verb](Verbs-and-Bindings) to check as negative component                                                                    |
|`verbPositive` |[verb](Verbs-and-Bindings)      |[Verb](Verbs-and-Bindings) to check as positive component                                                                    |
|`[playerIndex]`|integer                         |Player to target. If not specified, player 0 is used                                                                         |
|`[mostRecent]` |boolean                         |Whether to use the most recent input instead of returning `false` when two verbs conflict. False if unspecified            |
|`[delay]`      |frames/milliseconds             |Time between re-triggers; if not specified, this will default to [`INPUT_REPEAT_DEFAULT_DELAY`](Configuration). The units of this value are determined by [`INPUT_TIMER_MILLISECONDS`](Configuration)|
|`[predelay]`   |frames/milliseconds             |Time before the first re-trigger; if not specified, this will default to [`INPUT_REPEAT_DEFAULT_DELAY`](Configuration). The units of this value are determined by [`INPUT_TIMER_MILLISECONDS`](Configuration)|

This function will **not** return `true` on the same frame a verb is activated (unless `predelay` is set to 0). You'll probably want to combine this function with [`input_check_pressed()`](Functions-(Checkers)#input_check_pressedverb-playerindex-bufferduration).

#### **Example**

```gml
//TODO lol
```

<!-- tabs:end -->

&nbsp;

## …check_opposing_pressed

`input_check_opposing_pressed(verbNegative, verbPositive, [playerIndex], [mostRecent])`

<!-- tabs:start -->

#### **Description**

**Returns:** Real, the sign of the result of the negative and positive newly active verbs

|Name              |Datatype                  |Purpose                                                                                                   |
|------------------|--------------------------|----------------------------------------------------------------------------------------------------------|
|`verbNegative`    |[verb](Verbs-and-Bindings)|[Verb](Verbs-and-Bindings) to check as negative component                                                 |
|`verbPositive`    |[verb](Verbs-and-Bindings)|[Verb](Verbs-and-Bindings) to check as positive component                                                 |
|`[playerIndex]`   |integer                   |Player to target. If not specified, player 0 is used                                                      |
|`[mostRecent]`    |boolean                   |Whether to use the most recent input instead of returning `false` when two verbs conflict. False if unspecified|

#### **Example**

```gml
//TODO lol
```

<!-- tabs:end -->

&nbsp;

## …held_time

`input_held_time(verb, [playerIndex])`

<!-- tabs:start -->

#### **Description**

**Returns:** Number, the length of time that a verb has been active (held)

|Name           |Datatype                  |Purpose                                             |
|---------------|--------------------------|----------------------------------------------------|
|`verb`         |[verb](Verbs-and-Bindings)|[Verb](Verbs-and-Bindings) to check                 |
|`[playerIndex]`|integer                   |Player to target. If not specified, player 0 is used|

The units returned by this function is determined by `INPUT_TIMER_MILLISECONDS`. This function returns a value less than 0 if the verb is not active or is not being held.

#### **Example**

```gml
//TODO lol
```

<!-- tabs:end -->

&nbsp;

## …held_time_released

`input_held_time_released(verb, [playerIndex])`

<!-- tabs:start -->

#### **Description**

**Returns:** Number, how long the current verb was held when released

|Name           |Datatype                  |Purpose                                             |
|---------------|--------------------------|----------------------------------------------------|
|`verb`         |[verb](Verbs-and-Bindings)|[Verb](Verbs-and-Bindings) to check                 |
|`[playerIndex]`|integer                   |Player to target. If not specified, player 0 is used|

The units returned by this function is determined by `INPUT_TIMER_MILLISECONDS`. This function returns a value less than 0 if the verb is not active or was not released.

#### **Example**

```gml
//TODO lol
```

<!-- tabs:end -->

&nbsp;

## …check_press_most_recent

`input_check_press_most_recent([array], [playerIndex])`

<!-- tabs:start -->

#### **Description**

**Returns:** Most recent [verb](Verbs-and-Bindings) pressed in the specified array, or `undefined` if no verb is active

|Name              |Datatype                        |Purpose                                                                                                                                              |
|------------------|--------------------------------|-----------------------------------------------------------------------------------------------------------------------------------------------------|
|`[array]`         |[verb](Verbs-and-Bindings) array|Array of [verbs](Verbs-and-Bindings) to check. If keyword `all` is used, or this argument is not specified, then all verbs for the player are checked|
|`[playerIndex]`   |integer                         |Player to target. If not specified, player 0 is used                                                                                                 |

#### **Example**

```gml
//TODO lol
```

<!-- tabs:end -->