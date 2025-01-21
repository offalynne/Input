# Input Sources

&nbsp;

Input supports four fundamental types of source - keyboards, mice, touchscreens, and gamepads. Input treats each gamepad as a different and distinct device, and it can also treat a keyboard, a mouse, and a touchscreen as different and distinct devices. Input sources may be managed automatically by the [default source mode](Source-Modes).

?> When you first import Input into your project, `INPUT_ASSIGN_KEYBOARD_AND_MOUSE_TOGETHER` is set to `true`, meaning keyboard and mouse input is tied together. This is by far and away the most common use case for keyboards and mice. You can change this behaviour by [adjusting this macro](Config-Macros?id=profiles).

Sources are assigned to players, with a particular source **typically** only being assigned to one player at a time. In the general case, a player may be assigned as many sources as you want, though in practice a player often only has one source at a time. It is possible for more than one player to use the same source. This is useful for two players sharing a keyboard or a gamepad (examples being [Overcooked](https://store.steampowered.com/app/448510/Overcooked/), [KeyWe](https://store.steampowered.com/app/1242980/KeyWe/), and [Fling to the Finish](https://store.steampowered.com/app/1054430/Fling_to_the_Finish/)). You'll need to use [`input_source_share()`](Functions-(Sources)?id=source_share) to split a source between multiple players.

Some functions also allow you to automatically change a player's [profile](Profiles) depending on what source they're using (and what source mode Input is running in). This is called an "auto profile" and can be set up by changing the [auto profile configuration macros](Config-Macros?id=profiles) and ensuring that this profile has been added to `__input_config_verbs()`. For example, if `INPUT_AUTO_PROFILE_FOR_GAMEPAD` is set to `"default_gamepad"` then when automatically setting a profile for a player that is using a gamepad, the `default_gamepad` profile will be used.

&nbsp;

## Source Types

### `INPUT_KEYBOARD`

A keyboard attached to the device. If no keyboard is available this source will be non-functional. If `INPUT_ASSIGN_KEYBOARD_AND_MOUSE_TOGETHER` is set to `true` then the keyboard and the mouse will be considered as a single device: `INPUT_KEYBOARD` and `INPUT_MOUSE` will be interchangeable.

&nbsp;

### `INPUT_MOUSE`

A pointing device, typically a physical mouse or a laptop trackpad. If `INPUT_ASSIGN_KEYBOARD_AND_MOUSE_TOGETHER` is set to `true` then the keyboard and the mouse will be considered as a single device: `INPUT_KEYBOARD` and `INPUT_MOUSE` will be interchangeable.

&nbsp;

### `INPUT_TOUCH`

A mobile touchscreen, a Switch touchscreen, a Steam Deck touchscreen (Proton or Windows). If the platform relevant mouse configuration (`INPUT_MOBILE_MOUSE`, `INPUT_SWITCH_MOUSE`) is set to `true`, `INPUT_TOUCH` devices will be treated as `INPUT_MOUSE` instead.

?> Windows touchscreen devices report `INPUT_MOUSE` by default because we cannot differentiate Windows touchscreens from a physical mouse. This behavior can be changed by setting `INPUT_WINDOWS_TOUCH` to `true`.

&nbsp;

### `INPUT_GAMEPAD[...]`

A gamepad with the given index (which matches GM's native gamepad indexes). `INPUT_GAMEPAD` is an array and you'll need to use standard array syntax to access individual gamepads (i.e. `INPUT_GAMEPAD[0]` is the 0th gamepad). The length of this array is dynamic and has no fixed sized. Not every gamepad in the `INPUT_GAMEPAD` array will necessarily be active; indeed, not every gamepad will be valid for a given platform. For example, on the Windows platform gamepads 0-3 are reserved for XInput devices, on Switch gamepad 0 is reserved for attached controls, and on iOS gamepad 0 is never available. You should only assign gamepad sources if you have positively identified the gamepad is connected and usable, typically by calling [`input_source_detect_input()`](Functions-(Sources)?id=source_detect_input).
