# Functions (Cursor)

&nbsp;

The "cursor" is Input's own native solution for cross-platform and cross-device mouse emulation. The cursor allows quick and easy replication of mouse-like behaviour whilst using a gamepad or keyboard. The cursor can also be directly driven by the mouse or a touchscreen as well in situations where that is available.

&nbsp;

## …cursor_x

`input_cursor_x([playerIndex], [coordSpace])`

<!-- tabs:start -->

#### **Description**

**Returns:** Number, the x-coordinate of the given player's cursor

|Name           |Datatype                |Purpose                                                                                                        |
|---------------|------------------------|---------------------------------------------------------------------------------------------------------------|
|`[playerIndex]`|number                  |Player to target. If not specified, player 0 is used                                                           |
|`[coordSpace]` |`INPUT_COORD_SPACE` enum|Coordinate space to use. If not specified, the coordinate space set by `input_cursor_coord_space_set()` is used|

Please see `input_cursor_coord_space_set()` for information on the `INPUT_COORD_SPACE` enum.

#### **Example**

```gml
//TODO lol
```

<!-- tabs:end -->

&nbsp;

## …cursor_y

`input_cursor_y([playerIndex], [coordSpace])`

<!-- tabs:start -->

#### **Description**

**Returns:** Number, the y-coordinate of the given player's cursor

|Name           |Datatype                |Purpose                                                                                                        |
|---------------|------------------------|---------------------------------------------------------------------------------------------------------------|
|`[playerIndex]`|number                  |Player to target. If not specified, player 0 is used                                                           |
|`[coordSpace]` |`INPUT_COORD_SPACE` enum|Coordinate space to use. If not specified, the coordinate space set by `input_cursor_coord_space_set()` is used|

Please see `input_cursor_coord_space_set()` for information on the `INPUT_COORD_SPACE` enum.

#### **Example**

```gml
//TODO lol
```

<!-- tabs:end -->

&nbsp;

## …cursor_dx

`input_cursor_dx([playerIndex], [coordSpace])`

<!-- tabs:start -->

#### **Description**

**Returns:** Number, how far the cursor has moved in the x-axis between frames

|Name           |Datatype                |Purpose                                                                                                        |
|---------------|------------------------|---------------------------------------------------------------------------------------------------------------|
|`[playerIndex]`|number                  |Player to target. If not specified, player 0 is used                                                           |
|`[coordSpace]` |`INPUT_COORD_SPACE` enum|Coordinate space to use. If not specified, the coordinate space set by `input_cursor_coord_space_set()` is used|

Please see `input_cursor_coord_space_set()` for information on the `INPUT_COORD_SPACE` enum.

#### **Example**

```gml
//TODO lol
```

<!-- tabs:end -->

&nbsp;

## …cursor_dy

`input_cursor_dy([playerIndex], [coordSpace])`

<!-- tabs:start -->

#### **Description**

**Returns:** Number, how far the cursor has moved in the y-axis between frames

|Name           |Datatype                |Purpose                                                                                                        |
|---------------|------------------------|---------------------------------------------------------------------------------------------------------------|
|`[playerIndex]`|number                  |Player to target. If not specified, player 0 is used                                                           |
|`[coordSpace]` |`INPUT_COORD_SPACE` enum|Coordinate space to use. If not specified, the coordinate space set by `input_cursor_coord_space_set()` is used|

Please see `input_cursor_coord_space_set()` for information on the `INPUT_COORD_SPACE` enum.

#### **Example**

```gml
//TODO lol
```

<!-- tabs:end -->

&nbsp;

## …cursor_set

`input_cursor_set(x, y, [playerIndex], [relative])`

<!-- tabs:start -->

#### **Description**

**Returns:** N/A (`undefined`)

|Name           |Datatype|Purpose                                                                    |
|---------------|--------|---------------------------------------------------------------------------|
|`x`            |number  |New x-coordinate for the cursor                                            |
|`y`            |number  |New y-coordinate for the cursor                                            |
|`[playerIndex]`|integer |Player to target. If not specified, player 0 is used                       |
|`[relative]`   |boolean |Whether the new coordinate should be relative (added) to the old coordinate|

#### **Example**

```gml
//TODO lol
```

<!-- tabs:end -->

&nbsp;

## …cursor_translate

`input_cursor_translate([x], [y], duration, [playerIndex], [relative])`

<!-- tabs:start -->

#### **Description**

**Returns:** N/A (`undefined`)

