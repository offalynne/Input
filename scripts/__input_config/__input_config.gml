#macro INPUT_MAX_PLAYERS                4      //Maximum number of players that the game supports
#macro INPUT_MAX_ALTERNATE_BINDINGS     2      //Maximum number of alternate bindings per verb per input source
#macro INPUT_DEFAULT_MIN_THRESHOLD      0.3    //Default minimum threshold for gamepad axes. This value is used for detecting gamepad input in input_hotswap_tick() so make sure you set it above 0.0
#macro INPUT_DEFAULT_MAX_THRESHOLD      1.0    //Default maximum threshold for gamepad axes
#macro INPUT_BUFFERED_REALTIME          false  //Set to true to use milliseconds instead of frames for input_check_*() functions
#macro INPUT_HOTSWAP_DELAY              33     //Number of milliseconds between source swaps. This should be longer than a single frame (>17 ms)
#macro INPUT_HOTSWAP_ON_MOUSE_MOVEMENT  true   //Whether to trigger a hotswap when the mouse is moved
#macro INPUT_HOTSWAP_ON_GAMEPAD_AXIS    true   //Whether to trigger a hotswap when a gamepad axis is moved