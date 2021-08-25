# Input Quirks by Device

---

Input works to normalize behavior across supported platforms. Each platform brings it's own eccentricities, so this work is ongoing. Herein notable issues and limitations will be documented that may impact users of Input in their implementations, or impact the experience of players of games that have implemented Input. For a list of upstream problems we are monitoring and related workarounds, see [upstream bug issues](https://github.com/JujuAdams/Input/issues?q=is%3Aissue+label%3A%22upstream+bug+%F0%9F%92%A7%22+).

&nbsp;

## Gamepad

GameMaker has a naïve (and in many aspects broken) implementation of [SDL2's game controller mapping](https://wiki.libsdl.org/CategoryGameController) feature. Input offers [a sophisticated reimplementation](Controller-Mapping) on platforms with reliable drivers and available [vendor and product](https://docs.microsoft.com/en-us/windows-hardware/drivers/install/standard-usb-identifiers) information (Desktop platforms and Android), including support for axis inversion and range modifiers, and greatly expands the number of supported devices.

### Gamepad on Desktop

!> The following is valid for native builds only. If you are using HTML5 for your game but are running on a desktop device, please see the [HTML5 section](#gamepad-on-html5) for information on platform-specific quirks.

- On Windows, as per GameMaker’s default behaviour, device indexes from 0 to 3 inclusive are XInput gamepads. Devices 4 to 11 inclusive are DInput gamepads. XInput gamepads return less information about themselves than DInput and, as a result, some supplementary data (button labels etc.) may be inaccurate.

- On Windows, [Controller mapping](Controller-Mapping) faces some limitations imposed by the implementation of SDL2's gamepad mapping. Specifically, the runtime is using an old version of the identifying string used to differentiate controllers, resulting in the feature being marginally limited on the platform.

- On Windows OS versions below Windows 10, some Bluetooth controllers fail to operate correctly. This is a system-level problem beyond our capability to address.

- On MacOS, GameMaker's [controller mapping](Controller-Mapping) implementation has a bug regarding remapping devices in the inbuilt remapping database (marked "fixed" by YYG, though it persists). Input fixes this with a value offset for gamepad button and axis inputs.

- On Ubuntu, gamepads are sometimes misreported and often over-reported so [device blocking](Controller-Mapping#controller-blacklist) is particularly useful.

- On Ubuntu, gamepad joystick axes are not signed. GameMaker attempts to automatically sign joystick axes when they connect, but this change is discarded when gamepads are remapped. Input automatically adjusts joystick axes' range on remapping in order to resolve this.

- Depending on user configuration, Steam may hide native controller devices from the Game Maker Studio runtime, presenting them as normalized virtual controllers. This is a helpful feature, but gathering more information about devices [may require extension](https://github.com/YAL-GameMaker/steamworks.gml) beyond the scope of Input.

- Steam Input and especially the Steam Controller make use of Mixed Input, an affordance Input is currently not optimized for. Support for Mixed Input should be improved in the future.

### Gamepad on Console

- On Switch, while using individual JoyCons `gp_start` indicates the "+" or "-" buttons, returned as `gamepad start` by [`input_binding_get_name()`](Functions-(Bindings)#input_binding_get_namebinding). This differs from other platforms supporting the JoyCons (Desktop and Android) which uses the "-" button as `select` and the "Capture" button as `start` on the Left JoyCon.

- On PS4 and PS5, `gp_select` is defined as clicking the touchpad on PlayStation 4 and PlayStation 5 which is GameMaker's default behaviour. This is in contrast to other other platforms where `gp_select` is defined as the SHARE button. [`input_binding_get_name()`](Functions-(Bindings)#input_binding_get_namebinding) will return the correct device-appropriate string.

- On Xbox One and Series native (XDK builds), Gamepad descriptions are returned as empty strings

### Gamepad on Mobile

!> The following is valid for native builds only. If you are using HTML5 for your game but are running on a desktop device, please see the [HTML5 section](#gamepad-on-html5) for information on platform-specific quirks.

- Many gamepads are not fully supported by iOS due to limited support offered by Apple. At the time of writing, XBox One and PlayStation 4 wireless gamepads are supported by iOS, as are MFi controllers. For an up-to-date list, please check [Apple's communications](https://support.apple.com/en-us/HT210414).

- [Controller mapping](Controller-Mapping) faces some limitations imposed by the implementation of SDL2's gamepad mapping. Specifically, the runtime is using an old version of the identifying string used to differentiate controllers, resulting in the feature being marginally limited on the platform.

- Gamepads are sometimes misreported and often over-reported on the platform so [device blocking](Controller-Mapping#controller-blacklist) is particularly useful.

- Due to GameMaker's handling of the Android controller stack, some gamepads do not have functional dpad mappings.

- Switch JoyCons are not properly handled by some versions of the Android kernel. As a result, they are not supported in some circumstances.

### Gamepad on HTML5

- Web browsers have their own gamepad API, as such Input does not use its own [controller mapping](Controller-Mapping) on the HTML5 platform. Input will use the browser's gamepad implementation, including button mapping.

- On the HTML5 platform, in order for gamepads to present and operate, the user must first press a button with the game in focus.

### Gamepad on UWP

- Gamepads trigger keyboard events. As a result, certain keyboard keys are blocked by default; for more information see [`INPUT_IGNORE_RESERVED_KEYS_LEVEL`](Configuration).

- On UWP for Windows, XInput controllers work as expected. Some devices that fall outside the XInput ecosystem (e.g. Switch Pro, PS4, PS5, Luna and Stadia controllers) will work but may have unusual or partially incorrect bindings. 

- On UWP for Windows, gamepad type information is unavailable for devices except XInput controllers: descriptions are returned as `"XInput"` or `"Unknown UWP Controller"`.

- On UWP on Xbox One and Xbox Series X/S, gamepad descriptions are returned as `"XInput"`.

&nbsp;

## Keyboard

!> Keyboard is not supported by GameMaker (and Input) on the PS4, PS5, Xbox One, Xbox Series X/S, iOS or tvOS platforms.

### Keyboard on Desktop

!> The following is valid for native builds only. If you are using HTML5 for your game but are running on a desktop device, please see the [HTML5 section](#keyboard-on-console-mobile-and-html5) for information on platform-specific quirks.

- On Windows, when the game is running in a window, the Alt+Space menu sticks. Input forces Space to release when Alt keys do.

- On MacOS, keycode-to-keylabel behavior works differently than other desktop platforms, as such key labels are checked and corrected on binding.

- On MacOS, when left and right keyboard control keys (Ctrl, Alt/Options, Cmd, Shift) are chorded, they stick. Input forces both keys to release when either key in a pair is released. 

- On MacOS, when the Command key (⌘) is held, any subsequent keyboard input is queued for release when the Command key is. Input ignores all keys when the Command key is released.

- On Ubuntu, keyboard input that results in printable characters outside the Basic-Latin character set are not detected, and can not be bound.

- Steam Overlay intercepts certain key combinations that should be avoided when building a default keyboard scheme. By default these include `F12` and `Shift+Tab`. For more info see [Common Keyboard Combos](Common-Keyboard-Combos).

- Steam Input and especially the Steam Controller make use of Mixed Input, an affordance Input is currently not optimized for. Support for Mixed Input should be improved in the future.

### Keyboard on Console, Mobile and HTML5

- On Switch, Keyboard input is fully functional but unlikely to be needed, and therefore off by default. You can turn keyboard input on by [setting `INPUT_SWITCH_KEYBOARD_ALLOWED` to `true`](Configuration).

- Android keyboard input is problematic and so set to off by default. The most significant issue is keys regularly and irreparably sticking when modified using Shift keys. You can turn keyboard input on by [setting `INPUT_ANDROID_KEYBOARD_ALLOWED` to `true`](Configuration). If using this feature, it is not recommended to use bindings besides Arrow keys, Enter, Space, and Backspace.

- On the HTML platform, the browser fullscreen toggle key (F10 on Apple devices, F11 elsewhere) is blocked from keyboard binding.

### Keyboard on UWP

- Gamepads trigger keyboard events. As a result, certain keyboard keys are blocked by default on the platform; for more information see [`INPUT_IGNORE_RESERVED_KEYS_LEVEL`](Configuration).

- Keyboard input is supported (with the same caveats as on the [Windows platform](#Windows)).
