# Virtual Buttons

&nbsp;

The following functions are in global scope and can be called anywhere in your game. Virtual buttons themselves are created with `InputVirtualCreate()` - which returns a struct - and should be configured by executing methods on that struct.

?> All coordinates and positions are in GUI-space.

&nbsp;

## …VirtualCreate

`InputVirtualCreate()`

<!-- tabs:start -->

#### **Description**

**Returns:** ,

|Name           |Datatype|Purpose                                             |
|---------------|--------|----------------------------------------------------|

Returns 

#### **Example**

```gml
{
    
}
```
<!-- tabs:end -->

&nbsp;

## …VirtualDebugDraw

`InputVirtualDebugDraw()`

<!-- tabs:start -->

#### **Description**

**Returns:** ,

|Name           |Datatype|Purpose                                             |
|---------------|--------|----------------------------------------------------|

Returns 

#### **Example**

```gml
{
    
}
```
<!-- tabs:end -->

&nbsp;

## …VirtualDestroyAll

`InputVirtualDestroyAll()`

<!-- tabs:start -->

#### **Description**

**Returns:** ,

|Name           |Datatype|Purpose                                             |
|---------------|--------|----------------------------------------------------|

Returns 

#### **Example**

```gml
{
    
}
```
<!-- tabs:end -->

&nbsp;

# Virtual Button Setup

&nbsp;

Virtual buttons can be configured using the following functions. Many functions return `self` meaning that methods can be chained together as a fluent interface.

?> All coordinates and positions are in GUI-space.

&nbsp;

## .Destroy

`<virtual button>.Destroy()`

<!-- tabs:start -->

#### **Description**

**Returns:** ,

|Name           |Datatype|Purpose                                             |
|---------------|--------|----------------------------------------------------|

Returns 

#### **Example**

```gml
{
    
}
```
<!-- tabs:end -->

&nbsp;

## .DebugDraw

`<virtual button>.DebugDraw()`

<!-- tabs:start -->

#### **Description**

**Returns:** ,

|Name           |Datatype|Purpose                                             |
|---------------|--------|----------------------------------------------------|

Returns 

#### **Example**

```gml
{
    
}
```
<!-- tabs:end -->

&nbsp;

## .Rectangle

`<virtual button>.Rectangle(inLeft, inTop, inRight, inBottom)`

<!-- tabs:start -->

#### **Description**

**Returns:** ,

|Name           |Datatype|Purpose                                             |
|---------------|--------|----------------------------------------------------|

Returns 

#### **Example**

```gml
{
    
}
```
<!-- tabs:end -->

&nbsp;

## .Circle

`<virtual button>.Circle(x, y, radius)`

<!-- tabs:start -->

#### **Description**

**Returns:** ,

|Name           |Datatype|Purpose                                             |
|---------------|--------|----------------------------------------------------|

Returns 

#### **Example**

```gml
{
    
}
```
<!-- tabs:end -->

&nbsp;

## .GetPosition

`<virtual button>.GetPosition()`

<!-- tabs:start -->

#### **Description**

**Returns:** ,

|Name           |Datatype|Purpose                                             |
|---------------|--------|----------------------------------------------------|

Returns 

#### **Example**

```gml
{
    
}
```
<!-- tabs:end -->

&nbsp;

## .Button

`<virtual button>.Button(verb)`

<!-- tabs:start -->

#### **Description**

**Returns:** ,

|Name           |Datatype|Purpose                                             |
|---------------|--------|----------------------------------------------------|

Returns 

#### **Example**

```gml
{
    
}
```
<!-- tabs:end -->

&nbsp;

## .HPad

`<virtual button>.HPad(click, left, right)`

<!-- tabs:start -->

#### **Description**

**Returns:** ,

|Name           |Datatype|Purpose                                             |
|---------------|--------|----------------------------------------------------|

Returns 

#### **Example**

```gml
{
    
}
```
<!-- tabs:end -->

&nbsp;

## .VPad

`<virtual button>.VPad(click, up, down)`

<!-- tabs:start -->

#### **Description**

**Returns:** ,

|Name           |Datatype|Purpose                                             |
|---------------|--------|----------------------------------------------------|

Returns 

#### **Example**

```gml
{
    
}
```
<!-- tabs:end -->

