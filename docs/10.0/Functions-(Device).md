# Devices

&nbsp;

## …DeviceEnumerate

`InputDeviceEnumerate([includeGenericDevice])`

<!-- tabs:start -->

#### **Description**

**Returns:** Array of all valid devices that can be used on the platform

|Name                    |Datatype|Purpose                                                                                                    |
|------------------------|--------|-----------------------------------------------------------------------------------------------------------|
|`[includeGenericDevice]`|boolean |Whether to include `INPUT_GENERIC_DEVICE` in the returned array. If not specified, this defaults to `false`|

Returns an array of all valid devices that can be used on the platform. If `includeGenericDevice` is set to `true` then `INPUT_GENERIC_DEVICE` will be included in the returned array, otherwise `INPUT_GENERIC_DEVICE` will be ignored.

<!-- tabs:end -->

&nbsp;

## …DeviceGetPlayer

`InputDeviceGetPlayer(device)`

<!-- tabs:start -->

#### **Description**

**Returns:** Integer, player using the device

|Name    |Datatype|Purpose         |
|--------|--------|----------------|
|`device`|integer |Device to target|

Returns the player assigned to a device. This function will return `undefined` if no player is is using the device. INPUT_GENERIC_DEVICE will always return `undefined` as multiple players can use that "device" at the same time.

<!-- tabs:end -->

&nbsp;

## …DeviceIsAvailable

`InputDeviceIsAvailable(device)`

<!-- tabs:start -->

#### **Description**

**Returns:** Boolean, if a device has not been assigned to any player

|Name    |Datatype|Purpose         |
|--------|--------|----------------|
|`device`|integer |Device to target|

Returns if a device has not been assigned to any players and is available for use. This function will return `false` for devices that are unsupported on the current platform (e.g. keyboard on Xbox Series X). `INPUT_GENERIC_DEVICE` can be assigned to multiple players at the same time and as such this function will always return `true` for `INPUT_GENERIC_DEVICE`.

<!-- tabs:end -->

&nbsp;

## …DeviceIsConnected

`InputDeviceIsConnected(device)`

<!-- tabs:start -->

#### **Description**

**Returns:** Boolean, whether a device is connected

|Name    |Datatype|Purpose         |
|--------|--------|----------------|
|`device`|integer |Device to target|

Returns whether the device is connected to the system as a whole. This function will return`false` for devices that are unsupported on the current platform (e.g. keyboard on Xbox Series X). If a gamepad has been blocked due to incompatibility, this function will return `false`.

<!-- tabs:end -->

&nbsp;

## …DeviceIsGamepad

`InputDeviceIsGamepad(device)`

<!-- tabs:start -->

#### **Description**

**Returns:** Boolean, whether a device is a gamepad

|Name    |Datatype|Purpose         |
|--------|--------|----------------|
|`device`|integer |Device to target|

Returns whether a device is a gamepad. This function will still return `true` for gamepads that are not connected.

<!-- tabs:end -->

&nbsp;

## …DeviceGetAnyGamepadConnected

`InputDeviceGetAnyGamepadConnected(device)`

<!-- tabs:start -->

#### **Description**

**Returns:** Boolean, whether any gamepad is connected

|Name|Datatype|Purpose|
|----|--------|-------|
|None|        |       |

Returns whether any gamepad is connected.

<!-- tabs:end -->

&nbsp;

## …DeviceIsActive

`InputDeviceIsActive(device)`

<!-- tabs:start -->

#### **Description**

**Returns:** Boolean, whether a device is active due to a user pressing buttons, moving thumbsticks etc.

|Name    |Datatype|Purpose         |
|--------|--------|----------------|
|`device`|integer |Device to target|

Returns if a device is active due to a user pressing buttons, moving thumbsticks etc.  There is no timeout on this function and it will return `true` if there is activity at the moment the function is called. INPUT_GENERIC_DEVICE will always return `false`.

