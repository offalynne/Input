# Plug-in API

&nbsp;

The page covers the plug-in component of Input. The plug-in API is intended for users who need extra control over Input's internal systems. The majority of use cases can safely avoid these functions.

Input's plug-ins operate on a callback basis. Callbacks are simple methods that you provide that the library will call for you at the appropriate time during operation. Callbacks can be set up with `InputPlugInRegisterCallback()` and the documentation for this function below lists all the callback locations that you can hook into.

You can execute your own code in the callback that you provided, such as setting up savedata links on Xbox when a gamepad is connected. The plug-in API also includes a handful of functions to directly alter the internal state of Input. For example, `InputPlugInVerbSet()` allows you to set a verb's raw value. You could use this function to force verbs to be certain values depending on the game state, such as blocking movement verbs when a pause menu is open.

The plug-in API has many uses for individual projects and games. However, the plug-in API is also helpful for community contributors who want to make and share their own tools that utilize Input. If you're made something you're really proud of, [please contact us](https://github.com/offalynne/Input/issues). We want to see what people are making!

&nbsp;

## …PlugInDefine

`InputPlugInDefine(alias, author, version, targetInputVersion, initCallback)`

<!-- tabs:start -->

#### **Description**

**Returns:** N/A (`undefined`)

|Name                |Datatype|Purpose                                                                             |
|--------------------|--------|------------------------------------------------------------------------------------|
|`alias`             |string  |Global alias to use to refer to this plug-in                                        |
|`author`            |string  |Name of the author for the plug-in (that's you!)                                    |
|`version`           |string  |Version of the plug-in in the format `"major.minor.patch"`                          |
|`targetInputVersion`|string  |Target version of Input that the plug-in is built for, in the format `"major.minor"`|
|`initCallback`      |method  |Callback to execute when Input initializes the plug-in                              |

Defines a plug-in for use with Input.

!> `InputPlugInDefine()` should be called on boot, that is to say it should be called in global scope in a script. Input must know about plug-ins before the first GameMaker step.

This function creates a representation of your plug-in inside Input. You should supply an alias for the plug-in, your name, and a version for the plug-in itself. These should all be strings. The alias is case sensitive. The version number should be in the format `"major.minor.patch"` as per semantic versioning. Only the major and minor version numbers will be used for comparisons, but it's good practice to use all three numbers nonetheless.

!> Please update your plug-in's version number whenever you publish a meaningful update. Keeping your own version number up to date helps with diagnosing your own bugs as well as helping create a community of interdependent plug-ins.

The alias must be universally unique so choose something distinctive! We recommend an alias along the lines of `"YourName.PlugInTitle"`. The native gamepad color plug-in uses `"InputTeam.GamepadColor"`, for example.

`targetInputVersion` should be a string too and should be in the format `"major.minor"`. This version number is checked against the version of Input that is currently running.

!> Please define a static value for `targetInputVersion` and do not use `INPUT_VERSION`!

Immediately before Input performs its very first update, the initialization callback that you have defined in the `initCallback` parameter will be executed. This is where you should call `InputPlugInRegisterCallback()` to hook up your plug-in to Input's callback system. All plug-in initialization callbacks will be executed when Input collects raw verb state for the first time. This is typically in the first room but, depending on how the end-user is making use of Input, when and what room this happens in is not guaranteed. Plug-ins will also be initialized before player 0 is given a default device.

#### **Example**

```gml
//Create a new plug-in. This is version "1.0" of the plug-in, built for version "10.0" of Input.
InputPlugInDefine("InputTeam.GamepadColor", "Input Team", "1.0", "10.0", function()
{
	//Register a callback within the initialization method
    InputPlugInRegisterCallback(INPUT_PLUG_IN_CALLBACK.PLAYER_DEVICE_CHANGED, undefined, function(_playerIndex, _oldDevice, _newDevice)
    {
    	//Set the default color for the device if the player has changed to something new
        with(__playerArray[_playerIndex])
        {
            __SetColor(__color);
        }
    });
});
```
<!-- tabs:end -->

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
|`.GAMEPAD_DISCONNECTED` |Device index, Hardware disconnected             |
|`.GAMEPAD_CONNECTED`    |Device index                                    |
|`.PLAYER_DEVICE_CHANGED`|Player index, Old device index, New device index|
|`.COLLECT_PLAYER`       |Player index                                    |
|`.UPDATE_PLAYER`        |Player index                                    |
|`.LOSE_FOCUS`           |_(No parameters)_                               |
|`.GAIN_FOCUS`           |_(No parameters)_                               |

?> The `Hardware disconnected` parameter for the `.GAMEPAD_DISCONNECTED` will be set to `true` if a gamepad was disconnected at a hardware level. If the gamepad has been disconnected instead by `InputPlugInGamepadBlock()` then the callback will be executed with the `Hardware disconnected` parameter set to `false`.

#### **Example**

```gml
{
    
}
```
<!-- tabs:end -->

&nbsp;

## …PlugInGetExists

`PlugInGetExists()`

<!-- tabs:start -->

#### **Description**

**Returns:** Boolean, whether the so-named Input plug-in has been defined

|Name|Datatype|Purpose|
|----|--------|-------|
|None|        |       |

Returns if a plug-in with the given alias exists. Aliases are case sensitive.

#### **Example**

```gml
var _priority = -10;

//If we have a rollback plug-in registered then set our priority lower to avoid a collision
if (InputPlugInGetExists("SmartyPants.Rollback"))
{
	show_debug_message("SmartyPants Rollback detected, plug-in will adjust priority");
	_priority -= 10;
}
```
<!-- tabs:end -->

&nbsp;

## …PlugInAssertDependencies

`InputPlugInAssertDependencies(alias, targetVersion, [alias], [targetVersion], ...)`

<!-- tabs:start -->

#### **Description**

**Returns:** N/A (`undefined`)

|Name             |Datatype|Purpose                                         |
|-----------------|--------|------------------------------------------------|
|`alias`          |string  |Plug-in to search for                           |
|`targetVersion`  |string  |Minimum compatible version for the above plug-in|
|`[alias]`        |string  |Another plug-in to search for                   |
|`[targetVersion]`|string  |Minimum compatible version for the above plug-in|
|`...`            |string  |etc.                                            |

Throws an error if any of the enumerated plug-ins either don't exist or don't meet the version requirements.

#### **Example**

```gml
//Ensure we have the following plug-ins installed:
// - InputTeam.Icons  v1.0
// - InputTeam.PartyMultiplayer  v1.0
InputPlugInAssertDependencies("InputTeam.Icons", "1.0", "InputTeam.PartyMultiplayer", "1.0");
```
<!-- tabs:end -->

&nbsp;

## …PlugInError

`PlugInError(string, ...)`

<!-- tabs:start -->

#### **Description**

**Returns:** N/A (`undefined`)

|Name    |Datatype|Purpose                                                  |
|--------|--------|---------------------------------------------------------|
|`string`|string  |Value to stringify and show to the player                |
|`...`   |string  |Further value(s) to stringify and concatenate for display|

Creates a formatted error message and shows it to the player. This error message uses GameMaker's error dialog box and will terminate the application when it is dismissed. The error message itself is made from the concatenated stringified values passed to this function.

#### **Example**

```gml
//Show an error when the incoming value is invalid
InputPlugInError("Value ", _trigger ," not a gamepad trigger");
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

A list of valid gamepad types can be found [here](Functions-(Player)?id=getgamepadtype).

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
