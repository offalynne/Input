# Functions (Cursor)

&nbsp;

## `input_cursor_x([playerIndex])`

*Returns:* Number, the x-coordinate of the given player's cursor

|Name           |Datatype|Purpose                                             |
|---------------|--------|----------------------------------------------------|
|`[playerIndex]`|number  |Player to target. If not specified, player 0 is used|

&nbsp;

## `input_cursor_y([playerIndex])`

*Returns:* Number, the y-coordinate of the given player's cursor

|Name           |Datatype|Purpose                                             |
|---------------|--------|----------------------------------------------------|
|`[playerIndex]`|number  |Player to target. If not specified, player 0 is used|

&nbsp;

## `input_cursor_previous_x([playerIndex])`

*Returns:* Number, the x-coordinate of the given player's cursor from the previous frame

|Name           |Datatype|Purpose                                             |
|---------------|--------|----------------------------------------------------|
|`[playerIndex]`|number  |Player to target. If not specified, player 0 is used|

&nbsp;

## `input_cursor_previous_y([playerIndex])`

*Returns:* Number, the y-coordinate of the given player's cursor from the previous frame

|Name           |Datatype|Purpose                                             |
|---------------|--------|----------------------------------------------------|
|`[playerIndex]`|number  |Player to target. If not specified, player 0 is used|

&nbsp;

## `input_cursor_set(x, y, [playerIndex], [relative])`

*Returns:* N/A (`undefined`)

|Name           |Datatype|Purpose                                                                    |
|---------------|--------|---------------------------------------------------------------------------|
|`x`            |number  |New x-coordinate for the cursor                                            |
|`y`            |number  |New y-coordinate for the cursor                                            |
|`[playerIndex]`|integer |Player to target. If not specified, player 0 is used                       |
|`[relative]`   |boolean |Whether the new coordinate should be relative (added) to the old coordinate|

&nbsp;

## `input_cursor_translate([x], [y], duration, [playerIndex], [relative])`

*Returns:* N/A (`undefined`)

|Name           |Datatype|Purpose                                                                                                                         |
|---------------|--------|--------------------------------------------------------------------------------------------------------------------------------|
|`[x]`          |number  |Target x-coordinate for the cursor. If not specified, this axis is unbound during translation                                   |
|`[y]`          |number  |Target y-coordinate for the cursor. If not specified, this axis is unbound during translation                                   |
|`duration`     |number  |Duration of the translation, the units of which are determined by `INPUT_TIMER_MILLISECONDS`                                    |
|`[playerIndex]`|integer |Player to target. If not specified, player 0 is used                                                                            |
|`[relative]`   |boolean |Whether the target cursor position is relative to the current cursor position. If not specified, the target position is absolute|

Whilst the cursor is being moved, cursor limits will be applied but cursor elastic will **not** be applied.

