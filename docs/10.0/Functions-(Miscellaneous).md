# Miscellaneous

&nbsp;

## …GameHasFocus

`InputGameHasFocus()`

<!-- tabs:start -->

#### **Description**

**Returns:** Boolean, whether the game is focused

|Name|Datatype|Purpose|
|----|--------|-------|
|None|        |       |

Returns whether the game is focused.

<!-- tabs:end -->

&nbsp;

## …GetSteamInfo

`InputGetSteamInfo(infoField)`

<!-- tabs:start -->

#### **Description**

**Returns:** Boolean, see below

|Name       |Datatype|Purpose                                              |
|-----------|--------|-----------------------------------------------------|
|`infoField`|integer |Which piece of information about Steamworks to return|

Returns information about the Steam integration in the library. `infoField` should be a member of the `INPUT_STEAM_INFO` enum:

|Constant                     |Returned Value                                 |
|-----------------------------|-----------------------------------------------|
|`INPUT_STEAM_INFO.STEAMWORKS`|Whether Steamworks has initialized successfully|
|`INPUT_STEAM_INFO.STEAM_DECK`|Whether we're running on Steam Deck hardware   |
|`INPUT_STEAM_INFO.ON_WINE`   |Whether we're running in the WINE emulator     |

<!-- tabs:end -->

&nbsp;

## …ManualCollect

`InputManualCollect()`

<!-- tabs:start -->

#### **Description**

**Returns:** N/A (`undefined`)

|Name|Datatype|Purpose|
|----|--------|-------|
|None|        |       |

Manually collects player input from devices. Should only be called when `INPUT_COLLECT_MODE` is set to 2.

<!-- tabs:end -->

&nbsp;

## …GetBindingName

`InputGetBindingName(binding, forGamepad, gamepadType, [missingBindingName="???"])`

<!-- tabs:start -->

#### **Description**

**Returns:** String, the name of a binding

|Name                  |Datatype|Purpose                                                   |
|----------------------|--------|----------------------------------------------------------|
|`binding`             |any     |Binding to return the name of                             |
|`forGamepad`          |boolean |Whether the returned value should be for a gamepad binding|
|`gamepadType`         |integer |What type of gamepad to returnt he binding name for       |
|`[missingBindingName]`|any     |Value to return when a binding name cannot be found       |

Returns a name for a binding when using a gamepad for a particular gamepad type, or the keyboard and mouse device (`INPUT_KBM`) if `forGamepad` is set to `false`. If a name for a binding cannot be found, this function will return `missingBindingName` (which is `"???"` by default). [You can see a full list of bindings here](Binding-Names).

!> This function is provided for basic binding naming and is suitable for debugging or alpha-quality games. Please use the "Binding Icons" plug-in for a higher quality system.

<!-- tabs:end -->