&nbsp;

## .DPad

`<virtual button>.DPad(click, left, right, up, down, [4dir])`

<!-- tabs:start -->

#### **Description**

**Returns:** ,

|Name           |Datatype|Purpose                                             |
|---------------|--------|----------------------------------------------------|

Returns 

#### **Example**

```gml
{
    
}
```
<!-- tabs:end -->

&nbsp;

## .Thumbstick

`<virtual button>.Thumbstick(click, left, right, up, down)`

<!-- tabs:start -->

#### **Description**

**Returns:** ,

|Name           |Datatype|Purpose                                             |
|---------------|--------|----------------------------------------------------|

Returns 

#### **Example**

```gml
{
    
}
```
<!-- tabs:end -->

&nbsp;

## .Touchpad

`<virtual button>.Touchpad(click, left, right, up, down, [maxDistance])`

<!-- tabs:start -->

#### **Description**

**Returns:** ,

|Name           |Datatype|Purpose                                             |
|---------------|--------|----------------------------------------------------|

Returns 

#### **Example**

```gml
{
    
}
```
<!-- tabs:end -->

&nbsp;

## .GetType

`<virtual button>.GetType()`

<!-- tabs:start -->

#### **Description**

**Returns:** ,

|Name           |Datatype|Purpose                                             |
|---------------|--------|----------------------------------------------------|

Returns 

#### **Example**

```gml
{
    
}
```
<!-- tabs:end -->

&nbsp;

## .GetVerbs

`<virtual button>.GetVerbs()`

<!-- tabs:start -->

#### **Description**

**Returns:** ,

|Name           |Datatype|Purpose                                             |
|---------------|--------|----------------------------------------------------|

Returns 

#### **Example**

```gml
{
    
}
```
<!-- tabs:end -->

&nbsp;

## .Threshold

`<virtual button>.Threshold(min, max)`

<!-- tabs:start -->

#### **Description**

**Returns:** ,

|Name           |Datatype|Purpose                                             |
|---------------|--------|----------------------------------------------------|

Returns 

#### **Example**

```gml
{
    
}
```
<!-- tabs:end -->

&nbsp;

## .GetThreshold

`<virtual button>.GetThreshold()`

<!-- tabs:start -->

#### **Description**

**Returns:** ,

|Name           |Datatype|Purpose                                             |
|---------------|--------|----------------------------------------------------|

Returns 

#### **Example**

```gml
{
    
}
```
<!-- tabs:end -->

&nbsp;

## .Active

`<virtual button>.Active(state)`

<!-- tabs:start -->

#### **Description**

**Returns:** ,

|Name           |Datatype|Purpose                                             |
|---------------|--------|----------------------------------------------------|

Returns 

#### **Example**

```gml
{
    
}
```
<!-- tabs:end -->

&nbsp;

## .GetActive

`<virtual button>.GetActive()`

<!-- tabs:start -->

#### **Description**

**Returns:** ,

|Name           |Datatype|Purpose                                             |
|---------------|--------|----------------------------------------------------|

Returns 

#### **Example**

```gml
{
    
}
```
<!-- tabs:end -->

&nbsp;

## .Priority

`<virtual button>.Priority(priority)`

<!-- tabs:start -->

#### **Description**

**Returns:** ,

|Name           |Datatype|Purpose                                             |
|---------------|--------|----------------------------------------------------|

Returns 

#### **Example**

```gml
{
    
}
```
<!-- tabs:end -->

&nbsp;

## .GetPriority

`<virtual button>.GetPriority()`

<!-- tabs:start -->

#### **Description**

**Returns:** ,

|Name           |Datatype|Purpose                                             |
|---------------|--------|----------------------------------------------------|

Returns 

#### **Example**

```gml
{
    
}
```
<!-- tabs:end -->

&nbsp;

## .Follow

`<virtual button>.Follow(state)`

<!-- tabs:start -->

#### **Description**

**Returns:** ,

|Name           |Datatype|Purpose                                             |
|---------------|--------|----------------------------------------------------|

Returns 

#### **Example**

```gml
{
    
}
```
<!-- tabs:end -->

&nbsp;

## .GetFollow

`<virtual button>.GetFollow()`

<!-- tabs:start -->

#### **Description**

