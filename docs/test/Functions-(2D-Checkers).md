# Functions (2D Checkers)

&nbsp;

The functions on this page allow you to check verbs by treating them as 2D constructions. This is helpful for situations where you need to think in two dimensions, such as top-down movement or aiming.

If you're looking for simpler ways to check verbs, please see the [1D Checkers](Functions-(Checkers)) page. What verbs are available for use is defined via [default profiles](Profiles) in [`__input_config_profiles_and_bindings()`](Configuration?id=profiles-and-bindings).

&nbsp;

## `input_direction(default, verbLeft, verbRight, verbUp, verbDown, [playerIndex], [mostRecent])`

*Returns:* Number, the direction (in degrees) represented by the sum of the verb values

|Name           |Datatype                  |Purpose                                                     |
|---------------|--------------------------|------------------------------------------------------------|
|`default`      |number                    |Value to return if none of the verbs are active             |
|`verbLeft`     |[verb](Verbs-and-Bindings)|[Verb](Verbs-and-Bindings) that moves the point of aim left |
|`verbRight`    |[verb](Verbs-and-Bindings)|[Verb](Verbs-and-Bindings) that moves the point of aim right|
|`verbUp`       |[verb](Verbs-and-Bindings)|[Verb](Verbs-and-Bindings) that moves the point of aim up   |
|`verbDown`     |[verb](Verbs-and-Bindings)|[Verb](Verbs-and-Bindings) that moves the point of aim down |
|`[playerIndex]`|integer                   |Player to target. If not specified, player 0 is used        |
|`[mostRecent]` |boolean                   |Whether to use the most recent input instead of returning 0 when two verbs conflict. False if unspecified|

&nbsp;

## `input_distance(verbLeft, verbRight, verbUp, verbDown, [playerIndex], [mostRecent])`

*Returns:* Number, the length of the vector represented by the sum of the verb values

|Name           |Datatype                  |Purpose                                                     |
|---------------|--------------------------|------------------------------------------------------------|
|`verbLeft`     |[verb](Verbs-and-Bindings)|[Verb](Verbs-and-Bindings) that moves the point of aim left |
|`verbRight`    |[verb](Verbs-and-Bindings)|[Verb](Verbs-and-Bindings) that moves the point of aim right|
|`verbUp`       |[verb](Verbs-and-Bindings)|[Verb](Verbs-and-Bindings) that moves the point of aim up   |
|`verbDown`     |[verb](Verbs-and-Bindings)|[Verb](Verbs-and-Bindings) that moves the point of aim down |
|`[playerIndex]`|integer                   |Player to target. If not specified, player 0 is used        |
|`[mostRecent]` |boolean                   |Whether to use the most recent input instead of returning 0 when two verbs conflict. False if unspecified|

&nbsp;

## `input_x(verbLeft, verbRight, verbUp, verbDown, [playerIndex], [mostRecent])`

*Returns:* Number, the x-coordinate of the vector represented by the sum of the verb values

|Name            |Datatype                  |Purpose                                                     |
|----------------|--------------------------|------------------------------------------------------------|
|`verbLeft`      |[verb](Verbs-and-Bindings)|[Verb](Verbs-and-Bindings) that moves the point of aim left |
|`verbRight`     |[verb](Verbs-and-Bindings)|[Verb](Verbs-and-Bindings) that moves the point of aim right|
|`verbUp`        |[verb](Verbs-and-Bindings)|[Verb](Verbs-and-Bindings) that moves the point of aim up   |
|`verbDown`      |[verb](Verbs-and-Bindings)|[Verb](Verbs-and-Bindings) that moves the point of aim down |
|`[playerIndex]` |integer                   |Player to target. If not specified, player 0 is used        |
|`[mostRecent ]` |boolean                   |Whether to use the most recent input instead of returning 0 when two verbs conflict. False if unspecified|

&nbsp;

## `input_y(verbLeft, verbRight, verbUp, verbDown, [playerIndex], [mostRecent])`

*Returns:* Number, the y-coordinate of the vector represented by the sum of the verb values

