# Plug-in: Cursor

&nbsp;

## Config

`__InputCursorConfig()` holds macros that affect the general behavior of cursors. This script never needs to be directly called in your code, but the script and the macros it contains must be present in a project for the plug-in to work.

|Name                              |Typical Value             |Purpose                                                                                                 |
|----------------------------------|--------------------------|--------------------------------------------------------------------------------------------------------|
|`INPUT_CURSOR_PRIMARY_COORD_SPACE`|`INPUT_CURSOR_ROOM_SPACE` |Coordinate space that cursors should exist in                                                           |
|`INPUT_CURSOR_MOUSE_CONTROL`      |`true`                    |Whether a player's cursor should follow the mouse when using the `INPUT_KBM` deivce (keyboard and mouse)|
|`INPUT_CURSOR_CLUSTER`            |`-1`                      |Cluster to read to move cursors when using a gamepad or keyboard. A value of `-1` indicates no cluster  |
|`INPUT_CURSOR_DEFAULT_SPEED`      |`8`                       |Default speed of the cursor when using a gamepad or keyboard                                            |
|`INPUT_CURSOR_EXPONENT`           |`1`                       |Movement exponent, applied when using a gamepad or keyboard                                             |

&nbsp;

## Constants

`__InputCursorConstants()` holds macros that can (and should) be used when using the Cursor plug-in.

|Name                         |Typical Value|Meaning                                                                                                 |
|-----------------------------|-------------|--------------------------------------------------------------------------------------------------------|
|`INPUT_CURSOR_ROOM_SPACE`    |`0`          |Coordinate system "in the room". This is the coordinate system used for Draw event and Step events      |
|`INPUT_CURSOR_GUI_SPACE`     |`1`          |Coordinate system on the GUI layer. This is the coordinate system used for Draw GUI event               |
|`INPUT_CURSOR_DEVICE_SPACE`  |`2`          |Coordinate system for the game window itself. This is the coordinate system used in the Pre Draw event  |
|`INPUT_CURSOR_LIMIT_NONE`    |`0`          |No limit applied                                                                                        |
|`INPUT_CURSOR_LIMIT_BOUNDARY`|`1`          |Cursor limited to the game window                                                                       |
|`INPUT_CURSOR_LIMIT_AABB`    |`2`          |Cursor limited to an axis-aligned boundary box                                                          |
|`INPUT_CURSOR_LIMIT_CIRCLE`  |`3`          |Cursor limited to a circle                                                                              |

&nbsp;

## …CursorX

`InputCursorX([playerIndex=0], [coordSpace])`

<!-- tabs:start -->

#### **Description**

**Returns:** Number, the x-position of the player's cursor

|Name           |Datatype|Purpose                                                                              |
|---------------|--------|-------------------------------------------------------------------------------------|
|`[playerIndex]`|integer |Player to target. If not specified, player 0 is used                                 |
|`[coordSpace]` |integer |Coordinate space to use. If not specified, `INPUT_CURSOR_PRIMARY_COORD_SPACE` is used|

Returns the x-position of the player's cursor in the coordinate space of your choosing. If no coordinate space is provided then this function will use the coordinate space set by `INPUT_CURSOR_PRIMARY_COORD_SPACE`.

#### **Example**

```gml
{

}
```

<!-- tabs:end -->

&nbsp;

## …CursorY

`InputCursorY([playerIndex=0], [coordSpace])`

<!-- tabs:start -->

#### **Description**

**Returns:** Number, the y-position of the player's cursor

|Name           |Datatype|Purpose                                                                              |
|---------------|--------|-------------------------------------------------------------------------------------|
|`[playerIndex]`|integer |Player to target. If not specified, player 0 is used                                 |
|`[coordSpace]` |integer |Coordinate space to use. If not specified, `INPUT_CURSOR_PRIMARY_COORD_SPACE` is used|

Returns the y-position of the player's cursor in the coordinate space of your choosing. If no coordinate space is provided then this function will use the coordinate space set by `INPUT_CURSOR_PRIMARY_COORD_SPACE`.

#### **Example**

```gml
{

}
```

<!-- tabs:end -->

&nbsp;

## …CursorSet

`InputCursorSet(x, y, [playerIndex=0], [relative=false])`

<!-- tabs:start -->

#### **Description**

**Returns:** N/A (`undefined`)

|Name           |Datatype|Purpose                                                                                               |
|---------------|--------|------------------------------------------------------------------------------------------------------|
|`x`            |number  |x position to set for the cursor                                                                      |
|`y`            |number  |y position to set for the cursor                                                                      |
|`[playerIndex]`|integer |Player to target. If not specified, player 0 is used                                                  |
|`[relative]`   |boolean |Whether the cursor should move relative to its current position. If not specified, defaults to `false`|

Sets the position of the player's cursor in the global coordinate space, as set by `INPUT_CURSOR_PRIMARY_COORD_SPACE`.

#### **Example**

```gml
{

}
```

<!-- tabs:end -->

&nbsp;

## …CursorDX

`InputCursorDX([playerIndex=0], [coordSpace])`