**Returns:** ,

|Name           |Datatype|Purpose                                             |
|---------------|--------|----------------------------------------------------|

Returns 

#### **Example**

```gml
{
    
}
```
<!-- tabs:end -->

&nbsp;

## .ReleaseBehavior

`<virtual button>.ReleaseBehavior(option)`

<!-- tabs:start -->

#### **Description**

**Returns:** ,

|Name           |Datatype|Purpose                                             |
|---------------|--------|----------------------------------------------------|

Returns 

#### **Example**

```gml
{
    
}
```
<!-- tabs:end -->

&nbsp;

## .GetReleaseBehavior

`<virtual button>.GetReleaseBehavior()`

<!-- tabs:start -->

#### **Description**

**Returns:** ,

|Name           |Datatype|Purpose                                             |
|---------------|--------|----------------------------------------------------|

Returns 

#### **Example**

```gml
{
    
}
```
<!-- tabs:end -->

&nbsp;

## .FirstTouchOnly

`<virtual button>.FirstTouchOnly(state)`

<!-- tabs:start -->

#### **Description**

**Returns:** ,

|Name           |Datatype|Purpose                                             |
|---------------|--------|----------------------------------------------------|

Returns 

#### **Example**

```gml
{
    
}
```
<!-- tabs:end -->

&nbsp;

## .GetFirstTouchOnly

`<virtual button>.GetFirstTouchOnly()`

<!-- tabs:start -->

#### **Description**

**Returns:** ,

|Name           |Datatype|Purpose                                             |
|---------------|--------|----------------------------------------------------|

Returns 

#### **Example**

```gml
{
    
}
```
<!-- tabs:end -->

&nbsp;

## .ReferencePoint

`<virtual button>.ReferencePoint(option)`

<!-- tabs:start -->

#### **Description**

**Returns:** ,

|Name           |Datatype|Purpose                                             |
|---------------|--------|----------------------------------------------------|

Returns 

#### **Example**

```gml
{
    
}
```
<!-- tabs:end -->

&nbsp;

## .GetReferencePoint

`<virtual button>.GetReferencePoint()`

<!-- tabs:start -->

#### **Description**

**Returns:** ,

|Name           |Datatype|Purpose                                             |
|---------------|--------|----------------------------------------------------|

Returns 

#### **Example**

```gml
{
    
}
```
<!-- tabs:end -->

&nbsp;

## .Momentary

`<virtual button>.Momentary(state)`

<!-- tabs:start -->

#### **Description**

**Returns:** ,

|Name           |Datatype|Purpose                                             |
|---------------|--------|----------------------------------------------------|

Returns 

#### **Example**

```gml
{
    
}
```
<!-- tabs:end -->

&nbsp;

## .GetMomentary

`<virtual button>.GetMomentary()`

<!-- tabs:start -->

#### **Description**

**Returns:** ,

|Name           |Datatype|Purpose                                             |
|---------------|--------|----------------------------------------------------|

Returns 

#### **Example**

```gml
{
    
}
```
<!-- tabs:end -->

&nbsp;

## .Pressed

`<virtual button>.Pressed()`

<!-- tabs:start -->

#### **Description**

**Returns:** ,

|Name           |Datatype|Purpose                                             |
|---------------|--------|----------------------------------------------------|

Returns 

#### **Example**

```gml
{
    
}
```
<!-- tabs:end -->

&nbsp;

## .Check

`<virtual button>.Check()`

<!-- tabs:start -->

#### **Description**

**Returns:** ,

|Name           |Datatype|Purpose                                             |
|---------------|--------|----------------------------------------------------|

Returns 

#### **Example**

```gml
{
    
}
```
<!-- tabs:end -->

&nbsp;

## .Released

`<virtual button>.Released()`

<!-- tabs:start -->

#### **Description**

**Returns:** ,

|Name           |Datatype|Purpose                                             |
|---------------|--------|----------------------------------------------------|

Returns 

#### **Example**

```gml
{
    
}
```
<!-- tabs:end -->

&nbsp;

## .GetX

`<virtual button>.GetX()`

<!-- tabs:start -->

#### **Description**

**Returns:** ,

|Name           |Datatype|Purpose                                             |
|---------------|--------|----------------------------------------------------|

Returns 

