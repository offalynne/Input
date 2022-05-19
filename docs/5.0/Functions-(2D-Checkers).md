# Functions (2D Checkers)

&nbsp;

The functions on this page allow you to check verbs by treating them as 2D constructions. This is helpful for situations where you need to think in two dimensions, such as top-down movement or aiming.

If you're looking for simpler ways to check verbs, please see the [1D Checkers](Functions-(Checkers)) page. What verbs are available for use is defined via [default profiles](Profiles) in [`__input_config_profiles_and_bindings()`](Configuration?id=profiles-and-bindings).

&nbsp;

## `input_x(verbLeft, verbRight, verbUp, verbDown, [playerIndex], [mostRecent])`

*Returns:* Number, the x-coordinate of the vector represented by the sum of the verb values

|Name            |Datatype                  |Purpose                                                     |
|----------------|--------------------------|------------------------------------------------------------|
|`verbUp`        |[verb](Verbs-and-Bindings)|[Verb](Verbs-and-Bindings) that moves the point of aim up   |
|`verbDown`      |[verb](Verbs-and-Bindings)|[Verb](Verbs-and-Bindings) that moves the point of aim down |
|`verbLeft`      |[verb](Verbs-and-Bindings)|[Verb](Verbs-and-Bindings) that moves the point of aim left |
|`verbRight`     |[verb](Verbs-and-Bindings)|[Verb](Verbs-and-Bindings) that moves the point of aim right|
|`[playerIndex]` |integer                   |Player to target. If not specified, player 0 is used        |
|`[mostRecent ]` |boolean                   |Whether to prioritize recency per axis. False if unspecified|

&nbsp;

## `input_y(verbLeft, verbRight, verbUp, verbDown, [playerIndex], [mostRecent])`

*Returns:* Number, the y-coordinate of the vector represented by the sum of the verb values

|Name            |Datatype                  |Purpose                                                     |
|----------------|--------------------------|------------------------------------------------------------|
|`verbUp`        |[verb](Verbs-and-Bindings)|[Verb](Verbs-and-Bindings) that moves the point of aim up   |
|`verbDown`      |[verb](Verbs-and-Bindings)|[Verb](Verbs-and-Bindings) that moves the point of aim down |
|`verbLeft`      |[verb](Verbs-and-Bindings)|[Verb](Verbs-and-Bindings) that moves the point of aim left |
|`verbRight`     |[verb](Verbs-and-Bindings)|[Verb](Verbs-and-Bindings) that moves the point of aim right|
|`[playerIndex]` |integer                   |Player to target. If not specified, player 0 is used        |
|`[mostRecent]`  |boolean                   |Whether to prioritize recency per axis. False if unspecified|

&nbsp;

## `input_xy(verbLeft, verbRight, verbUp, verbDown, [playerIndex], [mostRecent])`

*Returns:* Struct, the vector represented by the sum of the verb values

|Name            |Datatype                  |Purpose                                                     |
|----------------|--------------------------|------------------------------------------------------------|
|`verbUp`        |[verb](Verbs-and-Bindings)|[Verb](Verbs-and-Bindings) that moves the point of aim up   |
|`verbDown`      |[verb](Verbs-and-Bindings)|[Verb](Verbs-and-Bindings) that moves the point of aim down |
|`verbLeft`      |[verb](Verbs-and-Bindings)|[Verb](Verbs-and-Bindings) that moves the point of aim left |
|`verbRight`     |[verb](Verbs-and-Bindings)|[Verb](Verbs-and-Bindings) that moves the point of aim right|
|`[playerIndex]` |integer                   |Player to target. If not specified, player 0 is used        |
|`[mostRecent]`  |boolean                   |Whether to prioritize recency per axis. False if unspecified|

The struct returned by this function contains two member variables: `.x` and `.y`.

&nbsp;

## `input_direction(verbLeft, verbRight, verbUp, verbDown, [playerIndex], [mostRecent])`

*Returns:* Number, the direction (in degrees) represented by the sum of the verb values

|Name           |Datatype                  |Purpose                                                     |
|---------------|--------------------------|------------------------------------------------------------|
|`verbUp`       |[verb](Verbs-and-Bindings)|[Verb](Verbs-and-Bindings) that moves the point of aim up   |
|`verbDown`     |[verb](Verbs-and-Bindings)|[Verb](Verbs-and-Bindings) that moves the point of aim down |
|`verbLeft`     |[verb](Verbs-and-Bindings)|[Verb](Verbs-and-Bindings) that moves the point of aim left |
|`verbRight`    |[verb](Verbs-and-Bindings)|[Verb](Verbs-and-Bindings) that moves the point of aim right|
|`[playerIndex]`|integer                   |Player to target. If not specified, player 0 is used        |
|`[mostRecent]` |boolean                   |Whether to prioritize recency per axis. False if unspecified|

!> If the distance to the point of aim is 0 (after taking into account the minimum threshold) then this function will return `undefined`. Make sure you handle this return case in your code!

&nbsp;

## `input_distance(verbLeft, verbRight, verbUp, verbDown, [playerIndex], [mostRecent])`

*Returns:* Number, the length of the vector represented by the sum of the verb values

|Name           |Datatype                  |Purpose                                                     |
|---------------|--------------------------|------------------------------------------------------------|
|`verbUp`       |[verb](Verbs-and-Bindings)|[Verb](Verbs-and-Bindings) that moves the point of aim up   |
|`verbDown`     |[verb](Verbs-and-Bindings)|[Verb](Verbs-and-Bindings) that moves the point of aim down |
|`verbLeft`     |[verb](Verbs-and-Bindings)|[Verb](Verbs-and-Bindings) that moves the point of aim left |
|`verbRight`    |[verb](Verbs-and-Bindings)|[Verb](Verbs-and-Bindings) that moves the point of aim right|
|`[playerIndex]`|integer                   |Player to target. If not specified, player 0 is used        |
|`[mostRecent]` |boolean                   |Whether to prioritize recency per axis. False if unspecified|
