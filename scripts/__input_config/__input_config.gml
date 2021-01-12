#macro INPUT_MAX_PLAYERS                4          //Maximum number of players that the game supports
#macro INPUT_MAX_ALTERNATE_BINDINGS     2          //Maximum number of alternate bindings per verb per input source
#macro INPUT_DEFAULT_MIN_THRESHOLD      0.3        //Default minimum threshold for gamepad axes. This value is used for detecting gamepad input in input_hotswap_tick() so make sure you set it above 0.0
#macro INPUT_DEFAULT_MAX_THRESHOLD      1.0        //Default maximum threshold for gamepad axes

#macro INPUT_BUFFERED_REALTIME          false      //Set to true to use milliseconds instead of frames for input_check_*() functions
#macro INPUT_DOUBLE_DELAY               12         //Delay between key presses for it to register as a double press. Whether this is in frames or milliseconds is controlled by INPUT_BUFFERED_REALTIME

#macro INPUT_HOTSWAP_DELAY              33         //Number of milliseconds between source swaps. This should be longer than a single frame (>17 ms at 60FPS)
#macro INPUT_HOTSWAP_ON_MOUSE_MOVEMENT  true       //Whether to trigger a hotswap when the mouse is moved
#macro INPUT_MOUSE_MODE                 0          //0 = view-space, 1 = GUI-space, 2 = device-space
#macro INPUT_MOUSE_MOVE_DEADZONE        2          //Size of the deadzone for detecting mouse movement, measured in pixels
#macro INPUT_HOTSWAP_ON_GAMEPAD_AXIS    true       //Whether to trigger a hotswap when a gamepad axis is moved

#macro INPUT_SDL2_REMAPPING             true       //Whether to use our own SDL2 database to remap controllers
#macro INPUT_SDL2_GP_SELECT_NAME        "back"     //SDL2 binding name for gp_select (GameMaker's documentation says "guide" but most SDL2 definitions use "back")
#macro INPUT_SDL2_ALLOW_EXTERNAL        false      //Whether to allow external SDL2 database loading. *You must turn OFF file system sandboxing for this to work.* The path is given by the environment variable %SDL_GAMECONTROLLERCONFIG%

#region Forbidden Fruit

#macro INPUT_EXTERNAL_DEBUG_LOG  false  //Do NOT set to <true> unless directed (!)

#endregion