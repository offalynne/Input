#macro INPUT_MAX_PLAYERS                4      //Maximum number of players that the game supports
#macro INPUT_MAX_ALTERNATE_BINDINGS     2      //Maximum number of alternate bindings per verb per input source
#macro INPUT_DEFAULT_MIN_THRESHOLD      0.3    //Default minimum threshold for gamepad axes. This value is used for detecting gamepad input in input_hotswap_tick() so make sure you set it above 0.0
#macro INPUT_DEFAULT_MAX_THRESHOLD      1.0    //Default maximum threshold for gamepad axes

#macro INPUT_TIMER_MILLISECONDS         false  //Set to true to use milliseconds instead of frames for input_check_*() functions
#macro INPUT_DOUBLE_DELAY               12     //Delay between key presses for it to register as a double press. Whether this is in frames or milliseconds is controlled by INPUT_TIMER_MILLISECONDS
#macro INPUT_HISTORY_LENGTH             20     //Maximum number of verb events to record. Each event is a struct containing the time, verb name, and verb value

#macro INPUT_HOTSWAP_DELAY              33     //Number of milliseconds between source swaps. This should be longer than a single frame (>17 ms at 60FPS)
#macro INPUT_HOTSWAP_ON_GAMEPAD_AXIS    true   //Whether to trigger a hotswap when a gamepad axis is moved
#macro INPUT_HOTSWAP_ON_MOUSE_MOVEMENT  true   //Whether to trigger a hotswap when the mouse is moved
#macro INPUT_MOUSE_MODE                 0      //0 = view-space, 1 = GUI-space, 2 = device-space
#macro INPUT_MOUSE_MOVE_DEADZONE        2      //Size of the deadzone for detecting mouse movement, measured in pixels

#macro INPUT_SDL2_REMAPPING             true   //Whether to use our own SDL2 database to remap controllers
#macro INPUT_SDL2_ALLOW_EXTERNAL        true   //Whether to allow external SDL2 database loading from environment variable %SDL_GAMECONTROLLERCONFIG%
#macro INPUT_SDL2_ALLOW_GUIDE           false  //Whether to allow use of SDL2's "guide" binding, accessed using the gp_guide macro. This generally only works with DInput controllers
#macro INPUT_SDL2_ALLOW_MISC1           false  //Whether to allow use of SDL2's "misc1" binding, accessed using the gp_misc1 macro. What this maps to varies from controller to controller

#macro INPUT_SIMPLIFY_CONTROLLER_TYPES  true   //Whether to alias the controller database to easier-to-use types

#region Forbidden Fruit

#macro INPUT_EXTERNAL_DEBUG_LOG  false  //Do NOT set to <true> unless directed (!)

#endregion