|Name            |Datatype                  |Purpose                                                     |
|----------------|--------------------------|------------------------------------------------------------|
|`verbLeft`      |[verb](Verbs-and-Bindings)|[Verb](Verbs-and-Bindings) that moves the point of aim left |
|`verbRight`     |[verb](Verbs-and-Bindings)|[Verb](Verbs-and-Bindings) that moves the point of aim right|
|`verbUp`        |[verb](Verbs-and-Bindings)|[Verb](Verbs-and-Bindings) that moves the point of aim up   |
|`verbDown`      |[verb](Verbs-and-Bindings)|[Verb](Verbs-and-Bindings) that moves the point of aim down |
|`[playerIndex]` |integer                   |Player to target. If not specified, player 0 is used        |
|`[mostRecent]`  |boolean                   |Whether to use the most recent input instead of returning 0 when two verbs conflict. False if unspecified|

&nbsp;

## `input_xy(verbLeft, verbRight, verbUp, verbDown, [playerIndex], [mostRecent])`

*Returns:* Struct, the vector represented by the sum of the verb values

|Name            |Datatype                  |Purpose                                                     |
|----------------|--------------------------|------------------------------------------------------------|
|`verbLeft`      |[verb](Verbs-and-Bindings)|[Verb](Verbs-and-Bindings) that moves the point of aim left |
|`verbRight`     |[verb](Verbs-and-Bindings)|[Verb](Verbs-and-Bindings) that moves the point of aim right|
|`verbUp`        |[verb](Verbs-and-Bindings)|[Verb](Verbs-and-Bindings) that moves the point of aim up   |
|`verbDown`      |[verb](Verbs-and-Bindings)|[Verb](Verbs-and-Bindings) that moves the point of aim down |
|`[playerIndex]` |integer                   |Player to target. If not specified, player 0 is used        |
|`[mostRecent]`  |boolean                   |Whether to use the most recent input instead of returning 0 when two verbs conflict. False if unspecified|

The struct returned by this function contains two member variables: `.x` and `.y`.

!> This function returns a `static` struct. Do not keep a permanent reference to this struct! It is liable to change value unexpectedly.

&nbsp;

## `input_xy_quick_pressed(verbLeft, verbRight, verbUp, verbDown, [playerIndex])`

*Returns:* Boolean, whether the analogue inputs registered a quick tap this frame

|Name            |Datatype                  |Purpose                                                     |
|----------------|--------------------------|------------------------------------------------------------|
|`verbLeft`      |[verb](Verbs-and-Bindings)|[Verb](Verbs-and-Bindings) that moves the point of aim left |
|`verbRight`     |[verb](Verbs-and-Bindings)|[Verb](Verbs-and-Bindings) that moves the point of aim right|
|`verbUp`        |[verb](Verbs-and-Bindings)|[Verb](Verbs-and-Bindings) that moves the point of aim up   |
|`verbDown`      |[verb](Verbs-and-Bindings)|[Verb](Verbs-and-Bindings) that moves the point of aim down |
|`[playerIndex]` |integer                   |Player to target. If not specified, player 0 is used        |

!> Only analogue inputs can trigger quick taps. This function will return `false` if any digital input is used.

&nbsp;

## `input_radial_sector(verbLeft, verbRight, verbUp, verbDown, [minAngle], [maxAngle], [minMagnitude], [maxMagnitude], [playerIndex])`

*Returns:* Boolean, whether the vector represented by the sum of the verb values points to the radial sector indicated by angle and magnitude bounds

|Name            |Datatype                  |Purpose                                                                                                                                 |
|----------------|--------------------------|----------------------------------------------------------------------------------------------------------------------------------------|
|`verbLeft`      |[verb](Verbs-and-Bindings)|[Verb](Verbs-and-Bindings) that moves the point of aim left                                                                             |
|`verbRight`     |[verb](Verbs-and-Bindings)|[Verb](Verbs-and-Bindings) that moves the point of aim right                                                                            |
|`verbUp`        |[verb](Verbs-and-Bindings)|[Verb](Verbs-and-Bindings) that moves the point of aim up                                                                               |
|`verbDown`      |[verb](Verbs-and-Bindings)|[Verb](Verbs-and-Bindings) that moves the point of aim down                                                                             |
|`[minAngle]`    |number                    |Minimum angle for the sector. If not specified, `0` is used                                                                             |
|`[maxAngle]`    |number                    |Maximum angle for the sector. If not specified, `360` is used                                                                           |
|`[minMagnitude]`|number                    |Minimum magnitude for the sector. Must be between `0` (centre of the circle) and `1` (edge of the circle). If not specified, `0` is used|
|`[maxMagnitude]`|number                    |Maximum magnitude for the sector. Must be between `0` (centre of the circle) and `1` (edge of the circle). If not specified, `1` is used|
|`[playerIndex]` |integer                   |Player to target. If not specified, player 0 is used                                                                                    |
