# Input Quirks by Device

---

Input works to normalize behavior across supported platforms. Each platform brings it's own eccentricities, so this work is ongoing. Herein notable issues and limitations will be documented that may impact users of Input in their implementations, or impact the experience of players of games that have implemented Input. For a list of upstream problems we are monitoring and related workarounds, see [upstream bug issues](https://github.com/JujuAdams/Input/issues?q=is%3Aissue+label%3A%22upstream+bug+%F0%9F%92%A7%22+).

&nbsp;

## General

By default, GameMaker handles double click on the left mouse button as a [right mouse button press](https://manual.yoyogames.com/index.htm#t=GameMaker_Language%2FGML_Reference%2FGame_Input%2FDevice_Input%2Fdevice_mouse_dbclick_enable.htm). Since we aim to correctly support all available mouse buttons and offer comprehensive double-input checking, Input toggles this behaviour off.

&nbsp;

## Gamepad

GameMaker has a naive implementation of [SDL2's game controller mapping](https://wiki.libsdl.org/CategoryGameController) feature. Input offers [a sophisticated reimplementation](Controller-Mapping) on platforms with reliable drivers and available [vendor and product](https://docs.microsoft.com/en-us/windows-hardware/drivers/install/standard-usb-identifiers) information (Desktop platforms and Android), including support for axis inversion and range modifiers, and greatly expands the number of supported devices.

On many platforms, gamepad indices do not enumerate predicatbly. Use source assignment or source hotswap features to avoid assigning players a gamepad index manually.

### Gamepad on Desktop

!> The following is valid for native builds only. If you are using HTML5 for your game but are running on a desktop device, please see the [HTML5 section](#gamepad-on-html5) for information on platform-specific quirks.

- On Windows, as per GameMaker’s default behaviour, device indexes from 0 to 3 inclusive are XInput gamepads. Devices 4 to 11 inclusive are DInput gamepads. XInput gamepads return less information about themselves than DInput and, as a result, some supplementary data (button labels etc.) may be inaccurate.

- On desktop, gamepad vibration is *only* available for Windows XInput gamepads. Enabling vibration for additional gamepads requires the [Steamwork extension](Steamworks).

- On Windows, [game controller mapping](Controller-Mapping) faces some limitations imposed by the implementation of SDL2's gamepad mapping. Specifically, the runtime is using an old version of the identifying string used to differentiate controllers, resulting in the feature being marginally limited on the platform.

- On Windows OS versions below Windows 10, some Bluetooth controllers fail to operate correctly. This is a system-level problem beyond our capability to address.

- On Windows, Xbox Game Bar is known to be problematic for Xbox gamepad use with many games including the Game Maker Studio runtime causing application freezing and slowdown. [Disabling Xbox Game Bar](https://www.epicgames.com/help/en-US/rocket-league-c5719357623323/troubleshooting-c7261971242139/how-do-i-turn-off-game-mode-xbox-game-bar-and-captures-on-my-pc-to-improve-rocket-league-s-performance-a5720078869147) may resolve the issue.

- On MacOS, GameMaker's [game controller mapping](Controller-Mapping) implementation has a bug regarding remapping devices in the inbuilt remapping database (marked "fixed" by YYG, though it persists). Input fixes this with a value offset for gamepad button and axis inputs.

- On MacOS, the "gamepad select" button takes a screenshot on double press and records video on long press. Be aware when setting default bindings that this can be problematic for users with the feature enabled (default OS behaviour).

- On Ubuntu, gamepads are sometimes misreported and often over-reported so [device blocking](Controller-Mapping#controller-blacklist) is particularly useful.

- On Ubuntu, gamepad joystick axes are not signed. GameMaker attempts to automatically sign joystick axes when they connect, but this change is discarded when gamepads are remapped. Input automatically adjusts joystick axes' range on remapping in order to resolve this.

- Steam performs some initial changes in gamepad connection depending on available devices and the configuration of Steam Input. Input waits a configurable number of frames before scanning for connected gamepads to prevent unwanted false connection and disconnection reportage.

- Depending on user configuration, Steam may hide native gamepad devices from the Game Maker Studio runtime, presenting them as normalized virtual gamepads. For virtual gamepad identification, see [Configuring Steamworks for Input](Steamworks.md).

### Gamepad on Console

- On PS4 and PS5, `gp_select` is defined as clicking the touchpad on PlayStation 4 and PlayStation 5 which is GameMaker's default behaviour. This is in contrast to other other platforms where `gp_select` is defined as the SHARE button. [`input_binding_get_name()`](Functions-(Binding-Access)#input_binding_get_namebinding) will return the correct device-appropriate string.

- On Switch, the first gamepad index is reserved for physically attached Joy-Cons, or the builtin controls on the Lite model.

### Gamepad on Mobile

!> The following is valid for native builds only. If you are using HTML5 for your game but are running on a desktop device, please see the [HTML5 section](#gamepad-on-html5) for information on platform-specific quirks.

- Many gamepads are not fully supported by iOS due to limited support offered by Apple. At the time of writing, XBox One and PlayStation 4 wireless gamepads are supported by iOS, as are MFi gamepads. For an up-to-date list, please check [Apple's communications](https://support.apple.com/en-us/HT210414).

- On iOS, users may find the Select (aka Share or View) gamepad button to cause unintended screenshot and video recording actions. These can be toggled on the OS at _Settings > General > Game Controller_.

- On iOS, gamepad indices start at 1 instead of 0.

- On Android, [Game controller mapping](Controller-Mapping) faces some limitations imposed by the implementation of SDL2's gamepad mapping. Specifically, the runtime is using an old version of the identifying string used to differentiate gamepads, resulting in the feature being marginally limited on the platform.

- On Android, gamepads are sometimes misreported and often over-reported, so [device blocking](Controller-Mapping#controller-blacklist) is particularly useful.

- On Android, gamepad indices do not enumerate predictably.

- On Android, due to GameMaker's handling of the Android gamepad stack, some gamepads do not have functional dpad mappings.

- On Android, Switch JoyCons are not properly handled by some versions of the kernel. As a result, they are not supported in some circumstances.

### Gamepad on HTML5

- Web browsers have their own gamepad API, as such Input does not use its own [game controller mapping](Controller-Mapping) on the HTML5 platform. Input will use the browser's gamepad implementation, including button mapping.

- On the HTML5 platform, in order for gamepads to present and operate, the user must first press a button with the game in focus.

&nbsp;

## Keyboard

### Keyboard on Desktop

!> The following is valid for native builds only. If you are using HTML5 for your game but are running on a desktop device, please see the [HTML5 section](#keyboard-on-console-mobile-and-html5) for information on platform-specific quirks.

- On Windows, when the game is running in a window, the Alt+Space menu sticks. Input forces Space to release when Alt keys do.

- On MacOS, keycode-to-keylabel behavior works differently than other desktop platforms, as such key labels are checked and corrected on binding.

- On MacOS, when left and right keyboard control keys (Ctrl, Alt/Options, Cmd, Shift) are chorded, they stick. Input forces both keys to release when either key in a pair is released. 

- On MacOS, when the Command key (⌘) is held, any subsequent keyboard input is queued for release when the Command key is. Input ignores all keys when the Command key is released.

- On Ubuntu, keyboard input that results in printable characters outside the Basic-Latin character set are not detected, and can not be bound.

- Steam Overlay intercepts certain key combinations that should be avoided when building a default keyboard scheme. By default these include `F12` and `Shift+Tab`. For more info see [Common Keyboard Combos](Common-Keyboard-Combos).

- Steam Input and especially the Steam Controller gamepad make use of Mixed Input, an affordance Input is currently not optimized for. Support for Mixed Input should be improved in the future.

### Keyboard on Console, Mobile and HTML5

- On Switch, Keyboard input is fully functional but unlikely to be needed, and therefore off by default. You can turn keyboard input on by [setting `INPUT_SWITCH_KEYBOARD_ALLOWED` to `true`](Config-Macros).

- Android keyboard input is problematic and so set to off by default. The most significant issue is keys regularly and irreparably sticking when modified using Shift keys. You can turn keyboard input on by [setting `INPUT_ANDROID_KEYBOARD_ALLOWED` to `true`](Config-Macros). If using this feature, it is not recommended to use bindings besides Arrow keys, Enter, Space, and Backspace.

- On the HTML platform, the browser fullscreen toggle key (F10 on Apple devices, F11 elsewhere) is blocked from keyboard binding.

&nbsp;

## Pointing Devices (Mouse and Touch)

### Pointing Devices on Desktop

- Input blocks mouse button presses that change window focus in order to prevent undesired game input or binding.

- Touch devices are not supported by GameMaker on desktop MacOS or Linux.

### Pointing Devices on Mobile, Switch, and HTML5

- Touchscreen input is functional on devices supporting a device-relative number of touches.

- Mouse input is partially functional. GameMaker uses the first mouse "device" for both touchscreen input and mouse, so there is no certain way to determine which is in use. By default mouse input is off (see above).

### DualShock 4 and DualSense touchpad input on PS4 and PS5

- The PlayStation touchpad presents as a mouse cursor. By default Input ignores touch input on the touchpad.

!> Mouse input is not supported by GameMaker (and Input) on the PS4, PS5, Xbox One or Xbox Series X/S platforms.
