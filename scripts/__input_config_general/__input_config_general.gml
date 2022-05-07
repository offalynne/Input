//Maximum number of players that the game supports
//For a singleplayer only game, this macro should be set to 1
#macro INPUT_MAX_PLAYERS  4



//Set to true to use milliseconds instead of frames throughout the library
#macro INPUT_TIMER_MILLISECONDS  false

//Default time before input_check_repeat() returns <true>
//(Whether this is in frames or milliseconds is controlled by INPUT_TIMER_MILLISECONDS above)
#macro INPUT_REPEAT_DEFAULT_DELAY  10

//Default time between a verb being activated and the first time input_check_repeat() returns <true>
//(Whether this is in frames or milliseconds is controlled by INPUT_TIMER_MILLISECONDS above)
#macro INPUT_REPEAT_DEFAULT_PREDELAY  30

//Time before input_check_long() returns <true>
//(Whether this is in frames or milliseconds is controlled by INPUT_TIMER_MILLISECONDS above)
#macro INPUT_LONG_DELAY  10

//Delay between key presses for it to register as a double press
//(Whether this is in frames or milliseconds is controlled by INPUT_TIMER_MILLISECONDS above)
#macro INPUT_DOUBLE_DELAY  12

//Default time limit between the first and last key press for chord activation
//(Whether this is in frames or milliseconds is controlled by INPUT_TIMER_MILLISECONDS above)
#macro INPUT_CHORD_DEFAULT_TIME  4

//Whether to clamp 2D input to a maximum distance of 1 unit
//This affects input_x(), input_y(), input_xy(), input_direction(), and input_distance()
#macro INPUT_2D_CLAMP  true



//Whether to allow (problematic) keyboard input on Android platform
#macro INPUT_ANDROID_KEYBOARD_ALLOWED  false

//Whether to allow keyboard input on Switch platform
#macro INPUT_SWITCH_KEYBOARD_ALLOWED  false



//Time (in milliseconds) to wait for a new binding before automatically cancelling the binding scan
#macro INPUT_BINDING_SCAN_TIMEOUT  10000



//The following macro controls default key filtering behaviour on platforms supporting keyboard
//Expected values are:
//  0 = Don't ignore any keys
//  1 = Ignore select nonfunctional keys:
//      - Alt/Options (Mac)
//      - Windows/Command (Mac)
//      - PrintSc on iOS/tvOS
//      - Caps lock in browser on Apple platforms
//      - F10 in browser on Apple platforms
//      - F11 in browser on other platforms
//      - Vendor-reserved (0xFF)
//  2 = Ignore all above keys, and reserved and/or system keys:
//      - Num lock & Scroll lock
//      - IME keys
//      - Browser keys
//      - Media keys
//You can modify this list at any time by calling input_ignore_key_add() or input_ignore_key_remove()
//This setting only affects Input and will not filter these keys from native GameMaker functions
#macro INPUT_IGNORE_RESERVED_KEYS_LEVEL  2





#region Forbidden Fruit

#macro INPUT_DEBUG_PROFILES  false
#macro INPUT_DEBUG_SOURCES   false
#macro INPUT_DEBUG_BINDING   false
#macro INPUT_DEBUG_VERBS     false

#macro INPUT_EXTERNAL_DEBUG_LOG  false  //Do NOT set to <true> unless directed (!)
#macro INPUT_WARNING_DEPRECATED  false  //Whether to show errors when using deprecated functions

//How many frames to wait before scanning for connected gamepads
//This works around Steam sometimes reporting confusing connection/disconnection events on boot
#macro INPUT_GAMEPADS_TICK_PREDELAY  10     

#endregion
