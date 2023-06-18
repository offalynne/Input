# Functions (Virtual Button Properties)

&nbsp;

Virtual buttons can be configured using the following functions. Many functions return `self` meaning that methods can be chained together as a fluent interface.

?> All coordinates and positions are in GUI-space.

&nbsp;

## .threshold

`<virtual button>.threshold(min, max)`

<!-- tabs:start -->

#### **Description**

**Returns:** `self`

|Name |Datatype|Purpose                |
|-----|--------|-----------------------|
|`min`|number  |Minimum threshold value|
|`max`|number  |Maximum threshold value|

?> This method is only relevant for dpad- and thumbstick-type virtual buttons.

#### **Example**

```gml
//TODO lol
```

<!-- tabs:end -->

&nbsp;

## .get_threshold

`<virtual button>.get_threshold()`

<!-- tabs:start -->

#### **Description**

**Returns:** Struct, containing the minimum and maximum thresholds

|Name|Datatype|Purpose|
|----|--------|-------|
|None|        |       |

The struct returned from this method has the following member variables:

|Name   |Datatype|Purpose                |
|-------|--------|-----------------------|
|`.mini`|number  |Minimum threshold value|
|`.maxi`|number  |Maximum threshold value|

#### **Example**

```gml
//TODO lol
```

<!-- tabs:end -->

&nbsp;

## .active

`<virtual button>.active(state)`

<!-- tabs:start -->

#### **Description**

**Returns:** `self`

|Name   |Datatype|Purpose                            |
|-------|--------|-----------------------------------|
|`state`|boolean |Active state for the virtual button|

When a virtual button's active state is set to `false`, it will immediately stop responding to player input, including any current input.

#### **Example**

```gml
//TODO lol
```

<!-- tabs:end -->

&nbsp;

## .get_active

`<virtual button>.get_active()`

<!-- tabs:start -->

#### **Description**

**Returns:** Boolean, whether the virtual button is active

|Name|Datatype|Purpose|
|----|--------|-------|
|None|        |       |

#### **Example**

```gml
//TODO lol
```

<!-- tabs:end -->

&nbsp;

## .priority

`<virtual button>.priority(priority)`

<!-- tabs:start -->

#### **Description**

**Returns:** `self`

|Name      |Datatype|Purpose                                |
|----------|--------|---------------------------------------|
|`priority`|number  |Capture priority for the virtual button|

#### **Example**

```gml
//TODO lol
```

<!-- tabs:end -->

&nbsp;

## .get_priority

`<virtual button>.get_priority()`

<!-- tabs:start -->

#### **Description**

**Returns:** Number, the priority of the virtual button

|Name|Datatype|Purpose|
|----|--------|-------|
|None|        |       |

#### **Example**

```gml
//TODO lol
```

<!-- tabs:end -->

&nbsp;

## .follow

`<virtual button>.follow(state)`

<!-- tabs:start -->

#### **Description**

**Returns:** `self`

|Name   |Datatype|Purpose                                                         |
|-------|--------|----------------------------------------------------------------|
|`state`|boolean |Whether the virtual button should move to follow the touch point|

?> As the follow state moves the virtual button around, you may want to call `.release_behaviour(INPUT_VIRTUAL_RELEASE.RESET_POSITION)` to reset the position of the button.

#### **Example**

```gml
//TODO lol
```

<!-- tabs:end -->

&nbsp;

## .get_follow

`<virtual button>.get_follow()`

<!-- tabs:start -->

#### **Description**

**Returns:** Boolean, whether the virtual button is following the touch point

|Name|Datatype|Purpose|
|----|--------|-------|
|None|        |       |

#### **Example**

```gml
//TODO lol
```

<!-- tabs:end -->

&nbsp;

## .release_behavior

`<virtual button>.release_behavior(option)`

<!-- tabs:start -->

#### **Description**

**Returns:** `self`

|Name   |Datatype                    |Purpose|
|-------|----------------------------|-------|
|`state`|`INPUT_VIRTUAL_RELEASE` enum|       |

The `INPUT_VIRTUAL_RELEASE` enum contains the following elements:

|Name             |Purpose                                                                         |
|-----------------|--------------------------------------------------------------------------------|
|`.DO_NOTHING`    |Default setting. Does nothing!                                                  |
|`.DESTROY`       |Destroys the virtual button when released. This is useful for ad hoc thumbsticks|
|`.RESET_POSITION`|Resets the position of the button to where it was created when released         |

#### **Example**

```gml
//TODO lol
```

<!-- tabs:end -->

&nbsp;

## .get_release_behavior

`<virtual button>.get_release_behavior()`

<!-- tabs:start -->

#### **Description**

**Returns:** Member of the `INPUT_VIRTUAL_RELEASE` enum

|Name|Datatype|Purpose|
|----|--------|-------|
|None|        |       |

#### **Example**

```gml
//TODO lol
```

<!-- tabs:end -->

&nbsp;

## .first_touch_only

`<virtual button>.first_touch_only(state)`

<!-- tabs:start -->

#### **Description**

**Returns:** `self`

|Name   |Datatype|Purpose                                                                    |
|-------|--------|---------------------------------------------------------------------------|
|`state`|boolean |Whether the virtual button should only try to capture the first touch point|

On devices that support multiple touch points (typically mobile phones), setting this behaviour to `true` will filter out any touch points after the first one. This is useful for preventing multiple touches on a menu.

On devices that do not support multiple touch points, this function will not change any behaviour.

#### **Example**

```gml
//TODO lol
```

<!-- tabs:end -->