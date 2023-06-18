# Functions (Virtual Button Checkers)

&nbsp;

Virtual buttons can be configured using the following functions. Many functions return `self` meaning that methods can be chained together as a fluent interface.

?> All coordinates and positions are in GUI-space.

&nbsp;

## .pressed

`<virtual button>.pressed()`

<!-- tabs:start -->

#### **Description**

**Returns:** Boolean, whether the virtual button was pressed this frame

|Name|Datatype|Purpose|
|----|--------|-------|
|None|        |       |

#### **Example**

```gml
//TODO lol
```

<!-- tabs:end -->

&nbsp;

## .check

`<virtual button>.check()`

<!-- tabs:start -->

#### **Description**

**Returns:** Boolean, whether the virtual button has been pressed and held

|Name|Datatype|Purpose|
|----|--------|-------|
|None|        |       |

#### **Example**

```gml
//TODO lol
```

<!-- tabs:end -->

&nbsp;

## .released

`<virtual button>.released()`

<!-- tabs:start -->

#### **Description**

**Returns:** Boolean, whether the virtual button was released this frame

|Name|Datatype|Purpose|
|----|--------|-------|
|None|        |       |

#### **Example**

```gml
//TODO lol
```

<!-- tabs:end -->

&nbsp;

## .get_x

`<virtual button>.get_x()`

<!-- tabs:start -->

#### **Description**

**Returns:** Number, the normalized x value for the virtual button

|Name|Datatype|Purpose|
|----|--------|-------|
|None|        |       |

The number returned from this function will range from `-1` (fully left) to `1` (fully right). This value respects the threshold values set by `.threshold()`.

#### **Example**

```gml
//TODO lol
```

<!-- tabs:end -->

&nbsp;

## .get_y

`<virtual button>.get_y()`

<!-- tabs:start -->

#### **Description**

**Returns:** Number, the normalized y value for the virtual button

|Name|Datatype|Purpose|
|----|--------|-------|
|None|        |       |

The number returned from this function will range from `-1` (fully top) to `1` (fully bottom). This value respects the threshold values set by `.threshold()`.

#### **Example**

```gml
//TODO lol
```

<!-- tabs:end -->

&nbsp;

## .get_touch_x

`<virtual button>.get_touch_x()`

<!-- tabs:start -->

#### **Description**

**Returns:** Number, the current x-coordinate of the touch point captured by the virtual button

|Name|Datatype|Purpose|
|----|--------|-------|
|None|        |       |

#### **Example**

```gml
//TODO lol
```

<!-- tabs:end -->

&nbsp;

## .get_touch_y

`<virtual button>.get_touch_y()`

<!-- tabs:start -->

#### **Description**

**Returns:** Number, the current y-coordinate of the touch point captured by the virtual button

|Name|Datatype|Purpose|
|----|--------|-------|
|None|        |       |

#### **Example**

```gml
//TODO lol
```

<!-- tabs:end -->

&nbsp;

## .get_touch_start_x

`<virtual button>.get_touch_start_x()`

<!-- tabs:start -->

#### **Description**

**Returns:** Number, the initial x-coordinate of the touch point when captured by the virtual button

|Name|Datatype|Purpose|
|----|--------|-------|
|None|        |       |

#### **Example**

```gml
//TODO lol
```

<!-- tabs:end -->

&nbsp;

## .get_touch_start_y

`<virtual button>.get_touch_start_y()`

<!-- tabs:start -->

#### **Description**

**Returns:** Number, the initial y-coordinate of the touch point when captured by the virtual button

|Name|Datatype|Purpose|
|----|--------|-------|
|None|        |       |

#### **Example**

```gml
//TODO lol
```

<!-- tabs:end -->