# Hotswap

&nbsp;

## …SetHotswap

`InputSetHotswap(state)`

<!-- tabs:start -->

#### **Description**

**Returns:** N/A (`undefined`)

|Name    |Datatype|Purpose             |
|--------|--------|--------------------|
|`state` |boolean |Hotswap state to set|

Sets the hotswapping state. If set to `true` then all players other than player 0 will have their device set to `INPUT_NO_DEVICE`. When hotswap is enabled, the library will wait until player 0's current device reports that has been inactive for a short period of time. Once player 0's device is inactive then the library will search for activity on any other connected device. If activity is found then that device will be assigned the player 0.

You may specify a function to call when a hotswap occurs by calling `InputSetHotswapCallback()`.

?> Hotswap is not available on mobile devices.

<!-- tabs:end -->

&nbsp;

## …GetHotswap

`InputGetHotswap()`

<!-- tabs:start -->

#### **Description**

**Returns:** Boolean, whether hotswap has been enabled

|Name|Datatype|Purpose|
|----|--------|-------|
|None|        |       |

Returns whether hotswapping for player 0 is turned on.

<!-- tabs:end -->

&nbsp;

## …SetHotswap

`InputSetHotswapCallback(callback)`

<!-- tabs:start -->

#### **Description**

**Returns:** N/A (`undefined`)

|Name      |Datatype|Purpose                             |
|----------|--------|------------------------------------|
|`callback`|method  |Method to call when a hotswap occurs|

Sets a callback to execute when a hotswap occurs. The callbac is executed with no parameters.

<!-- tabs:end -->