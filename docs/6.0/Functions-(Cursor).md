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

## …cursor_inverted_set

`input_cursor_inverted_set(state, [playerIndex])`

<!-- tabs:start -->

#### **Description**

**Returns:** N/A (`undefined`)

|Name           |Datatype|Purpose                                                    |
|---------------|--------|-----------------------------------------------------------|
|`state`        |boolean |When the cursor's movement in the y-axis should be inverted|
|`[playerIndex]`|integer |Player to target. If not specified, player 0 is used       |

Cursor y-axis inversion only applies when using a keyboard or gamepad to move the cursor, or when the mouse has been captured (see `input_mouse_capture_set()`).

#### **Example**

```gml
//TODO lol
```

<!-- tabs:end -->

&nbsp;

## …cursor_inverted_get

`input_cursor_inverted_get([playerIndex])`

<!-- tabs:start -->

#### **Description**

**Returns:** Boolean, whether the cursor's y-axis movement is inverted

|Name           |Datatype|Purpose                                             |
|---------------|--------|----------------------------------------------------|
|`[playerIndex]`|integer |Player to target. If not specified, player 0 is used|

#### **Example**

```gml
//TODO lol
```

<!-- tabs:end -->

&nbsp;

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