|Name           |Datatype|Purpose                                                                                                                         |
|---------------|--------|--------------------------------------------------------------------------------------------------------------------------------|
|`[x]`          |number  |Target x-coordinate for the cursor. If not specified, this axis is unbound during translation                                   |
|`[y]`          |number  |Target y-coordinate for the cursor. If not specified, this axis is unbound during translation                                   |
|`duration`     |number  |Duration of the translation, the units of which are determined by `INPUT_TIMER_MILLISECONDS`                                    |
|`[playerIndex]`|integer |Player to target. If not specified, player 0 is used                                                                            |
|`[relative]`   |boolean |Whether the target cursor position is relative to the current cursor position. If not specified, the target position is absolute|

Whilst the cursor is being moved, cursor limits will be applied but cursor elastic will **not** be applied.

!> This function is unlikely to work in a satisfactory manner if the cursor is being moved with a non-captured mouse. Please see [`input_mouse_capture_set()`](https://www.jujuadams.com/Input/#/5.2/Functions-(Mouse)?id=input_mouse_capture_setstate-sensitivity) for details on how to capture the mouse.

#### **Example**

```gml
//TODO lol
```

<!-- tabs:end -->

&nbsp;

## …cursor_speed_set

`input_cursor_speed_set(speed, [playerIndex])`

<!-- tabs:start -->

#### **Description**

**Returns:** N/A (`undefined`)

|Name           |Datatype|Purpose                                                           |
|---------------|--------|------------------------------------------------------------------|
|`speed`        |number  |Movement speed for the cursor when using keyboard or gamepad input|
|`[playerIndex]`|integer |Player to target. If not specified, player 0 is used              |

?> Cursor speed is only valid for keyboard and gamepad input.

#### **Example**

```gml
//TODO lol
```

<!-- tabs:end -->

&nbsp;

## …cursor_speed_get

`input_cursor_speed_get([playerIndex])`

<!-- tabs:start -->

#### **Description**

**Returns:** Number, the cursor speed when using keyboard or gamepad input

|Name           |Datatype|Purpose                                             |
|---------------|--------|----------------------------------------------------|
|`[playerIndex]`|integer |Player to target. If not specified, player 0 is used|

#### **Example**

```gml
//TODO lol
```

<!-- tabs:end -->

&nbsp;

## …cursor_coord_space_set

`input_cursor_coord_space_set(coordSpace, [playerIndex])`

<!-- tabs:start -->

#### **Description**

**Returns:** N/A (`undefined`)

|Name           |Datatype                |Purpose                                                                                                   |
|---------------|------------------------|----------------------------------------------------------------------------------------------------------|
|`coordSpace`   |`INPUT_COORD_SPACE` enum|The coordinate space the cursor will operate in when using a mouse to control a player's cursor. See below|
|`[playerIndex]`|integer                 |Player to target. If not specified, player 0 is used                                                      |

This function changes what coordinate space is used as a reference for setting the cursor's position with mouse input.

`INPUT_COORD_SPACE` contains the following members:

|Name     |Purpose                                                                                   |
|---------|------------------------------------------------------------------------------------------|
|`.ROOM`  |Room coordinates; should be the same as `mouse_x` and `mouse_y`. This is the default value|
|`.GUI`   |GUI coordinates                                                                           |
|`.DEVICE`|Raw device-space coordinates                                                              |

#### **Example**

```gml
//TODO lol
```

<!-- tabs:end -->

&nbsp;

## …cursor_coord_space_get

`input_cursor_coord_space_get([playerIndex])`

<!-- tabs:start -->

#### **Description**

**Returns:** A member of `INPUT_COORD_SPACE`, the cursor coordinate space that has been set

|Name           |Datatype|Purpose                                             |
|---------------|--------|----------------------------------------------------|
|`[playerIndex]`|integer |Player to target. If not specified, player 0 is used|

#### **Example**

```gml
//TODO lol
```

<!-- tabs:end -->

&nbsp;

## …cursor_limit_aabb

`input_cursor_limit_aabb(left, top, right, bottom, [playerIndex])`

<!-- tabs:start -->

#### **Description**

**Returns:** N/A (`undefined`)

|Name           |Datatype|Purpose                                             |
|---------------|--------|----------------------------------------------------|
|`left`         |number  |Left-most limit for the bounding box                |
|`top`          |number  |Top-most limit for the bounding box                 |
|`right`        |number  |Right-most limit for the bounding box               |
|`bottom`       |number  |Bottom-most limit for the bounding box              |
|`[playerIndex]`|integer |Player to target. If not specified, player 0 is used|

Limits the cursor's motion inside an axis-aligned bounding box with the given coordinates.

#### **Example**

```gml
//TODO lol
```

<!-- tabs:end -->

&nbsp;

## …cursor_limit_circle

`input_cursor_limit_circle(x, y, radius, [playerIndex])`

<!-- tabs:start -->

#### **Description**

**Returns:** N/A (`undefined`)

|Name           |Datatype|Purpose                                             |
|---------------|--------|----------------------------------------------------|
|`x`            |number  |x-coordinate of the centre of the bounding circle   |
|`y`            |number  |y-coordinate of the centre of the bounding circle   |
|`radius`       |number  |Radius of the bounding circle                       |
|`[playerIndex]`|integer |Player to target. If not specified, player 0 is used|

Limits the cursor's motion inside a circle centred at the given point.

#### **Example**

```gml
//TODO lol
```

<!-- tabs:end -->

&nbsp;

## …cursor_limit_remove

`input_cursor_limit_remove([playerIndex])`

<!-- tabs:start -->

#### **Description**

**Returns:** N/A (`undefined`)

|Name           |Datatype|Purpose                                             |
|---------------|--------|----------------------------------------------------|
|`[playerIndex]`|integer |Player to target. If not specified, player 0 is used|

Removes any cursor limits you have set using `input_cursor_limit_aabb()` or `input_cursor_limit_circle()`.

#### **Example**

```gml
//TODO lol
```

<!-- tabs:end -->

&nbsp;

## …cursor_limit_get

`input_cursor_limit_get([playerIndex])`

<!-- tabs:start -->

#### **Description**

**Returns:** Struct, the cursor limit state. See below

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

#### **Example**

```gml
//TODO lol
```

<!-- tabs:end -->

&nbsp;

## …cursor_elastic_set

`input_cursor_elastic_set(x, y, strength, [playerIndex], [moveCursor])`

<!-- tabs:start -->

#### **Description**

**Returns:** N/A (`undefined`)

|Name           |Datatype|Purpose                                                                                   |
|---------------|--------|------------------------------------------------------------------------------------------|
|`x`            |number  |x-coordinate of the origin of the elastic force                                           |
|`y`            |number  |y-coordinate of the origin of the elastic force                                           |
|`strength`     |number  |Strength of the elastic force, from `0` to `1`                                            |
|`[playerIndex]`|integer |Player to target. If not specified, player 0 is used                                      |
|`[moveCursor]` |boolean |Whether to move the cursor to match the movement of the elastic origin. Defaults to `true`|

Sets up a springy force that pulls the cursor towards the given point. This is useful for building aiming systems for shooters and works especially well with `input_cursor_limit_circle()`.

?> This feature is only applied when using a keyboard or gamepad to control the cursor.

#### **Example**

```gml
//TODO lol
```

<!-- tabs:end -->

&nbsp;

## …cursor_elastic_remove

`input_cursor_elastic_remove([playerIndex])`

<!-- tabs:start -->

#### **Description**

**Returns:** N/A (`undefined`)

|Name           |Datatype|Purpose                                             |
|---------------|--------|----------------------------------------------------|
|`[playerIndex]`|integer |Player to target. If not specified, player 0 is used|

Removes an elastic force that has been added to the given player's cursor.

#### **Example**

```gml
//TODO lol
```

<!-- tabs:end -->

&nbsp;

## …cursor_elastic_get

`input_cursor_elastic_get([playerIndex])`

<!-- tabs:start -->

#### **Description**

**Returns:** Struct, the elastic state. See below

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

#### **Example**

```gml
//TODO lol
```

<!-- tabs:end -->

&nbsp;

## …cursor_mouse_enabled_set

`input_cursor_mouse_enabled_set(state, [playerIndex])`

<!-- tabs:start -->

#### **Description**

**Returns:** N/A (`undefined`)

|Name           |Datatype|Purpose                                               |
|---------------|--------|------------------------------------------------------|
|`state`        |boolean |Whether the player can use a mouse can move the cursor|
|`[playerIndex]`|integer |Player to target. If not specified, player 0 is used  |

Input will only allow a mouse to move the cursor if the player in question has been assigned the `INPUT_MOUSE` source. `input_cursor_mouse_enabled_set()` allows you further control on top of this behaviour.

#### **Example**

```gml
//TODO lol
```

<!-- tabs:end -->

&nbsp;

## …cursor_mouse_enabled_get

`input_cursor_mouse_enabled_set(state, [playerIndex])`

<!-- tabs:start -->

#### **Description**

**Returns:** Boolean, whether the player can use a mouse can move the cursor

|Name           |Datatype|Purpose                                             |
|---------------|--------|----------------------------------------------------|
|`[playerIndex]`|integer |Player to target. If not specified, player 0 is used|

#### **Example**

```gml
//TODO lol
```

<!-- tabs:end -->