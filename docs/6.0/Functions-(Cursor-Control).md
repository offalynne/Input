# Functions (Cursor)


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

## …cursor_limit_boundary

`input_cursor_limit_boundary([margin=0], [playerIndex])`

<!-- tabs:start -->

#### **Description**

**Returns:** N/A (`undefined`)

|Name           |Datatype|Purpose                                             |
|---------------|--------|----------------------------------------------------|
|`[margin]`     |number  |Amount to reduce the bounding box by                |
|`[playerIndex]`|integer |Player to target. If not specified, player 0 is used|

Limits the cursor’s motion inside the visible portion of the game window. If a margin greater than zero is specified then the bounding box will be smaller. The exact position and size of the bounding box that limits the cursor's movement is determined by the coordinate space set by `input_cursor_coordinate_space_set()`:

|Coord Space|Bounding Box                                                                                              |
|-----------|----------------------------------------------------------------------------------------------------------|
|`.ROOM`    |Uses the position and size of view camera 0. If no view is enabled, limited to the room's width and height|
|`.GUI`     |Uses the width and height of the GUI layer (as set by GameMaker's native `display_set_gui_size()`)        |
|`.DEVICE`  |Uses the width and height of the window (on Windows, Mac, and Linux) or the device's screen               |

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

|Name              |Datatype|Purpose                                          |
|------------------|--------|-------------------------------------------------|
|`.left`           |number  |Left-most limit for the bounding box             |
|`.top`            |number  |Top-most limit for the bounding box              |
|`.right`          |number  |Right-most limit for the bounding box            |
|`.bottom`         |number  |Bottom-most limit for the bounding box           |
|`.circle_x`       |number  |x-coordinate of the centre of the bounding circle|
|`.circle_y`       |number  |y-coordinate of the centre of the bounding circle|
|`.circle_radius`  |number  |Radius of the bounding circle                    |
|`.boundary_margin`|number  |Size of the boundary margin                      |

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