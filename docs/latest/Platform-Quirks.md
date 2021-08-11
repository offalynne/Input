_Input works to normalize behavior across supported platforms. Each platform brings it's own eccentricities, so this work is ongoing. Herein notable issues and limitations will be documented that may impact users of Input in their implementations, or impact the experience of players of games that have implemented Input. If you encounter platform-particular problems with Input, please consider [authoring a bug report](https://github.com/JujuAdams/Input/issues) or reaching us to discuss further [on Discord](https://discord.gg/8krYCqr)._

&nbsp;

## General

GameMaker has a naïve (and in many aspects broken) implementation of [SDL2's game controller mapping](https://wiki.libsdl.org/CategoryGameController) feature. Input offers [a sophisticated reimplementation](Controller-Mapping) on platforms with reliable drivers and available [vendor and product](https://docs.microsoft.com/en-us/windows-hardware/drivers/install/standard-usb-identifiers) information (Desktop platforms and Android), including support for axis inversion and range modifiers, and greatly expands the number of supported devices.

&nbsp;

## Desktop

Input is developed and maintained on desktop platforms and as a result is most oriented and thoroughly tested for desktop features. *The following is valid for native builds only. If you are using HTML5 for your game but are running on a desktop device, please see the [HTML5 section](#html5) for information on platform-specific quirks.*

### Windows

- As per GameMaker's default behaviour, device indexes from 0 to 3 inclusive are XInput gamepads. Devices 4 to 11 inclusive are DInput gamepads. XInput gamepads return less information about themselves than DInput and, as a result, some supplementary data (button labels etc.) may be inaccurate.

- [Controller mapping](Controller-Mapping) faces some limitations imposed by the implementation of SDL2's gamepad mapping. Specifically, the runtime is using an old version of the identifying string used to differentiate controllers, resulting in the feature being marginally limited on the platform.

- When windowed, the Alt+Space menu sticks. Input forces Space to release when Alt keys do.

- Input addresses a runtime bug (marked 'wontfix' by YYG) preventing touchpad taps from registering as mouse clicks when they are configured to do so by system software.

### MacOS 

- Keycode-to-keylabel behavior works differently than other desktop platforms, as such key labels are checked and corrected on binding.

- When left and right keyboard control keys (Ctrl, Alt/Options, Cmd, Shift) are chorded, they stick. Input forces both keys to release when either key in a pair is released. 

- When the Command key (⌘) is held, any subsequent keyboard input is queued for release when the Command key is. Input ignores all keys when the Command key is released.

- GameMaker's [controller mapping](Controller-Mapping) implementation has a bug regarding remapping devices in the inbuilt remapping database (marked "fixed" by YYG, though it persists). Input fixes this with a value offset for gamepad button and axis inputs.

### Ubuntu

- Keyboard input that results in printable characters outside the Basic-Latin character set are not detected, and can not be bound.

- Gamepads are sometimes misreported and often over-reported on the platform so [device blocking](Controller-Mapping#controller-blacklist) is particularly useful.

### Steam

- Steam Overlay intercepts certain key combinations that should be avoided when building a default keyboard scheme. By default these include `F12` and `Shift+Tab`. For more info see [Common Keyboard Combos](Common-Keyboard-Combos).

- Depending on user configuration, Steam may hide native controller devices from the Game Maker Studio runtime, presenting them as normalized virtual controllers. This is a helpful feature, but gathering more information about devices [may require extension](https://github.com/YAL-GameMaker/steamworks.gml) beyond the scope of Input.

- Steam Input and especially the Steam Controller make use of Mixed Input, an affordance Input is currently not optimized for. Support for Mixed Input should be improved in the future.

&nbsp;

## Console

### Switch

- Switch keyboard input is fully functional but unlikely to be needed, and therefore off by default. You can turn keyboard input on by [setting `INPUT_SWITCH_KEYBOARD_ALLOWED` to `true`](Functions-(System)#__input_config).

- Switch touchscreen input is fully functional. You may not want to allow this for your game, in which case you should omit default mouse input on Switch (via a check against `os_type`) to prevent touchscreen input being registered by Input.

### PS4 and PS5

- `gp_select` is defined as clicking the touchpad on PlayStation 4 and PlayStation 5 which is GameMaker's default behaviour. This is in contrast to other other platforms where `gp_select` is defined as the SHARE button. [`input_binding_get_name()`](Functions-(Bindings)#input_binding_get_namebinding) will return the correct device-appropriate string.

### Xbox One and Xbox Series X/S

- Gamepad descriptions are returned as empty strings but, otherwise, no known quirks. Good luck handling user accounts!

&nbsp;

## Mobile Native

*The following is valid for native builds only. If you are using HTML5 for your game but are running on a mobile device, please see the [HTML5 section](#html5) for information on platform-specific quirks.*

### iOS and tvOS

- Keyboard input is non-functional on these platforms owing to [unavoidable up-stream bugs](https://github.com/JujuAdams/Input/issues/138)

- Many gamepads are not fully supported by iOS due to limited support offered by Apple. At the time of writing, XBox One and PlayStation 4 wireless gamepads are supported by iOS, as are MFi controllers. For an up-to-date list, please check [Apple's communications](https://support.apple.com/en-us/HT210414).

- Users may find the Select (aka Share or View) gamepad button to cause unintended screenshot and video recording actions. These can be toggled on the OS at _Settings > General > Game Controller_
### Android

- Android keyboard input is problematic and so set to off by default. The most significant issue is keys regularly and irreparably sticking when modified using Shift keys. You can turn keyboard input on by [setting `INPUT_ANDROID_KEYBOARD_ALLOWED` to `true`](Functions-(System)#__input_config). If using this feature, it is not recommended to use bindings besides Arrow keys, Enter, Space, and Backspace.

- [Controller mapping](Controller-Mapping) faces some limitations imposed by the implementation of SDL2's gamepad mapping. Specifically, the runtime is using an old version of the identifying string used to differentiate controllers, resulting in the feature being marginally limited on the platform.

- Gamepads are sometimes misreported and often over-reported on the platform so [device blocking](Controller-Mapping#controller-blacklist) is particularly useful.

- Due to GameMaker's handling of the Android controller stack, some gamepads do not have functional dpad mappings.

- Switch Joycons are not properly handled by some versions of the Android kernel. As a result, they are not supported in some circumstances.

&nbsp;

## HTML5

- Web browsers have their own gamepad API, as such Input does not provide [controller mapping](Controller-Mapping) on the platform.

- In order for gamepads to present and operate, the user must first press a button with the game in focus.

- On Apple platforms, CapsLock key returns lock state rather than key state (`true` when locked), so is blocked from binding.

- The browser fullscreen toggle key (F10 on Apple devices, F11 elsewhere) is blocked from keyboard binding.