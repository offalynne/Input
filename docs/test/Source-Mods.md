# Source Modes

&nbsp;

Input can run in one of five "source modes". These control how Input manages sources, if at all. You can change the source mode by using [`input_source_mode_set()`](Functions-(Sources)?id=input_source_mode_setmode) and you can return the current source mode with [`input_source_mode_get()`](Functions-(Sources)?id=input_source_mode_get).

?> Source modes replace the old "hotswap tick" and "source assignment tick" functions from version 4.

Input defaults to running in "hotswap source mode" when you run your game, a behaviour controlled by [`INPUT_STARTING_SOURCE_MODE`](Configuration?id=source-modes). This means that player 0 will dynamically change source depending on what source the player is interacting with. You can read more about source modes below. You can also manually set any player's input source with [`input_source_set()`](Functions-(Sources)?id=input_source_setsource-playerindex-autoprofile).

### `INPUT_SOURCE_MODE.FIXED`

Input will not change sources automatically and you are responsible for managing sources yourself. This is useful as an in-game state for both single player and multiplayer gameplay where you don't want unexpected changes to occur. 

### `INPUT_SOURCE_MODE.JOIN`

Input will allow plays to "join" the game by pressing any button on a supported device. Players join in ascending order, and a player that has joined can leave by activating a specific verb. You can read more about the behaviour of this source mode in the [Multiplayer Guide](Multiplayer-Guide).

### `INPUT_SOURCE_MODE.HOTSWAP`

Input will automatically swap sources for player 0 based on what source the player is currently interacting with. All other players will have their sources removed and will not be able to play. Input will never hotswap to a device that doesn't have a [default profile](Profiles) set up to avoid assigning a source to a player that is non-functional inside Input. If you want to allow Input to hotswap to e.g. the keyboard then you must create a [default profile](Profiles) for keyboard bindings. The auto profile when in hotswap mode is determined by which source the player is currently using.

!> This mode should only be used for single player gameplay. All players other than player 0 will have their sources removed and will not be able to play.

### `INPUT_SOURCE_MODE.MIXED`

Input will accept input for player 0 from the keyboard, the mouse, and all gamepads. Input from all gamepads will be treated equally, and gamepads will not be differentiated. All gamepad bindings in the active [profile](Profiles) will listen for any connected gamepads; effectively all gamepad input in funnelled through the gamepad bindings that have been defined. The auto profile when in mixed mode is determined by `INPUT_AUTO_PROFILE_FOR_MIXED`.

!> This mode should only be used for single player gameplay. All players other than player 0 will have their sources removed and will not be able to play.

### `INPUT_SOURCE_MODE.MULTIDEVICE`

Input will accept input for player 0 from the keyboard, the mouse, and all gamepads. Unlike `INPUT_SOURCE_MODE.MIXED`, gamepad bindings are tied to specific gamepad indexes rather than scanning all connected gamepads. This allows multiple unique gamepads to have unique bindings that then trigger specific verbs. The auto profile when in multidevice mode is determined by `INPUT_AUTO_PROFILE_FOR_MULTIDEVICE`, though is it almost certain that a player will want to manually rebind their controls in this source mode.

!> This mode should only be used for single player gameplay. All players other than player 0 will have their sources removed and will not be able to play.