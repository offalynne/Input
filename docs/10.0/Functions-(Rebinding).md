# Rebinding

&nbsp;

## …BindingFind

`InputBindingFind(forGamepad, binding, [playerIndex=0])`

<!-- tabs:start -->

#### **Description**

**Returns:** Array of structs,

|Name           |Datatype|Purpose                                                                         |
|---------------|--------|--------------------------------------------------------------------------------|
|`forGamepad`   |boolean |Whether to set the binding for gamepads (`true`) or mouse and keyboard (`false`)|
|`verbIndex`    |integer |Verb to target                                                                  |
|`binding`      |binding |Character string or GameMaker `vk_*` `mb_*` `gp_*` constant to set              |
|`[alternate]`  |integer |Which alternate binding to target. If not specified, index 0 is used            |
|`[playerIndex]`|integer |Player to target. If not specified, player 0 is used                            |

Returns all verbs (and alternate slots) that use the specified binding. This function returns an array of structs. If the array is empty then no verbs that use the binding were found. The structs contain two values:

- `.verbIndex`  The verb using the binding
- `.alternate`  The alternate slot for that verb

<!-- tabs:end -->

&nbsp;

## …BindingGet

`InputBindingGet(forGamepad, verbIndex, [alternate=0], [playerIndex=0])`

<!-- tabs:start -->

#### **Description**

**Returns:** Binding, the binding set for the target verb and alternate

|Name           |Datatype|Purpose                                                                         |
|---------------|--------|--------------------------------------------------------------------------------|
|`forGamepad`   |boolean |Whether to get the binding for gamepads (`true`) or mouse and keyboard (`false`)|
|`verbIndex`    |integer |Verb to target                                                                  |
|`[alternate]`  |integer |Which alternate binding to target. If not specified, index 0 is used            |
|`[playerIndex]`|integer |Player to target. If not specified, player 0 is used                            |

Returns a binding for a player as set by `InputBindingSet()` or `InputDefineVerb()`. If the binding hasn't been set, this function returns `undefined`.
 
!> For left and up bindings on thumbsticks, the returned value will be negative.

<!-- tabs:end -->

&nbsp;

## …BindingSet

`InputBindingSet(forGamepad, verbIndex, binding, [alternate=0], [playerIndex=0])`

<!-- tabs:start -->

#### **Description**

**Returns:** N/A (`undefined`)

|Name           |Datatype|Purpose                                                                         |
|---------------|--------|--------------------------------------------------------------------------------|
|`forGamepad`   |boolean |Whether to set the binding for gamepads (`true`) or mouse and keyboard (`false`)|
|`verbIndex`    |integer |Verb to target                                                                  |
|`binding`      |binding |Character string or GameMaker `vk_*` `mb_*` `gp_*` constant to set              |
|`[alternate]`  |integer |Which alternate binding to target. If not specified, index 0 is used            |
|`[playerIndex]`|integer |Player to target. If not specified, player 0 is used                            |

Sets a binding for a player, overwriting the binding that was already there. If `forGamepad` is specified, the binding will be set for gamepad devices, otherwise the binding will be set for the keyboard and mouse device (`INPUT_KBM`). The alternate index parameter can be used to set multiple parallel bindings for one verb.

?> If you would like to specify a thumbstick binding that heads left or up, use the negative value of that binding e.g. `-gp_axislv` is an upwards push on the left thumbstick.

<!-- tabs:end -->

&nbsp;

## …BindingSetSafe

`InputBindingSetSafe(forGamepad, verbIndex, binding, [alternate=0], [playerIndex=0])`

<!-- tabs:start -->

#### **Description**

**Returns:** Boolean, whether the binding was successfully set

|Name           |Datatype|Purpose                                                                         |
|---------------|--------|--------------------------------------------------------------------------------|
|`forGamepad`   |boolean |Whether to set the binding for gamepads (`true`) or mouse and keyboard (`false`)|
|`verbIndex`    |integer |Verb to target                                                                  |
|`binding`      |binding |Character string or GameMaker `vk_*` `mb_*` `gp_*` constant to set              |
|`[alternate]`  |integer |Which alternate binding to target. If not specified, index 0 is used            |
|`[playerIndex]`|integer |Player to target. If not specified, player 0 is used                            |

Sets a binding for a player, overwriting the binding that was already there. If `forGamepad` is specified, the binding will be set for gamepad devices, otherwise the binding will be set for the keyboard and mouse device (`INPUT_KBM`). The alternate index parameter can be used to set multiple parallel bindings for one verb.

This function, unlike `InputBindingSet()`, will try to automatically resolve conflicts. This function is effective for simple control schemes but may fail in more complex situations; in these cases, you’ll need to handle conflict resolution yourself.

<!-- tabs:end -->

&nbsp;

## …BindingsExport

`InputBindingsExport(forGamepad, [playerIndex=0])`

<!-- tabs:start -->

#### **Description**

**Returns:** Struct, all bindings and alternates set for a player

