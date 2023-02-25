function __input_state()
{
    static _struct = {
        __debug_log: "input___" + string_replace_all(string_replace_all(date_datetime_string(date_current_datetime()), ":", "-"), " ", "___") + ".txt",
        
        __use_is_instanceof: (string_copy(GM_runtime_version, 1, 4) == "2023"),
        __time_source: undefined, //Set up in __input_initialize()
        
        //Global frame counter and realtime tracker. This is used for input buffering
        __frame: 0,
        __current_time: current_time,
        __previous_current_time: current_time,
        
        //Whether momentary input has been cleared
        __cleared: false,
        
        //Windows focus tracking
        __window_focus: true,
        
        //Accessibility state
        __toggle_momentary_dict:  {},
        __toggle_momentary_state: false,
        __cooldown_dict:          {},
        __cooldown_state:         false,
        
        //Windows tap-to-click tracking
        __presses:  0,
        __releases: 0,
        __click:    false,
    
        //Touch pointer tracking
        __pointer_index:         0,
        __pointer_pressed:       false,
        __pointer_released:      false,
        __pointer_pressed_index: undefined,
        __pointer_durations:     array_create(INPUT_MAX_TOUCHPOINTS, 0),
        __pointer_coord_space:   INPUT_COORD_SPACE.ROOM,
        __pointer_x:             array_create(INPUT_COORD_SPACE.__SIZE, 0),
        __pointer_y:             array_create(INPUT_COORD_SPACE.__SIZE, 0),
        __pointer_dx:            array_create(INPUT_COORD_SPACE.__SIZE, 0),
        __pointer_dy:            array_create(INPUT_COORD_SPACE.__SIZE, 0),
        __pointer_moved:         false,
    
        //Cursor capture state
        __capture:             false,
        __capture_sensitivity: false,
        __capture_frame:       0,
        
        //Whether to strictly verify bindings match auto profiles
        //This is set to <true> on boot, causing Input to throw an error, otherwise this is <false>
        //If an invalid binding is set during normal gameplay then a warning message is emitted to the console
        __strict_binding_check: false,
        
        //Whether these particular input sources are valid
        //This is determined by what default keybindings are set up
        __any_keyboard_binding_defined: false,
        __any_mouse_binding_defined:    false,
        __any_touch_binding_defined:    false,
        __any_gamepad_binding_defined:  false,
        
        //Disallow keyboard bindings on specified platforms unless explicitly enabled
        __keyboard_allowed: (__INPUT_KEYBOARD_SUPPORT && ((os_type != os_android) || INPUT_ANDROID_KEYBOARD_ALLOWED) && ((os_type != os_switch) || INPUT_SWITCH_KEYBOARD_ALLOWED)),
        
        //Default to disallowing mouse bindings on specified platforms unless explicitly enabled
        __mouse_allowed_on_platform: !(__INPUT_ON_PS || __INPUT_ON_XBOX || ((os_type != os_windows) && __INPUT_TOUCH_SUPPORT && !INPUT_TOUCH_POINTER_ALLOWED)),
        
        //Default to disallowing vibration on specified platforms unless explicitly enabled
        __vibration_allowed_on_platform: (__INPUT_GAMEPAD_VIBRATION_SUPPORT && INPUT_VIBRATION_ALLOWED && ((os_type != os_switch) || INPUT_SWITCH_USE_LEGACY_VIBRATION) && ((os_type != os_ps5) || INPUT_PS5_USE_LEGACY_VIBRATION)),
        
        //Whether mouse is blocked due to Window focus state
        __window_focus_block_mouse: false,
        
        //Timeout for gamepad source swap on window focus change
        __window_focus_gamepad_timeout: 0,
        
        __cursor_verbs_valid: false,
        
        //Whether to swap A/B gamepad buttons for default bindings
        __swap_ab: false,
        
        //Arrays/dictionaries to track basic verbs and chords
        __all_verb_dict:  {},
        __all_verb_array: [],
        
        __basic_verb_dict:  {},
        __basic_verb_array: [],
        
        __chord_verb_dict:  {},
        __chord_verb_array: [],
        
        //Struct to store keyboard key names
         __key_name_dict: {},
        
        //Struct to store all the keyboard keys we want to ignore
        __ignore_key_dict: {},
        
        //Struct to store ignored gamepad types
        __ignore_gamepad_types: {},
        
        //Array of created virtual buttons
        __virtual_array:       [],
        __virtual_background:  input_virtual_create().priority(-infinity).__set_as_background(),
        __virtual_order_dirty: false,
        
        //Which player has the INPUT_TOUCH source, if any
        //This can also work with INPUT_MOUSE if INPUT_MOUSE_ALLOW_VIRTUAL_BUTTONS is set to <true>
        __touch_player: undefined,
        
        //Two structs that are returned by input_players_get_status() and input_gamepads_get_status()
        //These are "static" structs that are reset and populated by input_tick()
        __players_status: {
            any_changed: false,
            new_connections: [],
            new_disconnections: [],
            players: array_create(INPUT_MAX_PLAYERS, INPUT_STATUS.DISCONNECTED),
        }
        
        __gamepads_status: {
            any_changed: false,
            new_connections: [],
            new_disconnections: [],
            gamepads: array_create(INPUT_MAX_GAMEPADS, INPUT_STATUS.DISCONNECTED),
        }
        
        //The default player. This player struct holds default binding data
        __default_player: new __input_class_player(),
        
        //Array of players. Each player is a struct (instanceof __input_class_player) that contains lotsa juicy information
        //This is completed in __input_initialize()
        __players: array_create(INPUT_MAX_PLAYERS, undefined),
    };
    
    return _struct;
}