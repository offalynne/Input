# Devices

&nbsp;

Input supports four fundamental types of device - keyboards, mice, touchscreens, and gamepads. Input treats each gamepad as a different and distinct device. Keyboard and mouse input is grouped together. Touchscreen input is considered different to mouse input. A device is represented in Input by an integer. Positive integers, including zero, are specifically gamepads and these device values directluy correlate to the native GameMaker gamepad indexes. Values less than zero are special values that Input uses to identify other devices (keyboard and mouse, touch, etc.). Please read on for more information on what devices Input supports.

Devices are assigned to players, with a particular device only being assigned to one player at a time. A player can only use one device at a time and it is not possible for players to share a device. A player may be assigned a device that is not itself connected; for example, a player may be assigned gamepad 2 even though that gamepad has been switched off. You can check if a player is using a connected device by calling `InputPlayerIsConnected()`. You can check whether a device is a gamepad by calling `InputDeviceIsGamepad()`.

By default, Input will attempt to hotswap between devices. You can turn hotswapping on and off by calling [`InputSetHotswap()`](Functions-(Hotswap)?id=sethotswap). By default, gamepad thumbstick input, mouse movement, and mouse button input will not trigger a hotswap due to these inputs being "noisy" and prone to false positives which can causing unpleasant rapid changes between device ("thrashing"). You can change [some config macros](Config?id=__inputconfig) to change this behaviour.

&nbsp;

## Device Types

### `Gamepad0`, `Gamepad1`, `Gamepad2`, etc.

Gamepads devices are referred to by their integer gamepad index as used natively in GameMaker. Gamepads cannot be assigned on mobile devices where this feature is unsupported by Input.

&nbsp;

### `INPUT_NO_DEVICE`

The player has not been assigned a device. You can set this value manually using `InputPlayerSetDevice()` to forcibly disconnect a player.

&nbsp;

### `INPUT_KBM`

A keyboard and/or mouse attached to the device. This device type is only available on dekstop platforms and will be unavailable on game consoles and mobile devices.

&nbsp;

### `INPUT_TOUCH`

A mobile touchscreen. Touchscreen input is not supported on Switch or Windows. You may want to use touch input with [virtual buttons](Functions-(Virtual-Buttons)). When testing virtual buttons on a desktop device you may find it helpful to be able to click virtual buttons without first deploying your game to a mobile device. By default, Input will not allow players using the `INPUT_KBM` device to interact with virtual buttons; however, if you set the [`INPUT_MOUSE_CAN_USE_VIRTUAL_BUTTONS` config macro](Config?id=input_mouse_can_use_virtual_buttons) to `true` then this limitation will be lifted.

&nbsp;

### `INPUT_GENERIC_DEVICE`

A special value that doesn't do anything by itself. A generic device is always considered connected. Generic devices will be inactive unless verb values are pushed to the player by calling `InputPlugInVerbSet()`. Generic devices are helpful for implementing input replay, a useful feature for debugging or multiplayer on occasion.