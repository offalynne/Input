# Plug-in API

&nbsp;

## …PlugInRegisterCallback

`InputPlugInRegisterCallback(callbackType, [priority=-1], method)`

<!-- tabs:start -->

#### **Description**

**Returns:** N/A (`undefined`)

|Name           |Datatype|Purpose                                                                                                      |
|---------------|--------|-------------------------------------------------------------------------------------------------------------|
|`callbackType` |integer |Which callback type to attach the method to. This is a member of the `INPUT_PLUG_IN_CALLBACK` enum, see below|
|`[priority]`   |integer |If not specified, `-1` is used which will execute the callback after native code                             |
|`method`       |method  |The method to execute                                                                                        |

Registers a callback to be executed at a suitable time by the library. The callback type should be a member of the `INPUT_PLUG_IN_CALLBACK` enum. The method that you specify will be handed parameters, though what parameters specifically depends on the callback type:

|Enum member             |Parameters                                      |
|------------------------|------------------------------------------------|
|`.COLLECT`              |_(No parameters)_                               |
|`.UPDATE`               |_(No parameters)_                               |
|`.GAMEPAD_DISCONNECTED` |Device index, Actually disconnected             |
|`.GAMEPAD_CONNECTED`    |Device index                                    |
|`.PLAYER_DEVICE_CHANGED`|Player index, Old device index, New device index|
|`.COLLECT_PLAYER`       |Player index                                    |
|`.UPDATE_PLAYER`        |Player index                                    |
|`.LOSE_FOCUS`           |_(No parameters)_                               |
|`.GAIN_FOCUS`           |_(No parameters)_                               |

 You may also specify a callback priority. Because many callbacks can be registered to any particular callback type, and because code order might matter in some situations, it is useful to be able to control what order callbacks are executed. Native library code always has a priority of 0 and plug-ins cannot use a priority of 0. Higher priorities are executed first.

#### **Example**

```gml
{
    
}
```
<!-- tabs:end -->

&nbsp;

## …PlugInGetFrame

`InputPlugInGetFrame()`

<!-- tabs:start -->

#### **Description**

**Returns:** Integer, what update frame the library is on

|Name|Datatype|Purpose|
|----|--------|-------|
|None|        |       |

Returns the current update frame number for the library. This is an internal value that is incremented by 1 every time the update loop occurs.

#### **Example**

```gml
{
    
}
```
<!-- tabs:end -->

&nbsp;

## …PlugInGetTime

`InputPlugInGetTime()`

<!-- tabs:start -->

#### **Description**

**Returns:** Integer, the length of time that the library has been running for

|Name|Datatype|Purpose|
|----|--------|-------|
|None|        |       |

Returns the current library up time. This is measured by incrementing an internal counter by `delta_time/1000` and as such will be inaccurate over large spans of time.

#### **Example**

```gml
{
    
}
```
<!-- tabs:end -->

&nbsp;

## …PlugInVerbSet

`InputPlugInVerbSet()`

<!-- tabs:start -->

#### **Description**

**Returns:** N/A (`undefined`)

|Name           |Datatype|Purpose                                                                                                                           |
|---------------|--------|----------------------------------------------------------------------------------------------------------------------------------|
|`verbIndex`    |integer |Verb to target                                                                                                                    |
|`value`        |number  |Value to set for the verb. This is the primary value for the being e.g. exposed via `InputValue()`                                |
|`[rawValue]`   |number  |**Raw** value to set for the verb. This is used to calculate cluster values. If not specified, the `value` parameter above is used|
|`[playerIndex]`|integer |Player to target. If not specified, player 0 is used                                                                              |

?> This function must be called from within a `INPUT_PLUG_IN_CALLBACK.UPDATE_PLAYER` callback.

#### **Example**

```gml
{
    
}
```
<!-- tabs:end -->

&nbsp;

## …PlugInVerbStateRead

`InputPlugInVerbStateRead()`

<!-- tabs:start -->

#### **Description**

**Returns:** N/A (`undefined`)

