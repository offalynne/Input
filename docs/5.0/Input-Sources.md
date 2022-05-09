# Input Sources

&nbsp;

Input supports three fundamental types of source - keyboards, mice, and gamepads. Input treats each gamepad as a different and distinct device, and it also treats a keyboard and a mouse as different and distinct devices. Sources are assigned to players, with a particular source typically only being assigned to one player at a time. In the general case, a player may be assigned as many sources as you want, though in practice a player often only has one source at a time.

?> Having said this, when you first import Input into your project, keyboard and mouse input is tied together as this is by far and away the most common use case for keyboards and mice. You can change this behaviour through a [configuration macro](Configuration?id=profiles-and-bindings).

Input defaults to running in "hotswap source mode" when you run your game, a behaviour controlled by [`INPUT_STARTING_SOURCE_MODE`](Configuration?id=source-modes). This means that player 0 will dynamically change source depending on what source the player is interacting with. You can read more about source modes below. You can also manually set any player's input source with [`input_source_set()`](Functions-(Sources)?id=input_source_setsource-playerindex-autoprofile).

You can refer to sources in code by using the `INPUT_KEYBOARD`, `INPUT_MOUSE` or `INPUT_GAMEPAD[n]` constants. If `INPUT_ASSIGN_KEYBOARD_AND_MOUSE_TOGETHER` is set to `true` then the keyboard and the mouse will be considered as a single device: `INPUT_KEYBOARD` and `INPUT_MOUSE` will be interchangeable.

!> `INPUT_GAMEPAD` is an array and you'll need to use standard array syntax to access individual gamepads (i.e. `INPUT_GAMEPAD[0]` is the 0th gamepad).

&nbsp;

## Source Modes

Input can run in one of five "source modes". These control how Input manages sources, if at all. You can change the source mode by using [`input_source_mode_set()`](Functions-(Sources)?id=input_source_mode_setmode) and you can return the current source mode with [`input_source_mode_get()`](Functions-(Sources)?id=input_source_mode_get).

?> Source modes replace the old "hotswap tick" and "source assignment tick" functions from version 4.

&nbsp;

### `INPUT_SOURCE_MODE.FIXED`

Input will not change sources automatically and you are responsible for managing sources yourself. This is useful as an in-game state for both single player and multiplayer gameplay where you don't want unexpected changes to occur. The auto profile when in hotswap mode is determined by which source the player is currently using.

&nbsp;

### `INPUT_SOURCE_MODE.JOIN`

Input will allow plays to "join" the game by pressing any button on a supported device. Player must join in ascending order, player 0 first, then player 1 etc. A player that has joined can leave by activating a specific verb. You can change the parameters for join mode by using [`input_multiplayer_params_set()`](Functions-(Players)?id=input_multiplayer_params_setmin-max-dropdown). [`input_multiplayer_is_finished()`](Functions-(Players)?id=input_multiplayer_is_finished) allows you to conveniently detect when enough players have joined the game based on the parameters you've set. The auto profile when in hotswap mode is determined by which source the player is currently using.

&nbsp;

### `INPUT_SOURCE_MODE.HOTSWAP`

Input will automatically swap sources for player 0 based on what source the player is currently interacting with. All other players will have their sources removed and will not be able to play. Input will never hotswap to a device that doesn't have a [default profile](Profiles) set up to avoid assigning a source to a player that is non-functional inside Input. If you want to allow Input to hotswap to e.g. the keyboard then you must create a [default profile](Profiles) for keyboard bindings. The auto profile when in hotswap mode is determined by which source the player is currently using.

!> This mode should only be used for single player gameplay. All players other than player 0 will have their sources removed and will not be able to play.

&nbsp;

### `INPUT_SOURCE_MODE.MIXED`

Input will accept input for player 0 from the keyboard, the mouse, and one gamepad. The gamepad that is active will be hotswapped and only one gamepad is active at a time. The auto profile when in mixed mode is determined by `INPUT_AUTO_PROFILE_FOR_MIXED`.

!> This mode should only be used for single player gameplay. All players other than player 0 will have their sources removed and will not be able to play.

&nbsp;

### `INPUT_SOURCE_MODE.MULTIDEVICE`

Input will accept input for player 0 from the keyboard, the mouse, and all gamepads. Unlike `INPUT_SOURCE_MODE.MIXED`, all gamepads are active in this mode. Additionally, gamepad bindings are tied to specific gamepad slots. The auto profile when in multidevice mode is determined by `INPUT_AUTO_PROFILE_FOR_MULTIDEVICE`.

!> This mode should only be used for single player gameplay. All players other than player 0 will have their sources removed and will not be able to play.