#### **Example**

```gml
{
    
}
```
<!-- tabs:end -->

&nbsp;

## .GetY

`<virtual button>.GetY()`

<!-- tabs:start -->

#### **Description**

**Returns:** ,

|Name           |Datatype|Purpose                                             |
|---------------|--------|----------------------------------------------------|

Returns 

#### **Example**

```gml
{
    
}
```
<!-- tabs:end -->

&nbsp;

## .GetTouchX

`<virtual button>.GetTouchX()`

<!-- tabs:start -->

#### **Description**

**Returns:** ,

|Name           |Datatype|Purpose                                             |
|---------------|--------|----------------------------------------------------|

Returns 

#### **Example**

```gml
{
    
}
```
<!-- tabs:end -->

&nbsp;

## .GetTouchY

`<virtual button>.GetTouchY()`

<!-- tabs:start -->

#### **Description**

**Returns:** ,

|Name           |Datatype|Purpose                                             |
|---------------|--------|----------------------------------------------------|

Returns 

#### **Example**

```gml
{
    
}
```
<!-- tabs:end -->

&nbsp;

## .GetTouchDX

`<virtual button>.GetTouchDX()`

<!-- tabs:start -->

#### **Description**

**Returns:** ,

|Name           |Datatype|Purpose                                             |
|---------------|--------|----------------------------------------------------|

Returns 

#### **Example**

```gml
{
    
}
```
<!-- tabs:end -->

&nbsp;

## .GetTouchDY

`<virtual button>.GetTouchDY()`

<!-- tabs:start -->

#### **Description**

**Returns:** ,

|Name           |Datatype|Purpose                                             |
|---------------|--------|----------------------------------------------------|

Returns 

#### **Example**

```gml
{
    
}
```
<!-- tabs:end -->

&nbsp;

## .GetTouchStartX

`<virtual button>.GetTouchStartX()`

<!-- tabs:start -->

#### **Description**

**Returns:** ,

|Name           |Datatype|Purpose                                             |
|---------------|--------|----------------------------------------------------|

Returns 

#### **Example**

```gml
{
    
}
```
<!-- tabs:end -->

&nbsp;

## .GetTouchStartY

`<virtual button>.GetTouchStartY()`

<!-- tabs:start -->

#### **Description**

**Returns:** ,

|Name           |Datatype|Purpose                                             |
|---------------|--------|----------------------------------------------------|

Returns 

#### **Example**

```gml
{
    
}
```
<!-- tabs:end -->

&nbsp;

## .RecordHistory

`<virtual button>.RecordHistory(state)`

<!-- tabs:start -->

#### **Description**

**Returns:** ,

|Name           |Datatype|Purpose                                             |
|---------------|--------|----------------------------------------------------|

Returns 

#### **Example**

```gml
{
    
}
```
<!-- tabs:end -->

&nbsp;

## .GetHistory

`<virtual button>.GetHistory()`

<!-- tabs:start -->

#### **Description**

**Returns:** ,

|Name           |Datatype|Purpose                                             |
|---------------|--------|----------------------------------------------------|

Returns 

#### **Example**

```gml
{
    
}
```
<!-- tabs:end -->

&nbsp;

## .GetHistoryDirection

`<virtual button>.GetHistoryDirection([frames])`

<!-- tabs:start -->

#### **Description**

**Returns:** ,

|Name           |Datatype|Purpose                                             |
|---------------|--------|----------------------------------------------------|

Returns 

#### **Example**

```gml
{
    
}
```
<!-- tabs:end -->

&nbsp;

## .GetHistoryDistance

`<virtual button>.GetHistoryDistance([frames])`

<!-- tabs:start -->

#### **Description**

**Returns:** ,

|Name           |Datatype|Purpose                                             |
|---------------|--------|----------------------------------------------------|

Returns 

#### **Example**

```gml
{
    
}
```
<!-- tabs:end -->

&nbsp;

## .GetHistorySpeed

`<virtual button>.GetHistorySpeed([frames])`

<!-- tabs:start -->

#### **Description**

**Returns:** ,

|Name           |Datatype|Purpose                                             |
|---------------|--------|----------------------------------------------------|

Returns 

#### **Example**

```gml
{
    
}
```
<!-- tabs:end -->