|Name           |Datatype|Purpose                                             |
|---------------|--------|----------------------------------------------------|
|`buffer`       |buffer  |Buffer to read verb state from                      |
|`[playerIndex]`|integer |Player to target. If not specified, player 0 is used|

?> This function must be called from within a `INPUT_PLUG_IN_CALLBACK.UPDATE_PLAYER` callback.

#### **Example**

```gml
{
    
}
```
<!-- tabs:end -->

&nbsp;

## …PlugInGamepadBlock

`InputPlugInGamepadBlock(device)`

<!-- tabs:start -->

#### **Description**

**Returns:** N/A (`undefined`)

|Name    |Datatype|Purpose         |
|--------|--------|----------------|
|`device`|integer |Device to target|

Forces a gamepad to be blocked. This is helpful for plug-ins that are designed to filter out bad or unwanted gamepads. Calling this function will execute the `.GAMEPAD_DISCONNECTED` callback with the second parameter set to `false`.

#### **Example**

```gml
{
    
}
```
<!-- tabs:end -->

&nbsp;

## …PlugInGamepadSetMapping

`InputPlugInGamepadSetMapping(device, gpConstant, method)`

<!-- tabs:start -->

#### **Description**

**Returns:** N/A (`undefined`)

|Name        |Datatype       |Purpose                                                                                               |
|------------|---------------|------------------------------------------------------------------------------------------------------|
|`device`    |integer        |Device to target                                                                                      |
|`gpConstant`|gamepad binding|Gamepad button or axis to set the method for. This will overwrite any method that has already been set|
|`method`    |method         |Method to execute to evaluate the state of the gamepad                                                |

#### **Example**

```gml
{
    
}
```
<!-- tabs:end -->

&nbsp;

## …PlugInGamepadSetType

`InputPlugInGamepadSetType(device, type)`

<!-- tabs:start -->

#### **Description**

**Returns:** N/A (`undefined`)

|Name    |Datatype|Purpose                                                      |
|--------|--------|-------------------------------------------------------------|
|`device`|integer |Device to target                                             |
|`type`  |integer |Gamepad type to set, one of the `INPUT_GAMEPAD_TYPE_*` macros|

#### **Example**

```gml
{
    
}
```
<!-- tabs:end -->

&nbsp;

## …PlugInGamepadSetDescription

`InputPlugInGamepadSetDescription(device, description)`

<!-- tabs:start -->

#### **Description**

**Returns:** N/A (`undefined`)

|Name         |Datatype|Purpose                   |
|-------------|--------|--------------------------|
|`device`     |integer |Device to target          |
|`description`|string  |Gamepad description to set|

#### **Example**

```gml
{
    
}
```
<!-- tabs:end -->

&nbsp;

## …PlugInGamepadNullifyMapping

`InputPlugInGamepadNullifyMapping(device, gpConstant)`

<!-- tabs:start -->

#### **Description**

**Returns:** N/A (`undefined`)

|Name        |Datatype       |Purpose                                 |
|------------|---------------|----------------------------------------|
|`device`    |integer        |Device to target                        |
|`gpConstant`|gamepad binding|Gamepad button or axis mapping to remove|

#### **Example**

```gml
{
    
}
```
<!-- tabs:end -->

&nbsp;

## …PlugInGamepadNullifyAllMappings

`InputPlugInGamepadNullifyAllMappings(device)`

<!-- tabs:start -->

#### **Description**

**Returns:** N/A (`undefined`)

|Name    |Datatype|Purpose         |
|--------|--------|----------------|
|`device`|integer |Device to target|

#### **Example**

```gml
{
    
}
```
<!-- tabs:end -->

&nbsp;

## …PlugInGamepadResetMapping

`InputPlugInGamepadResetMapping(device, gpConstant)`

<!-- tabs:start -->

#### **Description**

**Returns:** N/A (`undefined`)

|Name        |Datatype       |Purpose                                |
|------------|---------------|---------------------------------------|
|`device`    |integer        |Device to target                       |
|`gpConstant`|gamepad binding|Gamepad button or axis mapping to reset|

#### **Example**

```gml
{
    
}
```
<!-- tabs:end -->