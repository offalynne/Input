# Functions (Checkers)

&nbsp;

The functions on this page allow you to check the state of verbs for each player. These are the most common, bare minimum functions. You may also want to check verbs in the context of 2D movement or aiming, and those functions can be found on the [2D Checkers](https://www.jujuadams.com/Input/#/6.0/Functions-(2D-Checkers)) page. Input has a lot of ways of checking verbs that should cover many other use cases. You can find those functions on the [Advanced Checkers](Functions-(Advanced-Checkers)) and [Further Verb Functions](Functions-(Further-Verbs)) pages.

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