!> This function is unlikely to work in a satisfactory manner if the cursor is being moved with a non-captured mouse. Please see [`input_mouse_capture_set()`](https://www.jujuadams.com/Input/#/5.2/Functions-(Mouse)?id=input_mouse_capture_setstate-sensitivity) for details on how to capture the mouse.

&nbsp;

## `input_cursor_speed_set(speed, [playerIndex])`

*Returns:* N/A (`undefined`)

|Name           |Datatype|Purpose                                                           |
|---------------|--------|------------------------------------------------------------------|
|`speed`        |number  |Movement speed for the cursor when using keyboard or gamepad input|
|`[playerIndex]`|integer |Player to target. If not specified, player 0 is used              |

?> Cursor speed is only valid for keyboard and gamepad input.

&nbsp;

## `input_cursor_speed_get([playerIndex])`

*Returns:* Number, the cursor speed when using keyboard or gamepad input

|Name           |Datatype|Purpose                                             |
|---------------|--------|----------------------------------------------------|
|`[playerIndex]`|integer |Player to target. If not specified, player 0 is used|

&nbsp;

## `input_cursor_coord_space_set(coordSpace, [playerIndex])`

*Returns:* N/A (`undefined`)

|Name           |Datatype                |Purpose                                                                                                   |
|---------------|------------------------|----------------------------------------------------------------------------------------------------------|
|`coordSpace`   |`INPUT_COORD_SPACE` enum|The coordinate space the cursor will operate in when using a mouse to control a player's cursor. See below|
|`[playerIndex]`|integer                 |Player to target. If not specified, player 0 is used                                                      |

This function changes what coordinate space is used as a reference for setting the cursor's position with mouse input.

`INPUT_COORD_SPACE` contains the following members:

|Name         |Purpose                                                                                   |
|-------------|------------------------------------------------------------------------------------------|
|`.ROOM`      |Room coordinates; should be the same as `mouse_x` and `mouse_y`. This is the default value|
|`.GUI`       |GUI coordinates                                                                           |
|`.DISPLAY`   |Raw device-space coordinates                                                              |

&nbsp;

## `input_cursor_coord_space_get([playerIndex])`

*Returns:* A member of `INPUT_COORD_SPACE`, the cursor coordinate space that has been set

|Name           |Datatype|Purpose                                             |
|---------------|--------|----------------------------------------------------|
|`[playerIndex]`|integer |Player to target. If not specified, player 0 is used|

&nbsp;

## `input_cursor_limit_aabb(left, top, right, bottom, [playerIndex])`

*Returns:* N/A (`undefined`)

|Name           |Datatype|Purpose                                             |
|---------------|--------|----------------------------------------------------|
|`left`         |number  |Left-most limit for the bounding box                |
|`top`          |number  |Top-most limit for the bounding box                 |
|`right`        |number  |Right-most limit for the bounding box               |
|`bottom`       |number  |Bottom-most limit for the bounding box              |
|`[playerIndex]`|integer |Player to target. If not specified, player 0 is used|

Limits the cursor's motion inside an axis-aligned bounding box with the given coordinates.

&nbsp;

## `input_cursor_limit_circle(x, y, radius, [playerIndex])`

*Returns:* N/A (`undefined`)

|Name           |Datatype|Purpose                                             |
|---------------|--------|----------------------------------------------------|
|`x`            |number  |x-coordinate of the centre of the bounding circle   |
|`y`            |number  |y-coordinate of the centre of the bounding circle   |
|`radius`       |number  |Radius of the bounding circle                       |
|`[playerIndex]`|integer |Player to target. If not specified, player 0 is used|

Limits the cursor's motion inside a circle centred at the given point.

&nbsp;

## `input_cursor_limit_remove([playerIndex])`

*Returns:* N/A (`undefined`)

|Name           |Datatype|Purpose                                             |
|---------------|--------|----------------------------------------------------|
|`[playerIndex]`|integer |Player to target. If not specified, player 0 is used|

Removes any cursor limits you have set using `input_cursor_limit_aabb()` or `input_cursor_limit_circle()`.

&nbsp;

## `input_cursor_limit_get([playerIndex])`

*Returns:* Struct, the cursor limit state. See below

|Name           |Datatype|Purpose                                             |
|---------------|--------|----------------------------------------------------|
|`[playerIndex]`|integer |Player to target. If not specified, player 0 is used|

The struct returned by this function contains the following member variables:

|Name            |Datatype|Purpose                                          |
|----------------|--------|-------------------------------------------------|
|`.left`         |number  |Left-most limit for the bounding box             |
|`.top`          |number  |Top-most limit for the bounding box              |
|`.right`        |number  |Right-most limit for the bounding box            |
|`.bottom`       |number  |Bottom-most limit for the bounding box           |
|`.circle_x`     |number  |x-coordinate of the centre of the bounding circle|
|`.circle_y`     |number  |y-coordinate of the centre of the bounding circle|
|`.circle_radius`|number  |Radius of the bounding circle                    |

!> Values in the returned struct will be `undefined` if the associated limit has not been set.

&nbsp;

## `input_cursor_elastic_set(x, y, strength, [playerIndex])`

*Returns:* N/A (`undefined`)

|Name           |Datatype|Purpose                                             |
|---------------|--------|----------------------------------------------------|
|`x`            |number  |x-coordinate of the origin of the elastic force     |
|`y`            |number  |y-coordinate of the origin of the elastic force     |
|`strength`     |number  |Strength of the elastic force, from `0` to `1`      |
|`[playerIndex]`|integer |Player to target. If not specified, player 0 is used|

Sets up a springy force that pulls the cursor towards the given point. This is useful for building aiming systems for shooters and works especially well with `input_cursor_limit_circle()`.

?> This feature is only applied when using a keyboard or gamepad to control the cursor.

&nbsp;

## `input_cursor_elastic_remove([playerIndex])`

*Returns:* N/A (`undefined`)

|Name           |Datatype|Purpose                                             |
|---------------|--------|----------------------------------------------------|
|`[playerIndex]`|integer |Player to target. If not specified, player 0 is used|

Removes an elastic force that has been added to the given player's cursor.

&nbsp;

## `input_cursor_elastic_get([playerIndex])`

*Returns:* Struct, the elastic state. See below

|Name           |Datatype|Purpose                                             |
|---------------|--------|----------------------------------------------------|
|`[playerIndex]`|integer |Player to target. If not specified, player 0 is used|

The struct returned by this function contains the following member variables:

|Name       |Datatype|Purpose                                        |
|-----------|--------|-----------------------------------------------|
|`.x`       |number  |x-coordinate of the origin of the elastic force|
|`.y`       |number  |y-coordinate of the origin of the elastic force|
|`.strength`|number  |Strength of the elastic force, from `0` to `1` |

!> Values for `.x` and `.y` in the returned struct will be `undefined` if an elastic force has not been set.

&nbsp;

## `input_cursor_translate([x], [y], duration, [playerIndex=0], [relative=false])`

*Returns:* N/A (`undefined`)

|Name           |Datatype|Purpose                                                                                                                                          |
|---------------|--------|-------------------------------------------------------------------------------------------------------------------------------------------------|
|`[x]`          |number  |x-coordinate to move the cursor to. If not specified (the argument is `undefined`) then the current x-coordinate of the cursor is used           |
|`[y]`          |number  |y-coordinate to move the cursor to. If not specified (the argument is `undefined`) then the current x-coordinate of the cursor is used           |
|`duration`     |number  |Duration of the translation. Whether this is in frames or milliseconds is determined by `INPUT_TIMER_MILLISECONDS`                               |
|`[playerIndex]`|integer |Player to target. If not specified, player 0 is used                                                                                             |
|`[relative]`   |boolean |Whether the coordinates provided are relative to the current position of the cursor. If not specified then `false` is used (absolute coordinates)|

Moves a player's virtual cursor to a position, blocking input whilst the cursor is moving.