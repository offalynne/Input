# Input Quirks by Platform

---

Input works to normalize behavior across supported platforms. Each platform brings it's own eccentricities, so this work is ongoing. Herein notable issues and limitations will be documented that may impact users of Input in their implementations, or impact the experience of players of games that have implemented Input. For a list of upstream problems we are monitoring and related workarounds, see [upstream bug issues](https://github.com/JujuAdams/Input/issues?q=is%3Aissue+label%3A%22upstream+bug+%F0%9F%92%A7%22+).

&nbsp;

## General

By default, GameMaker handles double click on the left mouse button as a [right mouse button press](https://manual.yoyogames.com/index.htm#t=GameMaker_Language%2FGML_Reference%2FGame_Input%2FDevice_Input%2Fdevice_mouse_dbclick_enable.htm). Since we aim to correctly support all available mouse buttons and offer comprehensive double-input checking, Input toggles this behaviour off.


&nbsp;

## Desktop

!> The following is valid for native builds only. If you are using HTML5 for your game but are running on a desktop device, please see the [HTML5 section](#html5) for information on platform-specific quirks.

- Input blocks mouse button presses that regain window focus in order to prevent undesired game input or binding.

- Touch devices are not supported by GameMaker on MacOS or Linux.

### Windows

- As per GameMaker's default behaviour, device indexes from 0 to 3 inclusive are XInput gamepads. Devices 4 to 11 inclusive are DInput gamepads. XInput gamepads return less information about themselves than DInput and, as a result, some supplementary data (button labels etc.) may be inaccurate.

- Gamepad vibration is only available for Windows XInput gamepads. Enabling vibration for additional gamepads requires the [Steamworks extension](Steamworks).

- On OS versions below Windows 10, some Bluetooth gamepads fail to operate correctly. This is a system-level problem beyond our capability to address.

- Xbox Game Bar is known to be problematic for Xbox gamepad use with many games including the Game Maker Studio runtime causing application freezing and slowdown. [Disabling Xbox Game Bar](https://www.epicgames.com/help/en-US/rocket-league-c5719357623323/troubleshooting-c7261971242139/how-do-i-turn-off-game-mode-xbox-game-bar-and-captures-on-my-pc-to-improve-rocket-league-s-performance-a5720078869147) may resolve the issue.

- When windowed, the Alt+Space menu sticks. Input forces Space to release when Alt keys do.

- Input addresses a runtime bug (marked 'wontfix' by YYG) preventing touchpad taps from registering as mouse clicks when they are configured to do so by system software.

### MacOS 

- Keycode-to-keylabel behavior works differently than other desktop platforms, as such key labels are checked and corrected on binding.

- When left and right keyboard control keys (Ctrl, Alt/Options, Cmd, Shift) are chorded, they stick. Input forces both keys to release when either key in a pair is released. 

- When the Command key (⌘) is held, any subsequent keyboard input is queued for release when the Command key is. Input ignores all keys when the Command key is released.

- The "gamepad select" button takes a screenshot on double press and records video on long press. Be aware when setting default bindings that this can be problematic for users with the feature enabled (default OS behaviour).

- GameMaker does not support gamepad vibration on this platform

### Ubuntu

- Keyboard input that results in printable characters outside the Basic-Latin character set are not detected, and can not be bound.

- Gamepad indices do not enumerate predictably. Use source assignment or source hotswap features to avoid assigning players a gamepad index manually.

- GameMaker does not support gamepad vibration on this platform

### Steam

- Steam performs some initial changes in gamepad connection depending on available devices and the configuration of Steam Input. Input waits a configurable number of frames before scanning for connected gamepads to prevent unwanted false connection and disconnection reportage.

- Steam Overlay intercepts certain key combinations that should be avoided when building a default keyboard scheme. By default these include `F12` and `Shift+Tab`. For more info see [Common Keyboard Combos](Common-Keyboard-Combos).

- Depending on user configuration, Steam may hide native gamepad devices from the Game Maker Studio runtime, presenting them as normalized virtual gamepads. For virtual gamepad identification support, see [Configuring Steamworks for Input](Steamworks.md).

&nbsp;

## Console

### Switch

- Keyboard input is fully functional but unlikely to be needed, and therefore off by default. You can turn keyboard input on by [setting `INPUT_SWITCH_KEYBOARD_ALLOWED` to `true`](Config-Macros).

- Mouse input is partially functional. GameMaker uses the first mouse "device" for both touchscreen input and mouse, so there is no certain way to determine which is in use. Mouse support includes right click and updates when the mouse is moved. By default mouse input is off (see below).

- Switch touchscreen input is fully functional supporting 10 touch points. By default Input ignores the touchscreen.

- The first gamepad index is reserved for physically attached Joy-Cons, or the builtin controls on a Switch Lite.

### PS4 and PS5

- `gp_select` is defined as clicking the touchpad on PlayStation which is GameMaker's default behaviour. This is in contrast to other other platforms where `gp_select` is defined as the SHARE or CREATE button. [`input_binding_get_name()`](Functions-(Binding-Access)#input_binding_get_namebinding) will return the correct device-appropriate string.

- Keyboard is not supported by GameMaker (and Input) on this platform.

- The PlayStation touchpad presents as a mouse cursor. By default Input ignores touch input on the touchpad. Input presently supports touchpad input for one player only.

### Xbox One and Xbox Series X/S

- Keyboard and mouse are not supported by GameMaker (and Input) on this platform.

&nbsp;

## Mobile

!> The following is valid for native builds only. If you are using HTML5 for your game but are running on a mobile device, please see the [HTML5 section](#html5) for information on platform-specific quirks.

### iOS and tvOS

- Keyboard input is non-functional on these platforms owing to [unavoidable up-stream bugs](https://github.com/JujuAdams/Input/issues/138)

- iOS touchscreen input is fully functional supporting 5 touch points on iPhone and 11 on iPad.

- Mouse input is partially functional. GameMaker uses the first mouse "device" for both touchscreen input and mouse, so there is no certain way to determine which is in use. Mouse position updates when the mouse is clicked. By default mouse input is off (see above).

- Many gamepads are not fully supported by iOS due to limited support offered by Apple. At the time of writing, XBox One and PlayStation 4 wireless gamepads are supported by iOS, as are MFi gamepads. For an up-to-date list, please check [Apple's communications](https://support.apple.com/en-us/HT210414).

- Gamepad indices start at 1 instead of 0. Use source assignment or source hotswap features to avoid assigning players a gamepad index manually.

- Users may find the Select (aka Share or View) gamepad button to cause unintended screenshot and video recording actions. These can be toggled on the OS at _Settings > General > Game Controller_

### Android

- Android keyboard input is problematic and so set to off by default. The most significant issue is keys regularly and irreparably sticking when modified using Shift keys. You can turn keyboard input on by [setting `INPUT_ANDROID_KEYBOARD_ALLOWED` to `true`](Config-Macros). If using this feature, it is not recommended to use bindings besides Arrow keys, Enter, Space, and Backspace.

- Android touchscreen input is fully functional supporting a device-relative number of touches up to 11.

- Mouse input is partially functional. GameMaker uses the first mouse "device" for both touchscreen input and mouse, so there is no certain way to determine which is in use. Mouse position updates when the mouse is clicked. By default mouse input is off (see above).

- Gamepad indices do not enumerate predictably. Use source assignment or source hotswap features to avoid assigning players a gamepad index manually.

- Switch JoyCons are not properly handled by some versions of the Android kernel. As a result, they are not supported in some circumstances.

&nbsp;

## HTML5

- In order for gamepads to present and operate, the user must first press a button with the game in focus.

- Touchscreen input is functional on mobile devices supporting a device-relative number of touches up to 11.

- On Apple platforms, CapsLock key returns lock state rather than key state (`true` when locked), so is blocked from binding.

- The browser fullscreen toggle key (F10 on Apple devices, F11 elsewhere) is blocked from keyboard binding.
