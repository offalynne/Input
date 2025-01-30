# Mouse & Touch

&nbsp;

## …MouseRoomX

`InputMouseRoomX()`

<!-- tabs:start -->

#### **Description**

**Returns:** Number, the x coordinate of the mouse point in room-space

|Name|Datatype|Purpose|
|----|--------|-------|
|None|        |       |

Returns the x coordinate of the mouse point in room-space.

<!-- tabs:end -->

&nbsp;

## …MouseRoomY

`InputMouseRoomY()`

<!-- tabs:start -->

#### **Description**

**Returns:** Number, the y coordinate of the mouse point in room-space

|Name|Datatype|Purpose|
|----|--------|-------|
|None|        |       |

Returns the y coordinate of the mouse point in room-space.

<!-- tabs:end -->

&nbsp;

## …MouseGuiX

`InputMouseGuiX()`

<!-- tabs:start -->

#### **Description**

**Returns:** Number, the x coordinate of the mouse point in GUI-space

|Name|Datatype|Purpose|
|----|--------|-------|
|None|        |       |

Returns the x coordinate of the mouse point in GUI-space.

<!-- tabs:end -->

&nbsp;

## …MouseGuiY

`InputMouseGuiY()`

<!-- tabs:start -->

#### **Description**

**Returns:** Number, the y coordinate of the mouse point in GUI-space

|Name|Datatype|Purpose|
|----|--------|-------|
|None|        |       |

Returns the y coordinate of the mouse point in GUI-space.

<!-- tabs:end -->

&nbsp;

## …MouseDeviceX

`InputMouseDeviceX()`

<!-- tabs:start -->

#### **Description**

**Returns:** Number, the x coordinate of the mouse point in device-space

|Name|Datatype|Purpose|
|----|--------|-------|
|None|        |       |

Returns the x coordinate of the mouse point in device-space.

<!-- tabs:end -->

&nbsp;

## …MouseDeviceY

`InputMouseDeviceY()`

<!-- tabs:start -->

#### **Description**

**Returns:** Number, the y coordinate of the mouse point in device-space

|Name|Datatype|Purpose|
|----|--------|-------|
|None|        |       |

Returns the y coordinate of the mouse point in device-space.

Returns 

<!-- tabs:end -->

&nbsp;

## …MouseCheck

`InputMouseCheck([binding=mb_left])`

<!-- tabs:start -->

#### **Description**

**Returns:** Boolean, whether the given mouse button is currently held down

|Name       |Datatype     |Purpose                                                  |
|-----------|-------------|---------------------------------------------------------|
|`[binding]`|mouse binding|Binding to check. If not specified, defaults to `mb_left`|

Returns whether the given mouse button is currently held down. The binding should be one of the following:

- `mb_left`
- `mb_middle`
- `mb_right`
- `mb_any`
- `mb_none`
- `mb_side1`
- `mb_side2`
- `mb_wheel_up`
- `mb_wheel_down`

<!-- tabs:end -->

&nbsp;

## …MousePressed

`InputMousePressed([binding=mb_left])`

<!-- tabs:start -->

#### **Description**

**Returns:** Boolean, whether the given mouse button is newly pressed this frame

|Name       |Datatype     |Purpose                                                  |
|-----------|-------------|---------------------------------------------------------|
|`[binding]`|mouse binding|Binding to check. If not specified, defaults to `mb_left`|

Returns whether the given mouse button is newly pressed this frame. The binding should be one of the following:

- `mb_left`
- `mb_middle`
- `mb_right`
- `mb_any`
- `mb_none`
- `mb_side1`
- `mb_side2`
- `mb_wheel_up`
- `mb_wheel_down`

<!-- tabs:end -->

&nbsp;

## …MouseReleased

`InputMouseReleased([binding=mb_left])`

<!-- tabs:start -->

#### **Description**

**Returns:** Boolean, whether the given mouse button was newly released this frame

|Name       |Datatype     |Purpose                                                  |
|-----------|-------------|---------------------------------------------------------|
|`[binding]`|mouse binding|Binding to check. If not specified, defaults to `mb_left`|

Returns whether the given mouse button was newly released this frame. The binding should be one of the following:

- `mb_left`
- `mb_middle`
- `mb_right`
- `mb_any`
- `mb_none`
- `mb_side1`
- `mb_side2`
- `mb_wheel_up`
- `mb_wheel_down`

<!-- tabs:end -->

&nbsp;

## …MouseMoved

`InputMouseMoved()`

<!-- tabs:start -->

#### **Description**

**Returns:** Boolean, whether the mouse has moved between frames

|Name|Datatype|Purpose|
|----|--------|-------|
|None|        |       |

Returns whether the mouse has moved between frames.

<!-- tabs:end -->

&nbsp;

## …MouseSetBlocked

`InputMouseSetBlocked(state)`

<!-- tabs:start -->

#### **Description**

**Returns:** N/A (`undefined`)

|Name   |Datatype|Purpose                              |
|-------|--------|-------------------------------------|
|`state`|boolean |Whether mouse input should be blocked|

Sets whether mouse input should be blocked. Blocked mouse input will freeze mouse position coordinates and will cause  mouse checkers to return `false`.

<!-- tabs:end -->

&nbsp;

## …MouseGetBlocked

`InputMouseGetBlocked()`

<!-- tabs:start -->

#### **Description**

**Returns:** Boolean, whether mouse input is blocked

|Name|Datatype|Purpose|
|----|--------|-------|
|None|        |       |

Returns whether mouse input is blocked.

<!-- tabs:end -->