<!-- tabs:end -->

&nbsp;

## …DeviceGetNewActivity

`InputDeviceGetNewActivity(device)`

<!-- tabs:start -->

#### **Description**

**Returns:** Integer, the first device that has any activity

|Name|Datatype|Purpose|
|----|--------|-------|
|None|        |       |

Returns the first available (i.e. unassigned) device that has activity on it.

<!-- tabs:end -->

&nbsp;

## …DeviceCheckViaPlayer

`InputDeviceCheckViaPlayer(device)`

<!-- tabs:start -->

#### **Description**

**Returns:** Integer, the first device that has activity on a verb

|Name             |Datatype|Purpose                                                                                    |
|-----------------|--------|-------------------------------------------------------------------------------------------|
|`device`         |integer |Device to target                                                                           |
|`verbIndex`      |integer |Verb to check                                                                              |
|`[playerIndex=0]`|integer |Player whose bindings should be used to check input. If not specified, defaults to player 0|

Returns the first available (i.e. unassigned) device that has activity on a verb (as though a player had been assigned the device).

<!-- tabs:end -->

&nbsp;

## …DeviceGetDescription

`InputDeviceGetDescription(device)`

<!-- tabs:start -->

#### **Description**

**Returns:** String, a description for a device

|Name    |Datatype|Purpose         |
|--------|--------|----------------|
|`device`|integer |Device to target|

Returns a description for a device. If the device is a gamepad then the library will attempt to return a useful description.

!> Device descriptions should not be used for gameplay logic and should instead be limited to informing the player (or used for debug purposes).

<!-- tabs:end -->

&nbsp;

## …DeviceGetGamepadType

`InputDeviceGetGamepadType(device)`

<!-- tabs:start -->

#### **Description**

**Returns:** Integer, the gamepad type for the device

|Name    |Datatype|Purpose         |
|--------|--------|----------------|
|`device`|integer |Device to target|

Returns the type of gamepad that a device represents. If the device is not connected or isn't a gamepad to begin with then this function returns `INPUT_GAMEPAD_TYPE_NO_GAMEPAD`. Otherwise, this function will return a member of the `INPUT_GAMEPAD_TYPE_*` macros:
- `INPUT_GAMEPAD_TYPE_UNKNOWN`
- `INPUT_GAMEPAD_TYPE_XBOX`
- `INPUT_GAMEPAD_TYPE_PS4`
- `INPUT_GAMEPAD_TYPE_PS5`
- `INPUT_GAMEPAD_TYPE_SWITCH`
- `INPUT_GAMEPAD_TYPE_JOYCON_LEFT`
- `INPUT_GAMEPAD_TYPE_JOYCON_RIGHT`

<!-- tabs:end -->

&nbsp;

## …DeviceGetGamepadValue

`InputDeviceGetGamepadValue(device)`

<!-- tabs:start -->

#### **Description**

**Returns:** Integer, the gamepad type for the device

|Name     |Datatype|Purpose         |
|---------|--------|----------------|
|`device` |integer |Device to target|
|`binding`|any     |Binding to check|

Returns the current value being emitted from a binding for a gamepad. If the device isn't connected or isn't a gamepad then this function returns 0. This function will return 0 on platforms where the library does not support gamepads.

<!-- tabs:end -->

&nbsp;

## …DeviceGetSteamHandle

`InputDeviceGetSteamHandle(device)`

<!-- tabs:start -->

#### **Description**

**Returns:** Integer, the Steam handle for the device

|Name     |Datatype|Purpose         |
|---------|--------|----------------|
|`device` |integer |Device to target|

Return the Steam handle associated with a device. If the device isn't a gamepad this function will return `undefined`. If Steamworks has not been initialized (or isn't in the project), this function will return `undefined`. Finally, if Steam Input is not actively managing the gamepad then this function will return `undefined`.

<!-- tabs:end -->