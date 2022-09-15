//Maximum number of players that the game supports
//For a singleplayer only game, this macro should be set to 1
#macro INPUT_MAX_PLAYERS  4

//Maximum number of alternate bindings per verb per profile
#macro INPUT_MAX_ALTERNATE_BINDINGS  2

//Whether to allow input while game window is out of focus on desktop platforms
#macro INPUT_ALLOW_OUT_OF_FOCUS false

//Set to true to use milliseconds instead of frames throughout the library
#macro INPUT_TIMER_MILLISECONDS  false

//Whether to allow (problematic) keyboard input on Android platform
#macro INPUT_ANDROID_KEYBOARD_ALLOWED  false

//Whether to allow keyboard input on Switch platform
#macro INPUT_SWITCH_KEYBOARD_ALLOWED  false

//Whether to merge control keys, for example Left Shift and Right Shift upon user rebind
#macro INPUT_MERGE_CONTROL_KEYS  false

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

#macro INPUT_2D_CHECKER_STATIC_RESULT  true

#macro INPUT_DEBUG_PROFILES  false
#macro INPUT_DEBUG_SOURCES   false
#macro INPUT_DEBUG_BINDING   false
#macro INPUT_DEBUG_VERBS     false

#macro INPUT_EXTERNAL_DEBUG_LOG  false  //Do NOT set to <true> unless directed (!)
#macro INPUT_WARNING_DEPRECATED  true   //Whether to show errors when using deprecated functions

//How many frames to wait before scanning for connected gamepads
//This works around Steam sometimes reporting confusing connection/disconnection events on boot
#macro INPUT_GAMEPADS_TICK_PREDELAY  10     

#endregion
