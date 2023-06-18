# Functions (Virtual Button History)

&nbsp;

Virtual buttons can be configured using the following functions. Many functions return `self` meaning that methods can be chained together as a fluent interface.

&nbsp;

## .record_history

`<virtual button>.record_history(state)`

<!-- tabs:start -->

#### **Description**

**Returns:** `self`

|Name   |Datatype|Purpose|
|-------|--------|-------|
|`state`|boolean |       |

Starts recording touch point history for the virtual button. This can be used to detect swipe and flick gestures.

?> Input only keeps track of a limited number of frames of data. This is controlled by the `INPUT_TOUCH_HISTORY_FRAMES` config macro.

#### **Example**

```gml
//TODO lol
```

<!-- tabs:end -->

&nbsp;

## .get_history

`<virtual button>.get_history()`

<!-- tabs:start -->

#### **Description**

**Returns:** Array of structs, see below

|Name|Datatype|Purpose|
|----|--------|-------|
|None|        |       |

Structs in the returned array contain x/y coordinate pairs. These coordinates are the position of the touch point captured by the virtual button, going back into the past. New data is pushed into the array every frame, with index 0 in the array being 1 frame before present, the index 1 being 2 frames before presents, and so on.

?> All coordinates and positions are in GUI-space.

#### **Example**

```gml
//TODO lol
```

<!-- tabs:end -->

&nbsp;

## .get_history_direction

`<virtual button>.get_history_direction([frames])`

<!-- tabs:start -->

#### **Description**

**Returns:** N/A (`undefined`)

|Name      |Datatype|Purpose                                                                                        |
|----------|--------|-----------------------------------------------------------------------------------------------|
|`[frames]`|integer |Number of frames in the past to analyze. If not specified, `INPUT_TOUCH_HISTORY_FRAMES` is used|

#### **Example**

```gml
//TODO lol
```

<!-- tabs:end -->

&nbsp;

## .get_history_distance

`<virtual button>.get_history_distance([frames])`

<!-- tabs:start -->

#### **Description**

**Returns:** Number, how far the touch point moved over

|Name      |Datatype|Purpose                                                                                        |
|----------|--------|-----------------------------------------------------------------------------------------------|
|`[frames]`|integer |Number of frames in the past to analyze. If not specified, `INPUT_TOUCH_HISTORY_FRAMES` is used|

?> The distance that this function returns is measured in GUI-space.

#### **Example**

```gml
//TODO lol
```

<!-- tabs:end -->

&nbsp;

## .get_history_speed

`<virtual button>.get_history_speed([frames])`

<!-- tabs:start -->

#### **Description**

**Returns:** Number, the speed of the touch point's movement

|Name      |Datatype|Purpose                                                                                        |
|----------|--------|-----------------------------------------------------------------------------------------------|
|`[frames]`|integer |Number of frames in the past to analyze. If not specified, `INPUT_TOUCH_HISTORY_FRAMES` is used|

?> The speed that this function returns is measured in GUI-space.

#### **Example**

```gml
//TODO lol
```

<!-- tabs:end -->