<!-- tabs:start -->

#### **Description**

**Returns:** Number, the movement in the x-axis for the player's cursor

|Name           |Datatype|Purpose                                                                              |
|---------------|--------|-------------------------------------------------------------------------------------|
|`[playerIndex]`|integer |Player to target. If not specified, player 0 is used                                 |
|`[coordSpace]` |integer |Coordinate space to use. If not specified, `INPUT_CURSOR_PRIMARY_COORD_SPACE` is used|

Returns the movement in the x-axis for the player's cursor in the coordinate space of your choosing. If no coordinate space is provided then this function will use the coordinate space `INPUT_CURSOR_PRIMARY_COORD_SPACE`.

#### **Example**

```gml
{

}
```

<!-- tabs:end -->

&nbsp;

## …CursorDY

`InputCursorDY([playerIndex=0], [coordSpace])`

<!-- tabs:start -->

#### **Description**

**Returns:** Number, the movement in the y-axis for the player's cursor

|Name           |Datatype|Purpose                                                                              |
|---------------|--------|-------------------------------------------------------------------------------------|
|`[playerIndex]`|integer |Player to target. If not specified, player 0 is used                                 |
|`[coordSpace]` |integer |Coordinate space to use. If not specified, `INPUT_CURSOR_PRIMARY_COORD_SPACE` is used|

Returns the movement in the y-axis for the player's cursor in the coordinate space of your choosing. If no coordinate space is provided then this function will use the coordinate space `INPUT_CURSOR_PRIMARY_COORD_SPACE`.

#### **Example**

```gml
{

}
```

<!-- tabs:end -->

&nbsp;

## …CursorSetSpeed

`InputCursorSetSpeed(speed, [playerIndex=0])`

<!-- tabs:start -->

#### **Description**

**Returns:** N/A (`undefined`)

|Name           |Datatype|Purpose                                             |
|---------------|--------|----------------------------------------------------|
|`speed`        |number  |Speed to set, measured in pixels per frame          |
|`[playerIndex]`|integer |Player to target. If not specified, player 0 is used|

Sets the speed of the player's cursor, measured in pixels per frame and as such is *not* inherently delta-timed. The default speed if this function is never called is set by the `INPUT_CURSOR_DEFAULT_SPEED` macro. Cursor movement is further affected by an exponent factor, given by the value of `INPUT_CURSOR_EXPONE

#### **Example**

```gml
{

}
```

<!-- tabs:end -->

&nbsp;

## …CursorGetSpeed

`InputCursorGetSpeed([playerIndex=0])`

<!-- tabs:start -->

#### **Description**

**Returns:** Number, the speed of the player's cursor

|Name           |Datatype|Purpose                                             |
|---------------|--------|----------------------------------------------------|
|`[playerIndex]`|integer |Player to target. If not specified, player 0 is used|

Returns the speed of the player's cursor, measured in pixels per frame.

#### **Example**

```gml
{

}
```

<!-- tabs:end -->

&nbsp;

## …CursorElasticSet

`InputCursorElasticSet(x, y, strength, [playerIndex=0], [moveCursor=true])`

<!-- tabs:start -->

#### **Description**

**Returns:** N/A (`undefined`)

|Name           |Datatype|Purpose                                                                                                  |
|---------------|--------|---------------------------------------------------------------------------------------------------------|
|`x`            |number  |x position of the elastic force for the cursor                                                           |
|`y`            |number  |y position of the elastic force for the cursor                                                           |
|`strength`     |number  |Strength of the elastic force. This must be greater than `0` and less than `1`                           |
|`[playerIndex]`|integer |Player to target. If not specified, player 0 is used                                                     |
|`[moveCursor]` |boolean |Whether to move the cursor when the elastic attraction point moves. If not specified, defaults to `false`|

Sets up a springy force that pulls the cursor towards the given point. This is useful for building aiming systems for shooters and works especially well with `InputCursorLimitCircle()`. The x/y position for the center of the force is in the primary coordinate space, as given by `INPUT_CURSOR_PRIMARY_COORD_SPACE`. The `strength` parameter should be a value greater than `0` and less than `1`.

If `moveCursor` is set to `true` then the cursor will be moved by the same amount that the center of the elastic force has moved. Again, this is convenient for shoots where the elastic force is typically centered on the player and moving the elastic force would also typically need to move the cursor by the same amount.

#### **Example**

```gml
{

}
```

<!-- tabs:end -->

&nbsp;

## …CursorElasticGet

`InputCursorElasticGet([playerIndex=0])`

<!-- tabs:start -->

#### **Description**

**Returns:** Struct, the parameters for the elastic force on the cursor

|Name           |Datatype|Purpose                                             |
|---------------|--------|----------------------------------------------------|
|`[playerIndex]`|integer |Player to target. If not specified, player 0 is used|

Returns the elastic properties for the player's cursor as a struct. The returned struct contains the following member variables:

|Variable   |Datatype |Usage                                                                         |
|-----------|---------|------------------------------------------------------------------------------|
|`.enabled` |boolean  |Whether the elastic force has been set up on the cursor                       |
|`.x`       |number   |x position of the elastic force for the cursor                                |
|`.y`       |number   |y position of the elastic force for the cursor                                |
|`.strength`|number   |Strength of the elastic force. This will be greater than `0` and less than `1`|

!> If no elastic state has been set, `.enabled` will be `false` and the other member variables will be set to `undefined`. 

#### **Example**

```gml
{

}
```

<!-- tabs:end -->

&nbsp;

## …CursorElasticRemove

`InputCursorElasticRemove([playerIndex=0])`

<!-- tabs:start -->

#### **Description**

**Returns:** N/A (`undefined`)

|Name           |Datatype|Purpose                                             |
|---------------|--------|----------------------------------------------------|
|`[playerIndex]`|integer |Player to target. If not specified, player 0 is used|

Removes the elastic force on a cursor.

#### **Example**

```gml
{

}
```

<!-- tabs:end -->

&nbsp;

## …CursorLimitCircle

`InputCursorLimitCircle(x, y, radius, [playerIndex=0])`

<!-- tabs:start -->

#### **Description**

**Returns:** N/A (`undefined`)

|Name           |Datatype|Purpose                                             |
|---------------|--------|----------------------------------------------------|
|`x`            |number  |x position of the center of the circle              |
|`y`            |number  |y position of the center of the circle              |
|`radius`       |number  |Radius of the circle                                |
|`[playerIndex]`|integer |Player to target. If not specified, player 0 is used|

Limits the player's cursor within a circle. The coordinates of the circle are in pixels in the primary coordinate space, `INPUT_CURSOR_PRIMARY_COORD_SPACE`.

#### **Example**

```gml
{

}
```

<!-- tabs:end -->

&nbsp;

## …CursorLimitAABB

`InputCursorLimitAABB(left, top, right, bottom, [playerIndex=0])`

<!-- tabs:start -->

#### **Description**

**Returns:** N/A (`undefined`)

|Name           |Datatype|Purpose                                             |
|---------------|--------|----------------------------------------------------|
|`left`         |number  |Left position of the bounding box                   |
|`top`          |number  |Top position of the bounding box                    |
|`right`        |number  |Right position of the bounding box                  |
|`bottom`       |number  |Bottom position of the bounding box                 |
|`[playerIndex]`|integer |Player to target. If not specified, player 0 is used|

Limits the player's cursor within an axis-aligned bounding box. The coordinates of the bounding box are in pixels in the primary coordinate space, `INPUT_CURSOR_PRIMARY_COORD_SPACE`.

#### **Example**

```gml
{

}
```

<!-- tabs:end -->

&nbsp;

## …CursorLimitBoundary

`InputCursorLimitBoundary([margin=0], [playerIndex=0])`

<!-- tabs:start -->

#### **Description**

**Returns:** N/A (`undefined`)

|Name           |Datatype|Purpose                                             |
|---------------|--------|----------------------------------------------------|
|`[margin]`     |number  |Margin to apply around the game window edge         |
|`[playerIndex]`|integer |Player to target. If not specified, player 0 is used|

Limits the player's cursor inside the visible portion of the game window. You may also specify a margin around the edge of the game window, measured in pixels (in the primary coordinate space).

#### **Example**

```gml
{

}
```

<!-- tabs:end -->

&nbsp;

## …CursorLimitRemove

`InputCursorLimitRemove([margin=0], [playerIndex=0])`

<!-- tabs:start -->

#### **Description**

**Returns:** N/A (`undefined`)

|Name           |Datatype|Purpose                                             |
|---------------|--------|----------------------------------------------------|
|`[playerIndex]`|integer |Player to target. If not specified, player 0 is used|

Removes any limits placed on a player's cursor.

#### **Example**

```gml
{

}
```

<!-- tabs:end -->

&nbsp;

## …CursorLimitGet

`InputCursorLimitGet([margin=0], [playerIndex=0])`

<!-- tabs:start -->

#### **Description**

**Returns:** N/A (`undefined`)

|Name           |Datatype|Purpose                                             |
|---------------|--------|----------------------------------------------------|
|`[playerIndex]`|integer |Player to target. If not specified, player 0 is used|

Returns the parameters of the limit placed on a player's cursor as a struct. The struct contains the following member variables:

|Variable|Datatype |Usage                                          |
|--------|---------|-----------------------------------------------|
|.type`  |integer  |One of the `INPUT_CURSOR_LIMIT_*` macros       |
|.x`     |number   |x position of the center of the limiting circle|
|.y`     |number   |y position of the center of the limiting circle|
|.radius`|number   |Radius of the limiting circle                  |
|.left`  |number   |Left position of the limiting bounding box     |
|.top`   |number   |Top position of the limiting bounding box      |
|.right` |number   |Right position of the limiting bounding box    |
|.bottom`|number   |Bottom position of the limiting bounding box   |
|.margin`|number   |Margin to apply around the game window edge    |

!> Any unnecessary variables for the current cursor limit type will be set to `undefined`.

#### **Example**

```gml
{

}
```

<!-- tabs:end -->