|Name           |Datatype|Purpose                                                                         |
|---------------|--------|--------------------------------------------------------------------------------|
|`forGamepad`   |boolean |Whether to export bindings for gamepads (`true`) or mouse and keyboard (`false`)|
|`[playerIndex]`|integer |Player to target. If not specified, player 0 is used                            |

Returns a struct that contains the bindings set for a player. This can be saved to a savefile and restored using `InputBindingsImport()`.

!> Care should be taken not to change export names between savefile versions or the library will not be able to import old bindings from savefiles.

```
<!-- tabs:end -->

&nbsp;

## …BindingsImport

`InputBindingsImport(forGamepad, data, [playerIndex=0])`

<!-- tabs:start -->

#### **Description**

**Returns:** ,

|Name           |Datatype|Purpose                                                                         |
|---------------|--------|--------------------------------------------------------------------------------|
|`forGamepad`   |boolean |Whether to import bindings for gamepads (`true`) or mouse and keyboard (`false`)|
|`data`         |struct  |Binding struct to import                                                        |
|`[playerIndex]`|integer |Player to target. If not specified, player 0 is used                            |

Restores bindings from a struct created by `InputBindingsExport()`.

!> Care should be taken not to change export names between savefile versions or the library will not be able to import old bindings from savefiles.

<!-- tabs:end -->

&nbsp;

## …BindingsReset

`InputBindingsReset()`

<!-- tabs:start -->

#### **Description**

**Returns:** ,

|Name           |Datatype|Purpose                                                                         |
|---------------|--------|--------------------------------------------------------------------------------|
|`forGamepad`   |boolean |Whether to import bindings for gamepads (`true`) or mouse and keyboard (`false`)|
|`[playerIndex]`|integer |Player to target. If not specified, player 0 is used                            |

Resets all bindings to the defaults defined by `InputDefineVerb()`.

<!-- tabs:end -->

&nbsp;

## …BindingSwap

`InputBindingSwap(forGamepad, verbA, alternateA, verbB, alternateB, [playerIndex=0])`

<!-- tabs:start -->

#### **Description**

**Returns:** N/A (`undefined`)

|Name           |Datatype|Purpose                                                                           |
|---------------|--------|----------------------------------------------------------------------------------|
|`forGamepad`   |boolean |Whether to swap the bindings for gamepads (`true`) or mouse and keyboard (`false`)|
|`verbA`        |integer |First verb to target                                                              |
|`alternateA`   |integer |Which alternate binding to target                                                 |
|`verbB`        |integer |Second verb to target                                                             |
|`alternateB`   |integer |Which alternate binding to target                                                 |
|`[playerIndex]`|integer |Player to target. If not specified, player 0 is used                              |

Swaps over two bindings. Useful to resolve binding conflicts.

<!-- tabs:end -->

&nbsp;

## …DeviceGetRebinding

`InputDeviceGetRebinding(device)`

<!-- tabs:start -->

#### **Description**

**Returns:** ,

|Name    |Datatype|Purpose         |
|--------|--------|----------------|
|`device`|integer |Device to target|

Returns whether the device is currently set to scan for new bindings.

<!-- tabs:end -->

&nbsp;

## …DeviceGetRebindingResult

`InputDeviceGetRebindingResult(device)`

<!-- tabs:start -->

#### **Description**

**Returns:** Binding, a discovered binding from the device due to player input

|Name    |Datatype|Purpose         |
|--------|--------|----------------|
|`device`|integer |Device to target|

Returns a discovered binding emitted from the device. This function will return `undefined` if no new binding is detected or the device is not currently being scanned for new bindings.

!> This function will return a negative value if a thumbstick push is left or up e.g. `-gp_axislv` is an upwards push on the left thumbstick.

<!-- tabs:end -->

&nbsp;

## …DeviceSetRebinding

`InputDeviceSetRebinding(device, state, [ignoreStruct], [allowStruct])`

<!-- tabs:start -->

#### **Description**

**Returns:** ,

|Name            |Datatype|Purpose                                             |
|----------------|--------|----------------------------------------------------|
|`device`        |integer |Device to target                                    |
|`state`         |boolean |Whether the device should be put into rebinding mode|
|`[ignoreStruct]`|struct  |Struct of bindings to prohibit                      |
|`[allowStruct]` |struct  |Struct of bindings to allow                         |

Sets rebinding state for a device. The device will be scanned for all input. Discovered bindings can be returned by calling `InputDeviceGetRebindingResult()`. Only gamepads and keyboard and mouse (`INPUT_KBM`) devices can be scanned. Bindings to explicitly ignore and allow can be set up by passing structs into the optional `ignoreStruct` and `allowStruct`.

!> Input from a device that is being scanned will continue as normal. To prevent input leaking to e.g. interface navigation you should be careful to check against `InputDeviceGetRebinding()` where appropriate.

<!-- tabs:end -->

&nbsp;

## …DeviceStopAllRebinding

`InputDeviceStopAllRebinding()`

<!-- tabs:start -->

#### **Description**

**Returns:** N/A (`undefined`)

|Name|Datatype|Purpose|
|----|--------|-------|
|None|        |       |

Stops rebinding for all devices.

<!-- tabs:end -->
