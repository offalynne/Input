# Plug-in API

&nbsp;

The page covers the plug-in component of Input. The plug-in API is intended for users who need extra control over Input's internal systems. The majority of use cases can safely avoid these functions.

Input's plug-ins operate on a callback basis. Callbacks are simple methods that you provide that the library will call for you at the appropriate time during operation. Callbacks can be set up with `InputPlugInRegisterCallback()` and the documentation for this function below lists all the callback locations that you can hook into.

You can execute your own code in the callback that you provided, such as setting up savedata links on Xbox when a gamepad is connected. The plug-in API also includes a handful of functions to directly alter the internal state of Input. For example, `InputPlugInVerbSet()` allows you to set a verb's raw value. You could use this function to force verbs to be certain values depending on the game state, such as blocking movement verbs when a pause menu is open.

The plug-in API has many uses for individual projects and games. However, the plug-in API is also helpful for community contributors who want to make and share their own tools that utilize Input. If you're made something you're really proud of, [please contact us](https://github.com/offalynne/Input/issues). We want to see what people are making!

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

Registers a callback to be executed at a suitable time by the library. The callback type should be a member of the `INPUT_PLUG_IN_CALLBACK` enum.

You may also specify a callback priority. Because many callbacks can be registered to any particular callback type, and because code order might matter in some situations, it is useful to be able to control what order callbacks are executed. Native library code always has a priority of 0 and plug-ins cannot use a priority of 0. Higher priorities are executed first.

There are various different callback types that you can use. You will need to call `InputPlugInRegisterCallback()` for each method you wish to attach. You may attach multiple methods to the same callback (though we'd recommend using a different priority for each callback to ensure execution order is consistent).

As previously mentioned, all of Input's internal code is executed with a priority of 0. Callbacks with a higher priority are executed before internal code, callbacks with a lower priority are executed after internal code. The table below describes what Input is doing itself for each callback. Attaching a method before a callback allows you to set information that Input will subsequently process. Attaching a method after a callback allows you to override state that Input has set.

The table is organized, from top to bottom, in the rough order of execution per GameMaker step. Not all callbacks will necessarily be executed every frame and some callbacks may be executed multiple times a frame (for example, `.GAMEPAD_DISCONNECTED`). Some callbacks may be executed at different times depending on other factors - the table is a guide.

|Enum member             |Purpose                                                                                         |
|------------------------|------------------------------------------------------------------------------------------------|
|`.COLLECT`              |Trigger the raw value collection for all players                                                |
|`.COLLECT_PLAYER`       |Reset and then collect raw values for each verb for a particular player                         |
|`.UPDATE`               |Updates the entire state of Input, including focus checks, gamepad state, and per-player updates|
|`.LOSE_FOCUS`           |Game window has lost focus                                                                      |
|`.GAIN_FOCUS`           |Game window has regained focus                                                                  |
|`.GAMEPAD_DISCONNECTED` |Gamepad has been disconnected                                                                   |
|`.GAMEPAD_CONNECTED`    |Gamepad has been connected                                                                      |
|`.UPDATE_PLAYER`        |Reset and then update state for every verb: press, press frame, held state, release             |
|`.PLAYER_DEVICE_CHANGED`|Player changed what device they've been assigned, either due to a hotswap or manual set         |

The method that you specify will be handed parameters, though what parameters specifically depends on the callback type:

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

## …PlugInGetAllVerbs

`InputPlugInGetAllVerbs()`

<!-- tabs:start -->

#### **Description**

**Returns:** Array of integers, the verb indexes for all defined verbs

|Name|Datatype|Purpose|
|----|--------|-------|
|None|        |       |

Returns an array of all verb indexes that have been defined by `InputDefineVerb()`. The verb indexes will not necessarily be sequential or ordered.

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

## …PlugInVerbStateSet

`InputPlugInVerbStateSet(verbIndex, [prevHeld], [valueRaw], [valueClamp], [pressFrame], [playerIndex=0])`

<!-- tabs:start -->

#### **Description**

**Returns:** N/A (`undefined`)

|Name           |Datatype|Purpose                                                                                                                                           |
|---------------|--------|--------------------------------------------------------------------------------------------------------------------------------------------------|
|`verbIndex`    |integer |Verb to target                                                                                                                                    |
|`[prevHeld]`   |boolean |Whether the verb was held on the press frame. If not specified (the value is `undefined`) then the existing value remains                         |
|`[valueRaw]`   |number  |Raw value for the verb. If not specified (the value is `undefined`) then the existing value remains                                               |
|`[valueClamp]` |number  |Clamped value for the verb, taking into account thresholds and limits. If not specified (the value is `undefined`) then the existing value remains|
|`[pressFrame]` |integer |The frame that the verb was pressed. If not specified (the value is `undefined`) then the existing value remains                                  |
|`[playerIndex]`|integer |Player to target. If not specified, player 0 is used                                                                                              |

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
