# Input Sources

&nbsp;

Input supports three fundamental types of source - keyboards, mice, and gamepads. Input treats each gamepad as a different and distinct device, and it can also treat a keyboard and a mouse as different and distinct devices. 

?> When you first import Input into your project, `INPUT_ASSIGN_KEYBOARD_AND_MOUSE_TOGETHER` is set to `true`, meaning keyboard and mouse input is tied together. This is by far and away the most common use case for keyboards and mice. You can change this behaviour by [adjusting this macro](Configuration?id=profiles-and-bindings).

Sources are assigned to players, with a particular source **typically** only being assigned to one player at a time. In the general case, a player may be assigned as many sources as you want, though in practice a player often only has one source at a time. It is possible for more than one player to use the same source. This is useful for two players sharing a keyboard or a gamepad (examples being [Overcooked](https://store.steampowered.com/app/448510/Overcooked/), [KeyWe](https://store.steampowered.com/app/1242980/KeyWe/), and [Fling to the Finish](https://store.steampowered.com/app/1054430/Fling_to_the_Finish/)). You'll need to use [`input_source_share()`](Functions-(Sources)?id=input_source_sharesource-playerindex-autoprofile) to split a source between multiple players.

Some functions also allow you to automatically change a player's [profile](Profiles) depending on what source they're using (and what source mode Input is running in). This is called an "auto profile" and can be set up by changing the [auto profile configuration macros](Configuration?id=profiles-and-bindings) and ensuring that this profile has been added to [`INPUT_DEFAULT_PROFILES`](Configuration?id=profiles-and-bindings). For example, if `INPUT_AUTO_PROFILE_FOR_GAMEPAD` is set to `"default_gamepad"` then when automatically setting a profile for a player that is using a gamepad, the `default_gamepad` profile will be used.

&nbsp;

## Source Types

### `INPUT_KEYBOARD`


A keyboard attached to the device. If no keyboard is available this source will be non-functional. If `INPUT_ASSIGN_KEYBOARD_AND_MOUSE_TOGETHER` is set to `true` then the keyboard and the mouse will be considered as a single device: `INPUT_KEYBOARD` and `INPUT_MOUSE` will be interchangeable.

### `INPUT_MOUSE`

A pointing device, either an actual mouse, touchscreen input, or a PS4 touchpad. If `INPUT_ASSIGN_KEYBOARD_AND_MOUSE_TOGETHER` is set to `true` then the keyboard and the mouse will be considered as a single device: `INPUT_KEYBOARD` and `INPUT_MOUSE` will be interchangeable.

### `INPUT_GAMEPAD[...]`

A gamepad with the given index (which matches GM's native gamepad indexes). `INPUT_GAMEPAD` is an array and you'll need to use standard array syntax to access individual gamepads (i.e. `INPUT_GAMEPAD[0]` is the 0th gamepad). The length of this array is given by `INPUT_MAX_TRACKED_GAMEPADS`. Not every gamepad in the `INPUT_GAMEPAD` array will be active; indeed, not every gamepad will be valid for a given platform. For example, on the Windows platform gamepads 0-3 are reserved for XInput devices, on Switch gamepad 0 is reserved for attached controls, and on iOS gamepad 0 is never available. You should only assign gamepad sources if you have positively identified the gamepad is connected and usable, typically by calling [`input_source_detect_input()`](Functions-(Sources)?id=input_source_detect_inputsource).

&nbsp;

## Source Modes

Input can run in one of five "source modes". These control how Input manages sources, if at all. You can change the source mode by using [`input_source_mode_set()`](Functions-(Sources)?id=input_source_mode_setmode) and you can return the current source mode with [`input_source_mode_get()`](Functions-(Sources)?id=input_source_mode_get).

?> Source modes replace the old "hotswap tick" and "source assignment tick" functions from version 4.

Input defaults to running in "hotswap source mode" when you run your game, a behaviour controlled by [`INPUT_STARTING_SOURCE_MODE`](Configuration?id=source-modes). This means that player 0 will dynamically change source depending on what source the player is interacting with. You can read more about source modes below. You can also manually set any player's input source with [`input_source_set()`](Functions-(Sources)?id=input_source_setsource-playerindex-autoprofile).

### `INPUT_SOURCE_MODE.FIXED`

Input will not change sources automatically and you are responsible for managing sources yourself. This is useful as an in-game state for both single player and multiplayer gameplay where you don't want unexpected changes to occur. The auto profile when in hotswap mode is determined by which source the player is currently using.

### `INPUT_SOURCE_MODE.JOIN`

Input will allow plays to "join" the game by pressing any button on a supported device. Player must join in ascending order, player 0 first, then player 1 etc. A player that has joined can leave by activating a specific verb. You can change the parameters for join mode by using [`input_multiplayer_params_set()`](Functions-(Players)?id=input_multiplayer_params_setmin-max-dropdown). [`input_multiplayer_is_finished()`](Functions-(Players)?id=input_multiplayer_is_finished) allows you to conveniently detect when enough players have joined the game based on the parameters you've set. The auto profile when in hotswap mode is determined by which source the player is currently using.

### `INPUT_SOURCE_MODE.HOTSWAP`

Input will automatically swap sources for player 0 based on what source the player is currently interacting with. All other players will have their sources removed and will not be able to play. Input will never hotswap to a device that doesn't have a [default profile](Profiles) set up to avoid assigning a source to a player that is non-functional inside Input. If you want to allow Input to hotswap to e.g. the keyboard then you must create a [default profile](Profiles) for keyboard bindings. The auto profile when in hotswap mode is determined by which source the player is currently using.

!> This mode should only be used for single player gameplay. All players other than player 0 will have their sources removed and will not be able to play.

### `INPUT_SOURCE_MODE.MIXED`

Input will accept input for player 0 from the keyboard, the mouse, and all gamepad. All gamepad bindings in the active [profile](Profiles) will listen for any connected gamepads; effectively all gamepad input in funnelled through the gamepad bindings that have been defined. The auto profile when in mixed mode is determined by `INPUT_AUTO_PROFILE_FOR_MIXED`.

!> This mode should only be used for single player gameplay. All players other than player 0 will have their sources removed and will not be able to play.

### `INPUT_SOURCE_MODE.MULTIDEVICE`

Input will accept input for player 0 from the keyboard, the mouse, and all gamepads. Unlike `INPUT_SOURCE_MODE.MIXED`, gamepad bindings are tied to specific gamepad indexes rather than arbitrarily scanning all connected gamepads. This allows multiple unique gamepads to have unique bindings that then trigger specific verbs. The auto profile when in multidevice mode is determined by `INPUT_AUTO_PROFILE_FOR_MULTIDEVICE`, though is it almost certain that a player will want to manually rebind their controls in this source mode.

!> This mode should only be used for single player gameplay. All players other than player 0 will have their sources removed and will not be able to play.
