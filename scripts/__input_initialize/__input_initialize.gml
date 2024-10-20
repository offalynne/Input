// Feather disable all
__input_initialize();
function __input_initialize()
{
    static _initialized = false;
    if (_initialized) return;
    _initialized = true;
    
    //Don't use static here as this puts the game into a boot loop
    var _global = __input_global();
    
    //Set up the extended debug functionality
    _global.__debug_log = "input___" + string_replace_all(string_replace_all(date_datetime_string(date_current_datetime()), ":", "-"), " ", "___") + ".txt";
    if (__INPUT_EXTERNAL_DEBUG_LOG && __INPUT_DEBUG)
    {
        show_debug_message("Input: Set external debug log to \"" + string(_global.__debug_log) + "\"");
        exception_unhandled_handler(__input_exception_handler);
    }
    
    __input_trace("Welcome to Input by Juju Adams and Alynne Keith! This is version ", __INPUT_VERSION, ", ", __INPUT_DATE);
    if (__INPUT_SILENT)
    {
        __input_trace("Warning! Per __INPUT_SILENT mode, most logging is suppressed. This is NOT recommended");
    }
    
    
    
    #region Feature detection
    
    //Detect infinity
    if (is_undefined(infinity))
    {
        __input_error("Error!\nGM constant 'infinity' is undefined. Please file a bug with YoYoGames.");
    }
    
    //Detect string functions
    var _use_split_and_trim;
    try
    {
        var _split = array_equals(string_split("Juju\nwaz\nere", "\n", true), ["Juju", "waz", "ere"]);
        var _trim = (string_trim("         you can't catch me          ") == "you can't catch me");
        _use_split_and_trim = _split && _trim;
    }
    catch(_error)
    {
        _use_split_and_trim = false;
    }
    
    if not (_use_split_and_trim) __input_error("Error!\nGM extended string functions are unavailable. Please update GameMaker.");
    
    //Detect is_instanceof(), which offers some minor performance gains
    if (INPUT_ON_WEB)
    {
        //Buggy as of 2023-07-05
        _global.__use_is_instanceof = false;
    }
    else
    {
        try
        {
            var _instance_of = is_instanceof(input_binding_empty(), __input_class_binding);
            _global.__use_is_instanceof = _instance_of;
        }
        catch(_error)
        {
            _global.__use_is_instanceof = false;
        }
    }
    
    if (not __INPUT_SILENT)
    {
        __input_trace(_global.__use_is_instanceof? "Using is_instanceof() for comparisons" : "is_instanceof() unavailable, using legacy comparisons");
    }
      
    //Detect new native gamepad constants
    _global.__use_gp_extended = false;
    try
    {
        _global.__use_gp_extended = is_numeric(gp_home) && is_numeric(gp_extra1) && is_numeric(gp_paddler) && is_numeric(gp_paddlel) && is_numeric(gp_paddlerb) && is_numeric(gp_paddlelb) && is_numeric(gp_touchpadbutton);
    }
    catch(_error)
    {    
        _global.__use_gp_extended = false;
    }
    
    if (_global.__use_gp_extended)
    {
        _global.__gp_guide    = gp_home;
        _global.__gp_misc1    = gp_extra1;
        _global.__gp_touchpad = gp_touchpadbutton;
        _global.__gp_paddle1  = gp_paddler;
        _global.__gp_paddle2  = gp_paddlel;
        _global.__gp_paddle3  = gp_paddlerb;
        _global.__gp_paddle4  = gp_paddlelb;        
        
        if not (__INPUT_SILENT) __input_trace("Using native extended gamepad values");
    }
    else
    {
        _global.__gp_guide    = 32889;
        _global.__gp_misc1    = 32890;
        _global.__gp_touchpad = 32891;
        _global.__gp_paddle1  = 32892;
        _global.__gp_paddle2  = 32893;
        _global.__gp_paddle3  = 32894;
        _global.__gp_paddle4  = 32895;        
        
        if not (__INPUT_SILENT) __input_trace("Native extended gamepad values unavailable");
    }
    
    //Detect is_debug_overlay_open() to block game input to overlay, if supported
    if (INPUT_ON_WEB || INPUT_ON_CONSOLE)
    {
        //Buggy as of 2023-10-08
        _global.__use_debug_overlay_status = false;
    }
    else 
    {
        try
        {
            var _overlay_open = is_debug_overlay_open();
            _global.__use_debug_overlay_status = is_bool(_overlay_open);
        }
        catch(_error)
        {
            _global.__use_debug_overlay_status = false;
        }
    }
    
    if not (__INPUT_SILENT)
    {
        __input_trace(_global.__use_debug_overlay_status? "Using debug overlay status to block input" : "Debug overlay status is unavailable");
    }
    
    if (INPUT_ON_WEB)
    {
        //Buggy as of 2023-10-08
        _global.__allow_gamepad_tester = false;
    }
    else 
    {
        try
        {
            ref_create({x: 32}, "x");
            _global.__allow_gamepad_tester = true;
        }
        catch(_error)
        {
            _global.__allow_gamepad_tester = false;
        }
    }
    
    if not (__INPUT_SILENT)
    {
        __input_trace(_global.__allow_gamepad_tester? "Allowing native gamepad tester" : "Native gamepad tester is unavailable");
    }
    
    if (_global.__allow_gamepad_tester) __input_gamepad_tester_init();
    
    //Detect gamepad_enumerate() to enable hotplugging on Android, if supported
    _global.__allow_gamepad_enumerate = false;
    if (__INPUT_ON_ANDROID)
    {
        try
        {
            gamepad_enumerate();
            _global.__allow_gamepad_enumerate = true;
        }
        catch(_error)
        {
            _global.__allow_gamepad_enumerate = false;
        }
        
        if not (__INPUT_SILENT) __input_trace(_global.__allow_gamepad_enumerate? "Using gamepad enumeration" : "Gamepad enumeration is unavailable");
    }
    
    #endregion
    
    
    
    #region On-boot warnings and errors
    
    //Set up a time source to manage input_controller_object
    _global.__time_source = time_source_create(time_source_global, 1, time_source_units_frames, function()
    {
        //Ensure existance of our controller object
        if (!instance_exists(input_controller_object))
        {
            //Try to detect deactivation of the controller object
            instance_activate_object(input_controller_object);
            if (instance_exists(input_controller_object))
            {
                if (GM_build_type == "run")
                {
                    //Be nasty when running from the IDE >:(
                    __input_error("input_controller_object has been deactivated\nPlease ensure that input_controller_object is never deactivated\nYou may need to use instance_activate_object(input_controller_object)");
                }
                else
                {
                    //Be nice when in production <:)
                    __input_trace("Warning! input_controller_object has been deactivated. Please ensure that input_controller_object is never deactivated. You may need to use instance_activate_object(input_controller_object)");
                }
            }
            else
            {
                static _created = false;
                if (!_created)
                {
                    //Don't throw an error if we haven't made the instance yet
                    _created = true;
                }
                else if (__input_restart_get())
                {
                    __input_trace("Warning! Please consider an alternative method to reset game state: avoid using \"game_restart()\"");
                }
                else
                {
                    if (GM_build_type == "run")
                    {
                        //Be nasty when running from the IDE >:(
                        __input_error("input_controller_object has been destroyed\nPlease ensure that input_controller_object is never destroyed");
                    }
                    else
                    {
                        //Be nice when in production <:)
                        __input_trace("Warning! input_controller_object has been destroyed. Please ensure that input_controller_object is never destroyed");
                    }
                }
                
                instance_create_depth(0, -__INPUT_CONTROLLER_OBJECT_DEPTH, __INPUT_CONTROLLER_OBJECT_DEPTH, input_controller_object);
            }
        }
        
        //Detect if the controller object has been set to non-persistent
        if (!input_controller_object.persistent)
        {
            if (GM_build_type == "run")
            {
                //Be nasty when running from the IDE >:(
                __input_error("input_controller_object has been set as non-persistent\nPlease ensure that input_controller_object is always persistent");
            }
            else
            {
                //Be nice when in production <:)
                __input_trace("Warning! input_controller_object has been set as non-persistent. Please ensure that input_controller_object is always persistent");
                input_controller_object.persistent = true;
            }
        }
        
        //Detect if the controller object depth has been set
        if (input_controller_object.depth != __INPUT_CONTROLLER_OBJECT_DEPTH)
        {
            if (GM_build_type == "run")
            {
                //Be nasty when running from the IDE >:(
                __input_error("input_controller_object depth has been changed (expected ", __INPUT_CONTROLLER_OBJECT_DEPTH, ", got ", input_controller_object.depth ,")\nPlease ensure that input_controller_object is never manually created and depth is not manually set");
            }
            else
            {
                //Be nice when in production <:)
                __input_trace("Warning! input_controller_object depth has been changed (expected ", __INPUT_CONTROLLER_OBJECT_DEPTH, ", got ", input_controller_object.depth ,")\nPlease ensure that input_controller_object is never manually created and depth is not manually set");
                input_controller_object.depth = __INPUT_CONTROLLER_OBJECT_DEPTH;
            }
        }
    }, [], -1);
    
    time_source_start(_global.__time_source);
    
    if (((string_pos("127.0.0.1", parameter_string(0)) > 0) || (string_pos("localhost", parameter_string(0)) > 0)))
    {
        show_message("Due to changes in security policy, some browsers may not permit the use of gamepads when testing locally.\n \nPlease host on a remote web service (itch.io, GX.games, etc.) if you are encountering problems.");
    }
    
    #endregion
    
    
    
    //Global frame counter and realtime tracker. This is used for input buffering
    _global.__frame = 0;
    _global.__current_time = current_time;
    _global.__previous_current_time = current_time;
    
    //Time the game was restarted
    _global.__restart_time = -infinity;
    
    //Time of gamepad enumeration on Android
    _global.__enumeration_time = -infinity;
    
    //Whether momentary input has been cleared
    _global.__cleared = false;
    
    //Focus tracking
    _global.__window_focus       = true;
    _global.__overlay_focus      = false;
    _global.__game_input_allowed = true;
    _global.__use_native_focus   = (__INPUT_ON_WINDOWS || INPUT_ON_WEB);

    //Accessibility state
    _global.__toggle_momentary_dict  = {};
    _global.__toggle_momentary_state = false;
    _global.__cooldown_dict          = {};
    _global.__cooldown_state         = false;
    
    //Windows tap-to-click tracking
    _global.__tap_presses  = 0;
    _global.__tap_releases = 0;
    _global.__tap_click    = false;
    
    //Touch pointer tracking
    _global.__pointer_index          = 0;
    _global.__pointer_index_previous = 0;
    _global.__pointer_pressed        = false;
    _global.__pointer_released       = false;
    _global.__pointer_pressed_index  = undefined;
    _global.__pointer_coord_space    = INPUT_COORD_SPACE.ROOM;
    _global.__pointer_held_time      = array_create(INPUT_MAX_TOUCHPOINTS, -1);
    _global.__pointer_held_buffer    = array_create(INPUT_MAX_TOUCHPOINTS, false);
    _global.__pointer_x              = array_create(INPUT_COORD_SPACE.__SIZE, 0);
    _global.__pointer_y              = array_create(INPUT_COORD_SPACE.__SIZE, 0);
    _global.__pointer_dx             = array_create(INPUT_COORD_SPACE.__SIZE, 0);
    _global.__pointer_dy             = array_create(INPUT_COORD_SPACE.__SIZE, 0);
    _global.__pointer_moved          = false;
    
    //Cursor capture state
    _global.__mouse_capture             = false;
    _global.__mouse_capture_blocked     = false;
    _global.__mouse_capture_sensitivity = 1;
    _global.__mouse_capture_frame       = 0;
        
    //Identify mobile and desktop
    _global.__on_desktop = (__INPUT_ON_WINDOWS || __INPUT_ON_MACOS || __INPUT_ON_LINUX || __INPUT_ON_OPERAGX);
    _global.__on_mobile  = (__INPUT_ON_ANDROID || __INPUT_ON_IOS);
    
    //OperaGX mobile identity
    if (__INPUT_ON_OPERAGX)
    {
        var _map = os_get_info();
        if (ds_exists(_map, ds_type_map))
        {
            if (_map[? "mobile"])
            {
                _global.__on_mobile  = true;
                _global.__on_desktop = false;
                if (!__INPUT_SILENT) __input_trace("Browser indicates OperaGX mobile");
            }

            ds_map_destroy(_map);
        }
    }
    
    //Whether to strictly verify bindings match auto profiles
    //This is set to <true> on boot, causing Input to throw an error, otherwise this is <false>
    //If an invalid binding is set during normal gameplay then a warning message is emitted to the console
    _global.__strict_binding_check = false;
    
    //Whether these particular input sources are valid
    //This is determined by what default keybindings are set up
    _global.__any_keyboard_binding_defined = false;
    _global.__any_mouse_binding_defined    = false;
    _global.__any_touch_binding_defined    = false;
    _global.__any_gamepad_binding_defined  = false;
    
    
    
    //Allow features per platform specification
    _global.__gamepad_allowed   = ((INPUT_ON_PC && INPUT_PC_GAMEPAD)  || (INPUT_ON_MOBILE && INPUT_MOBILE_GAMEPAD)    ||  INPUT_ON_CONSOLE);
    _global.__keyboard_allowed  = ((INPUT_ON_PC && INPUT_PC_KEYBOARD) || (__INPUT_ON_SWITCH && INPUT_SWITCH_KEYBOARD) || (INPUT_ON_MOBILE && INPUT_MOBILE_WEB_KEYBOARD && INPUT_ON_WEB) || (__INPUT_ON_ANDROID && INPUT_ANDROID_KEYBOARD));
    _global.__mouse_allowed     = ((INPUT_ON_PC && INPUT_PC_MOUSE)    || (__INPUT_ON_SWITCH && INPUT_SWITCH_MOUSE)    || (INPUT_ON_MOBILE && INPUT_MOBILE_MOUSE));
    _global.__touch_allowed     = (INPUT_ON_MOBILE                    || (__INPUT_ON_SWITCH && INPUT_SWITCH_TOUCH));
    
    //No gamepad, no vibration
    _global.__vibration_allowed = false;
    if (_global.__gamepad_allowed)
    {
        _global.__vibration_allowed = ((__INPUT_ON_WINDOWS && INPUT_WINDOWS_VIBRATION) || (__INPUT_ON_SWITCH && INPUT_SWITCH_VIBRATION) || (__INPUT_ON_XBOX  && INPUT_XBOX_VIBRATION) || ((os_type == os_ps4) && INPUT_PS4_VIBRATION) || ((os_type == os_ps5) && INPUT_PS5_VIBRATION));
    }
    
    //Mouse overrides touch
    if (_global.__mouse_allowed && _global.__touch_allowed)
    {
        _global.__touch_allowed = false;
        if not (INPUT_MOUSE_ALLOW_VIRTUAL_BUTTONS)
        {
            if (!__INPUT_SILENT) __input_trace("Warning! Mouse configuration overrides touch. Virtual buttons may not work as expected.");
        }
    }
    
    
    
    //Whether mouse is blocked due to Window focus state
    _global.__window_focus_block_mouse = false;
    
    //Focus frame to prevent gamepad source swap on change
    _global.__window_focus_frame = -infinity;
    
    _global.__cursor_verbs_valid = false;
    
    //Arrays/dictionaries to track basic verbs and chords
    _global.__all_verb_dict  = {};
    _global.__all_verb_array = [];
    
    _global.__basic_verb_dict  = {};
    _global.__basic_verb_array = [];
    
    _global.__chord_verb_dict  = {};
    _global.__chord_verb_array = [];
    
    //Struct to store keyboard key names
     _global.__key_name_dict = {};
    
    //Struct to store all the keyboard keys we want to ignore
    _global.__ignore_key_dict = {};
    
    //Struct to store ignored gamepad types
    _global.__ignore_gamepad_types = {};
    
    //Array of created virtual buttons
    _global.__virtual_array       = [];
    _global.__virtual_background  = input_virtual_create().__set_as_background();
    _global.__virtual_order_dirty = false;
    
    //Which player has the INPUT_TOUCH source, if any
    //This can also work with INPUT_MOUSE if INPUT_MOUSE_ALLOW_VIRTUAL_BUTTONS is set to <true>
    _global.__touch_player = undefined;
    
    //Gamepad device count by platform
    var _max_gamepads = 4;
    if (!INPUT_ON_WEB)
    {
        if (__INPUT_ON_WINDOWS)
        {
            _max_gamepads = 12;
        }
        else if (__INPUT_ON_SWITCH)
        {
            _max_gamepads = 9;
        }
        else if (__INPUT_ON_XBOX)
        {
            _max_gamepads = 8;        
        }
        else if (__INPUT_ON_IOS)
        {
        	_max_gamepads = 5;
        }
        else if (__INPUT_ON_LINUX || __INPUT_ON_ANDROID)
        {
            _max_gamepads = gamepad_get_device_count();
        }
    }
    
    //Two structs that are returned by input_players_get_status() and input_gamepads_get_status()
    //These are "static" structs that are reset and populated by __input_system_tick()
    _global.__players_status = {
        __any_changed: false,
        __new_connections: [],
        __new_disconnections: [],
        __players: array_create(INPUT_MAX_PLAYERS, INPUT_STATUS.DISCONNECTED),
    }
    
    _global.__gamepads_status = {
        __any_changed: false,
        __new_connections: [],
        __new_disconnections: [],
        __gamepads: array_create(_max_gamepads, INPUT_STATUS.DISCONNECTED),
    }
    
    //The default player. This player struct holds default binding data
    _global.__default_player = new __input_class_player();
    
    //Array of players. Each player is a struct (instanceof __input_class_player) that contains lotsa juicy information
    _global.__players = array_create(INPUT_MAX_PLAYERS, undefined);
    
    var _p = 0;
    repeat(INPUT_MAX_PLAYERS)
    {
        with(new __input_class_player())
        {
            _global.__players[@ _p] = self;
            __index = _p;
        }
        
        ++_p;
    }
    
    _global.__source_mode          = undefined;
    _global.__previous_source_mode = INPUT_STARTING_SOURCE_MODE;
    
    //Hotswap source assignment parameters
    //This is set by input_hotswap_params_set()
    _global.__hotswap_callback = undefined;
    
    //Multiplayer source assignment parameters
    //This is set by input_join_params_set()
    _global.__join_player_min     = 1;
    _global.__join_player_max     = INPUT_MAX_PLAYERS;
    _global.__join_leave_verb     = "cancel";
    _global.__join_abort_callback = undefined;
    _global.__join_drop_down      = true;
    
    //Array of currently connected gamepads. If an element is <undefined> then the gamepad is disconnected
    //Each gamepad in this array is an instance of __input_class_gamepad
    //Gamepad structs contain remapping information and current button state
    _global.__gamepads = array_create(_max_gamepads, undefined);
    
    //Array of gamepad connection states
    _global.__gamepad_connections_native   = array_create(_max_gamepads, false);
    _global.__gamepad_connections_internal = array_create(_max_gamepads, false);
    
    //Our database of SDL2 definitions, used for the aforementioned remapping information
    _global.__sdl2_database = {
        by_guid           : {},
        by_vendor_product : {},
        by_description    : {},
    };
    
    _global.__sdl2_look_up_table = {
        a:             gp_face1,
        b:             gp_face2,
        x:             gp_face3,
        y:             gp_face4,
        dpup:          gp_padu,
        dpdown:        gp_padd,
        dpleft:        gp_padl,
        dpright:       gp_padr,
        leftx:         gp_axislh,
        lefty:         gp_axislv,
        rightx:        gp_axisrh,
        righty:        gp_axisrv,
        leftshoulder:  gp_shoulderl,
        rightshoulder: gp_shoulderr,
        lefttrigger:   gp_shoulderlb,
        righttrigger:  gp_shoulderrb,
        leftstick:     gp_stickl,
        rightstick:    gp_stickr,
        start:         gp_start,
        back:          gp_select,
        guide:         gp_guide,
        misc1:         gp_misc1,
        touchpad:      gp_touchpad,
        paddle1:       gp_paddle1,
        paddle2:       gp_paddle2,
        paddle3:       gp_paddle3,
        paddle4:       gp_paddle4,
    }
    
    #region Gamepad mapping database
    
    if (!__INPUT_SDL2_SUPPORT || !INPUT_SDL2_REMAPPING)
    {
        if (!__INPUT_SILENT) __input_trace("Skipping loading SDL database");
    }
    else
    {
        if (file_exists(INPUT_SDL2_DATABASE_PATH))
        {
            __input_load_sdl2_from_file(INPUT_SDL2_DATABASE_PATH);
        }
        else
        {
            __input_trace("Warning! \"", INPUT_SDL2_DATABASE_PATH, "\" not found in Included Files");
        }
        
        //Try to load an external SDL2 database if possible
        if (INPUT_SDL2_ALLOW_EXTERNAL)
        {
            var _external_string = environment_get_variable("SDL_GAMECONTROLLERCONFIG");

            if (_external_string != "")
            {
                if (!extension_exists("Steamworks") && (GM_build_type == "run") && (environment_get_variable("SteamEnv") == "1") && (environment_get_variable("EnableConfiguratorSupport") != "0") && !gamepad_is_connected(0))
                {
                    __input_trace("Warning! Steam Input may block gamepads when GameMaker IDE is run through Steam.");
                }
                
                __input_trace("External SDL2 string found");
            
                try
                {
                    __input_load_sdl2_from_string(_external_string);
                }
                catch(_error)
                {
                    __input_trace_loud("Error!\n\n%SDL_GAMECONTROLLERCONFIG% could not be parsed.\nYou may see unexpected behaviour when using gamepads.\n\nTo remove this error, clear %SDL_GAMECONTROLLERCONFIG%\n\nInput ", __INPUT_VERSION, "   @jujuadams and @offalynne ", __INPUT_DATE);
                }
            }
        }
    }
    
    #endregion
  
    #region Gamepad type identification
    
    //Set up controller type database
    __input_define_gamepad_types();
    
    //Parse controller type database
    _global.__raw_type_dictionary = {};

    //Load the controller type database
    if (INPUT_ON_CONSOLE || __INPUT_ON_OPERAGX || __INPUT_ON_IOS)
    {
        if (!__INPUT_SILENT) __input_trace("Skipping loading controller type database");
    }
    else if (file_exists(INPUT_CONTROLLER_TYPE_PATH))
    {
        __input_load_type_csv(INPUT_CONTROLLER_TYPE_PATH);
    }
    else
    {
        __input_trace("Warning! \"", INPUT_CONTROLLER_TYPE_PATH, "\" not found in Included Files");
    }
    
    #endregion
    
    
    
    #region Gamepad device blocklist
    
    _global.__blacklist_dictionary = {};
    if (!__INPUT_SDL2_SUPPORT)
    {
        if (!__INPUT_SILENT) __input_trace("Skipping loading controller blacklist database");
    }
    else
    {
        //Parse the controller type database
        if (file_exists(INPUT_BLACKLIST_PATH))
        {
            __input_load_blacklist_csv(INPUT_BLACKLIST_PATH);
        }
        else
        {
            __input_trace("Warning! \"", INPUT_BLACKLIST_PATH, "\" not found in Included Files");
        }
    }
    
    #endregion
    
    
    #region Gamepad LED patterns by device type
    
    var _dict = {};
    
    _dict[$ INPUT_GAMEPAD_TYPE_PS5] = [       //PS5
        [false, false, true,  false, false],  //P1: --X--
        [false, true,  false, true,  false],  //P2: -X-X-
        [true,  false, true,  false, true ],  //P3: X-X-X
        [true,  true,  false, true,  true ],  //P4: XX-XX
    ];
    _dict[$ INPUT_GAMEPAD_TYPE_SWITCH] = [    //Switch
        [true,  false, false, false],         //P1: X---
        [true,  true,  false, false],         //P2: XX--
        [true,  true,  true,  false],         //P3: XXX-
        [true,  true,  true,  true ],         //P4: XXXX
        [true,  false, false, true ],         //P5: X--X
        [true,  false, true,  false],         //P6: X-X-
        [true,  false, true,  true ],         //P7: X-XX
        [false, true,  true,  false],         //P8: -XX-
    ];
    _dict[$ INPUT_GAMEPAD_TYPE_XBOX_360] = [  //Xbox 360
        [true,  false, false, false],         //P1: X---
        [false, true,  false, false],         //P2: -X--
        [false, false, true,  false],         //P3: --X-
        [false, false, false, true ],         //P4: ---X
    ];
    
    _global.__gamepad_led_pattern_dict = _dict;
    
    #endregion
    
    
        
    #region Device locale
        
    //Gamepad region
    _global.__ps_region_swap = false;
    if (INPUT_PS_REGION_SWAP_CONFIRM && (os_type == os_ps4))
    {
        var _map = os_get_info();
        if (ds_exists(_map, ds_type_map))
        {
            if (_map[? "enter_button_assign"] == 0)
            {
                _global.__ps_region_swap = true;
            }
            
            ds_map_destroy(_map);
        }
    }
    
    //Keyboard locale
    _global.__keyboard_locale = "QWERTY";
    var _locale = os_get_language() + "-" + os_get_region();
    switch(_locale)
    {
        case "ar-DZ": case "ar-MA": case "ar-TN":
        case "br-FR": case "co-FR": case "ff-SN":
        case "fr-BE": case "fr-CD": case "fr-CI":
        case "fr-CM": case "fr-FR": case "fr-HT":
        case "fr-MA": case "fr-MC": case "fr-ML":
        case "fr-RE": case "nl-BE": case "oc-FR":
        case "wo-SN": case "tzm-DZ":
        case "mg-":   case "gsw-FR":
            _global.__keyboard_locale = "AZERTY";
        break;  

        case "cs-CZ": case "de-AT": case "de-CH":
        case "de-DE": case "de-LI": case "de-LU":
        case "fr-CH": case "fr-LU": case "sq-AL":
        case "hr-BA": case "hr-HR": case "hu-HU":
        case "lb-LU": case "rm-CH": case "sk-SK":
        case "sl-SI": case "dsb-DE":
        case "sr-BA": case "hsb-DE":
            _global.__keyboard_locale = "QWERTZ";
        break;
    }
    
    #endregion 
    


    #region Key names
    
    __input_key_name_set(vk_backtick,   "`");
    __input_key_name_set(vk_hyphen,     "-");
    __input_key_name_set(vk_equals,     "=");
    __input_key_name_set(vk_semicolon,  ";");
    __input_key_name_set(vk_apostrophe, "'");
    __input_key_name_set(vk_comma,      ",");
    __input_key_name_set(vk_period,     ".");
    __input_key_name_set(vk_rbracket,   "]");
    __input_key_name_set(vk_lbracket,   "[");
    __input_key_name_set(vk_fslash,     "/");
    __input_key_name_set(vk_bslash,     "\\");

    __input_key_name_set(vk_scrollock, "scroll lock");
    __input_key_name_set(vk_capslock,  "caps lock");
    __input_key_name_set(vk_numlock,   "num lock");
    __input_key_name_set(vk_lmeta,     "left meta");
    __input_key_name_set(vk_rmeta,     "right meta");
    __input_key_name_set(vk_clear,     "clear");
    __input_key_name_set(vk_menu,      "menu");

    __input_key_name_set(vk_printscreen, "print screen");
    __input_key_name_set(vk_pause,       "pause break");
    
    __input_key_name_set(vk_escape,    "escape");
    __input_key_name_set(vk_backspace, "backspace");
    __input_key_name_set(vk_space,     "space");
    __input_key_name_set(vk_enter,     "enter");
    
    __input_key_name_set(vk_up,    "arrow up");
    __input_key_name_set(vk_down,  "arrow down");
    __input_key_name_set(vk_left,  "arrow left");
    __input_key_name_set(vk_right, "arrow right");
    
    __input_key_name_set(vk_tab,      "tab");
    __input_key_name_set(vk_ralt,     "right alt");
    __input_key_name_set(vk_lalt,     "left alt");
    __input_key_name_set(vk_alt,      "alt");
    __input_key_name_set(vk_rshift,   "right shift");
    __input_key_name_set(vk_lshift,   "left shift");
    __input_key_name_set(vk_shift,    "shift");
    __input_key_name_set(vk_rcontrol, "right ctrl");
    __input_key_name_set(vk_lcontrol, "left ctrl");
    __input_key_name_set(vk_control,  "ctrl");

    __input_key_name_set(vk_f1,  "f1");
    __input_key_name_set(vk_f2,  "f2");
    __input_key_name_set(vk_f3,  "f3");
    __input_key_name_set(vk_f4,  "f4");
    __input_key_name_set(vk_f5,  "f5");
    __input_key_name_set(vk_f6,  "f6");
    __input_key_name_set(vk_f7,  "f7");
    __input_key_name_set(vk_f8,  "f8");
    __input_key_name_set(vk_f9,  "f9");
    __input_key_name_set(vk_f10, "f10");
    __input_key_name_set(vk_f11, "f11");
    __input_key_name_set(vk_f12, "f12");

    __input_key_name_set(vk_divide,   "numpad /");
    __input_key_name_set(vk_multiply, "numpad *");
    __input_key_name_set(vk_subtract, "numpad -");
    __input_key_name_set(vk_add,      "numpad +");
    __input_key_name_set(vk_decimal,  "numpad .");

    __input_key_name_set(vk_numpad0, "numpad 0");
    __input_key_name_set(vk_numpad1, "numpad 1");
    __input_key_name_set(vk_numpad2, "numpad 2");
    __input_key_name_set(vk_numpad3, "numpad 3");
    __input_key_name_set(vk_numpad4, "numpad 4");
    __input_key_name_set(vk_numpad5, "numpad 5");
    __input_key_name_set(vk_numpad6, "numpad 6");
    __input_key_name_set(vk_numpad7, "numpad 7");
    __input_key_name_set(vk_numpad8, "numpad 8");
    __input_key_name_set(vk_numpad9, "numpad 9");

    __input_key_name_set(vk_delete,   "delete");
    __input_key_name_set(vk_insert,   "insert");
    __input_key_name_set(vk_home,     "home");
    __input_key_name_set(vk_pageup,   "page up");
    __input_key_name_set(vk_pagedown, "page down");
    __input_key_name_set(vk_end,      "end");
   
    //Name newline character after Enter
    __input_key_name_set(10, _global.__key_name_dict[$ vk_enter]);
    
    //Reset F11 and F12 keycodes on certain platforms
    if (__INPUT_ON_SWITCH || __INPUT_ON_LINUX || __INPUT_ON_MACOS)
    {
        __input_key_name_set(128, "f11");
        __input_key_name_set(129, "f12");
    }
    
    //Numeric keys 2-7 on Switch
    if (__INPUT_ON_SWITCH)
    {
        for(var _i = 2; _i <= 7; _i++) __input_key_name_set(_i, __input_key_get_name(ord(_i)));
    }
    
    if (__INPUT_ON_WINDOWS || INPUT_ON_WEB)
    {
        //F13 to F32 on Windows and Web
        for(var _i = 13; _i <= 32; _i++) __input_key_name_set(_i + vk_f1 - 1, "f" + string(_i));
        
        //IntlBackslash, Backquote
        __input_key_name_set(226, (INPUT_ON_WEB? "\\" : "<"));
        
        //Uncommon layout-contextual symbol
        switch(INPUT_KEYBOARD_LOCALE)
        {
            case "QWERTY": __input_key_name_set(223, "`"); break;
            case "AZERTY": __input_key_name_set(223, "!"); break;
            case "QWERTZ": __input_key_name_set(223, "$"); break;
        }
    }
    
    #endregion



    #region Ignored keys
    
    //Keyboard ignore level 1+
    if (INPUT_IGNORE_RESERVED_KEYS_LEVEL > 0)
    {
        input_ignore_key_add(vk_alt);
        input_ignore_key_add(vk_ralt);
        input_ignore_key_add(vk_lalt);
        input_ignore_key_add(vk_lmeta);
        input_ignore_key_add(vk_rmeta);
        
        input_ignore_key_add(0xFF); //Vendor key
        
        if (__INPUT_ON_WINDOWS)
        {
            input_ignore_key_add(0xE6); //OEM key (Power button on Steam Deck)
        }
        
        if (__INPUT_ON_ANDROID)
        {
            input_ignore_key_add(vk_backspace); //Emmitted by hard and soft "Back" buttons, gamepad "B" button
        }
        
        if (INPUT_ON_MOBILE && __INPUT_ON_APPLE)
        {
            input_ignore_key_add(0x7C); //Screenshot
        }
        
        if (INPUT_ON_WEB)
        {
            if (__INPUT_ON_APPLE)
            {
                input_ignore_key_add(vk_f10); //Fullscreen
                input_ignore_key_add(vk_capslock);
            }
            else
            {
                input_ignore_key_add(vk_f11); //Fullscreen
            }
        }
    }
    
    //Keyboard ignore level 2+
    if (INPUT_IGNORE_RESERVED_KEYS_LEVEL > 1)
    {
        input_ignore_key_add(vk_numlock);   //Num Lock
        input_ignore_key_add(vk_scrollock); //Scroll Lock
        
        if (INPUT_ON_WEB || __INPUT_ON_WINDOWS)
        {
            input_ignore_key_add(0x15); //IME Kana/Hanguel
            input_ignore_key_add(0x16); //IME On
            input_ignore_key_add(0x17); //IME Junja
            input_ignore_key_add(0x18); //IME Final
            input_ignore_key_add(0x19); //IME Kanji/Hanja
            input_ignore_key_add(0x1A); //IME Off
            input_ignore_key_add(0x1C); //IME Convert
            input_ignore_key_add(0x1D); //IME Nonconvert
            input_ignore_key_add(0x1E); //IME Accept
            input_ignore_key_add(0x1F); //IME Mode Change
            input_ignore_key_add(0xE5); //IME Process
            
            input_ignore_key_add(0xA6); //Browser Back
            input_ignore_key_add(0xA7); //Browser Forward
            input_ignore_key_add(0xA8); //Browser Refresh
            input_ignore_key_add(0xA9); //Browser Stop
            input_ignore_key_add(0xAA); //Browser Search
            input_ignore_key_add(0xAB); //Browser Favorites
            input_ignore_key_add(0xAC); //Browser Start/Home
            
            input_ignore_key_add(0xAD); //Volume Mute
            input_ignore_key_add(0xAE); //Volume Down
            input_ignore_key_add(0xAF); //Volume Up
            input_ignore_key_add(0xB0); //Next Track
            input_ignore_key_add(0xB1); //Previous Track
            input_ignore_key_add(0xB2); //Stop Media
            input_ignore_key_add(0xB3); //Play/Pause Media
            
            input_ignore_key_add(0xB4); //Launch Mail
            input_ignore_key_add(0xB5); //Launch Media
            input_ignore_key_add(0xB6); //Launch App 1
            input_ignore_key_add(0xB7); //Launch App 2
            
            input_ignore_key_add(0xFB); //Zoom
        }
    }
    
    #endregion
    
    
    
    #region Steam Input
    
    _global.__steam_switch_labels = false;
    _global.__using_steamworks    = false;
    _global.__on_steam_deck       = false;
    _global.__on_wine             = false;
    
    _global.__steam_handles       = [];
    _global.__steam_type_to_raw   = {};
    _global.__steam_type_to_name  = {};
    _global.__steam_trigger_mode  = {};
    
    if (__INPUT_STEAMWORKS_SUPPORT && INPUT_ALLOW_STEAMWORKS && extension_exists("Steamworks"))
    {
        try
        {
            //Using Steamworks extension
            _global.__using_steamworks = steam_input_init(true);
            _global.__on_steam_deck    = steam_utils_is_steam_running_on_steam_deck();
        }
        catch(_error)
        {
            if (!__INPUT_SILENT) __input_trace("Steamworks extension unavailable");
        }
        
        if (_global.__using_steamworks && (string(steam_get_app_id()) == "480"))
        {
            __input_trace_loud("Error!\nSteamworks extension incorrectly configured (Application ID 480).\nYou may see unexpected behaviour when using gamepads.\n\nTo remove this error, set Application ID.\n\nInput ", __INPUT_VERSION, "   @jujuadams and @offalynne ", __INPUT_DATE);
        }
    }
    
    //Identify Steam Deck in absence of Steamworks
    if (!_global.__on_steam_deck)
    {
        var _deck_envar = environment_get_variable("SteamDeck");
        if (_deck_envar != "")
        {
            //Try Deck environment variable
            _global.__on_steam_deck = (_deck_envar == "1");
        }
        else
        {
            //Try Deck hardware identity
            var _map = os_get_info();
            if (ds_exists(_map, ds_type_map))
            {
                var _identifier = undefined;
                if (__INPUT_ON_LINUX  ) _identifier = _map[? "gl_renderer_string"];
                if (__INPUT_ON_WINDOWS) _identifier = _map[? "video_adapter_description"];
            
                //Steam Deck GPU identifier
                if ((_identifier != undefined) && __input_string_contains(_identifier, "AMD Custom GPU 0"))
                {
                    _global.__on_steam_deck = true;
                }
            
                ds_map_destroy(_map);
            }
        }
    }
    
    var _switch_labels = environment_get_variable("SDL_GAMECONTROLLER_USE_BUTTON_LABELS");
    if (_switch_labels != "")
    {
        //Use environment variable
        _global.__steam_switch_labels = (_switch_labels == "1");
    }
    else
    {
        //Default enabled on Deck and disabled on desktop
        _global.__steam_switch_labels = _global.__on_steam_deck;
    }
    
    if (_global.__using_steamworks)
    {
        _global.__on_wine = (environment_get_variable("WINEDLLPATH") != "");
        
        __input_steam_type_set(steam_input_type_xbox_360_controller,   "XBox360Controller",      "Xbox 360 Controller");
        __input_steam_type_set(steam_input_type_xbox_one_controller,   "XBoxOneController",      "Xbox One Controller");
        __input_steam_type_set(steam_input_type_ps3_controller,        "PS3Controller",          "PS3 Controller");
        __input_steam_type_set(steam_input_type_ps4_controller,        "PS4Controller",          "PS4 Controller");
        __input_steam_type_set(steam_input_type_ps5_controller,        "PS5Controller",          "PS5 Controller");
        __input_steam_type_set(steam_input_type_steam_controller,      "SteamController",        "Steam Controller");
        __input_steam_type_set(steam_input_type_steam_deck_controller, "SteamControllerNeptune", "Steam Deck Controller");
        __input_steam_type_set(steam_input_type_mobile_touch,          "MobileTouch",            "Steam Link");
        
        if (_global.__steam_switch_labels)
        {
            //This is weird, but dictated by Steam Input
            __input_steam_type_set(steam_input_type_switch_pro_controller, "XBox360Controller", "Switch Pro Controller");
            __input_steam_type_set(steam_input_type_switch_joycon_single,  "XBox360Controller", "Joy-Con");
            __input_steam_type_set(steam_input_type_switch_joycon_pair,    "XBox360Controller", "Joy-Con Pair");
        }
        else
        {   
            __input_steam_type_set(steam_input_type_switch_pro_controller, "SwitchProController", "Switch Pro Controller");
            __input_steam_type_set(steam_input_type_switch_joycon_single,  "SwitchJoyConSingle",  "Joy-Con");
            __input_steam_type_set(steam_input_type_switch_joycon_pair,    "SwitchJoyConPair",    "Joy-Con Pair");
        }
                
        __input_steam_type_set("unknown", "UnknownNonSteamController", "Controller");
        
        _global.__steam_trigger_mode[$ string(__INPUT_TRIGGER_EFFECT.__TYPE_OFF)]       = steam_input_sce_pad_trigger_effect_mode_off;
        _global.__steam_trigger_mode[$ string(__INPUT_TRIGGER_EFFECT.__TYPE_FEEDBACK)]  = steam_input_sce_pad_trigger_effect_mode_feedback;
        _global.__steam_trigger_mode[$ string(__INPUT_TRIGGER_EFFECT.__TYPE_WEAPON)]    = steam_input_sce_pad_trigger_effect_mode_weapon;
        _global.__steam_trigger_mode[$ string(__INPUT_TRIGGER_EFFECT.__TYPE_VIBRATION)] = steam_input_sce_pad_trigger_effect_mode_vibration;
    }
    
    if (__INPUT_ON_MACOS || __INPUT_ON_LINUX)
    {
        //Define the virtual controller's identity
        var _os = (__INPUT_ON_MACOS? "macos"                            : "linux");
        var _id = (__INPUT_ON_MACOS? "030000005e0400008e02000001000000" : "03000000de280000ff11000001000000");
    
        //Access the blacklist
        var _blacklist_os = (is_struct(_global.__blacklist_dictionary)? _global.__blacklist_dictionary[$ _os] : undefined);
        var _blacklist_id = (is_struct(_blacklist_os)? _blacklist_os[$ "guid"] : undefined);
    
        if (is_struct(_blacklist_os) && (_blacklist_id == undefined))
        {
            //Add category if inaccessible
            _blacklist_os[$ "guid"] = {};
            _blacklist_id = (is_struct(_blacklist_os)? _blacklist_os[$ "guid"] : undefined);
        }
    
        //Blacklist the Steam virtual controller
        if (is_struct(_blacklist_id)) _blacklist_id[$ _id] = true;
    
        var _steam_environ = environment_get_variable("SteamEnv");
        var _steam_configs = environment_get_variable("EnableConfiguratorSupport");
        
        if (__INPUT_ON_LINUX
        && ((_steam_environ != "") && (_steam_environ == "1") || _global.__using_steamworks)
        &&  (_steam_configs != "") && (_steam_configs == string_digits(_steam_configs)))
        {
            //If run through Steam remove Steam virtual controller from the blocklist
            if (is_struct(_blacklist_id)) variable_struct_remove(_blacklist_id, _id);
        
            var _bitmask = real(_steam_configs);
        
            //Resolve Steam Input configuration
            var _steam_ps      = (_bitmask & 1);
            var _steam_xbox    = (_bitmask & 2);
            var _steam_generic = (_bitmask & 4);
            var _steam_switch  = (_bitmask & 8);
            
            var _ignore_list = [];
        
            if (_global.__using_steamworks || (environment_get_variable("SDL_GAMECONTROLLER_IGNORE_DEVICES") == ""))
            {
                //If ignore hint isn't set, GM accesses controllers meant to be blocked
                //We address this by adding the Steam config types to our own blocklist
                if (_steam_ps)      array_push(_ignore_list, INPUT_GAMEPAD_TYPE_PSX, INPUT_GAMEPAD_TYPE_PS4, INPUT_GAMEPAD_TYPE_PS5);
                if (_steam_xbox)    array_push(_ignore_list, INPUT_GAMEPAD_TYPE_XBOX_360, INPUT_GAMEPAD_TYPE_XBOX_ONE);
                if (_steam_switch)  array_push(_ignore_list, INPUT_GAMEPAD_TYPE_SWITCH, INPUT_GAMEPAD_TYPE_JOYCON_LEFT, INPUT_GAMEPAD_TYPE_JOYCON_RIGHT);
                if (_steam_generic) array_push(_ignore_list, INPUT_GAMEPAD_TYPE_GAMECUBE, INPUT_GAMEPAD_TYPE_UNKNOWN);
             
                var _i = 0;
                repeat(array_length(_ignore_list))
                {
                    _global.__ignore_gamepad_types[$ _ignore_list[_i]] = true;
                    ++_i;
                }
            }
            
            //Check for a reducible type configuration
            if (!_steam_generic && !_steam_ps && (!_steam_switch || _global.__steam_switch_labels))
            {
                //The remaining configurations are in the Xbox Controller style including:
                //Steam Controller, Steam Link, Steam Deck, Xbox or Switch with AB/XY swap
                _global.__simple_type_lookup[$ "UnknownNonSteamController"] = INPUT_GAMEPAD_TYPE_XBOX_ONE;
                if (!__INPUT_SILENT) __input_trace("Steam Input configuration indicates Xbox-like identity for virtual controllers");
            }
        }
    }

    #endregion
    
        
    
    #region Keyboard type
    
    if (INPUT_ON_CONSOLE || (INPUT_ON_WEB && !INPUT_ON_PC))
    {
        _global.__keyboard_type = "async";
    }
    else if (INPUT_ON_MOBILE)
    {
        _global.__keyboard_type = "virtual";
        if (__INPUT_ON_ANDROID)
        {
            var _map = os_get_info();
            if (ds_exists(_map, ds_type_map))
            {
                //Android on Chromebook form factor (ARC) test via Google
                //matches(".+_cheets|cheets_.+")
                var _device = string(_map[? "DEVICE"]);
                if ((string_pos("_cheets", _device) > 1) || ((string_pos("cheets_", _device) > 0) && (string_pos("cheets_", _device) < (string_length(_device) - 6))))
                {
                    _global.__keyboard_type = "keyboard";
                }

                ds_map_destroy(_map)
            }
        }
    }
    else
    {
        _global.__keyboard_type = "keyboard";
    }
    
    #endregion
    
    
    
    #region Pointer type
    
    if (__input_global().__on_steam_deck || __INPUT_ON_SWITCH || INPUT_ON_MOBILE || (__INPUT_ON_WINDOWS && _global.__touch_allowed))
    {
        _global.__pointer_type = "touch";
    }
    else if (INPUT_ON_CONSOLE)
    {
        _global.__pointer_type = "none";
    }
    else
    {
        _global.__pointer_type = "mouse";
    }
    
    #endregion
    
    
    //Whether gamepad motion is supported
    _global.__gamepad_motion_support = (__INPUT_ON_PS || __INPUT_ON_SWITCH || _global.__using_steamworks);

    //By default GameMaker registers double click (or tap) as right mouse button
    //We want to be able to identify the actual mouse buttons correctly, and have our own double-input handling
    device_mouse_dbclick_enable(false);
    
    _global.__profile_array        = undefined;
    _global.__profile_dict         = undefined;
    _global.__default_profile_dict = undefined;
    _global.__verb_to_group_dict   = {};
    _global.__group_to_verbs_dict  = {};
    _global.__verb_group_array     = [];
    _global.__icons                = {};
    
    
    
    //Build out the sources
    _global.__source_keyboard = new __input_class_source(__INPUT_SOURCE.KEYBOARD);
    _global.__source_mouse    = INPUT_ASSIGN_KEYBOARD_AND_MOUSE_TOGETHER? INPUT_KEYBOARD : (new __input_class_source(__INPUT_SOURCE.MOUSE));
    _global.__source_touch    = new __input_class_source(__INPUT_SOURCE.TOUCH);
    
    _global.__source_gamepad = array_create(_max_gamepads, undefined);
    var _g = 0;
    repeat(_max_gamepads)
    {
        _global.__source_gamepad[@ _g] = new __input_class_source(__INPUT_SOURCE.GAMEPAD, _g);
        ++_g;
    }
    
    
    
    __input_finalize_default_profiles();
    __input_finalize_verb_groups();
    
    
    
    //Resolve the starting source mode
    input_source_mode_set(INPUT_STARTING_SOURCE_MODE);
    
    if (INPUT_STARTING_SOURCE_MODE == INPUT_SOURCE_MODE.MIXED)
    {
        if (!variable_struct_exists(_global.__profile_dict, INPUT_AUTO_PROFILE_FOR_MIXED)) __input_error("Default profile for mixed \"", INPUT_AUTO_PROFILE_FOR_MIXED, "\" has not been defined in __input_config_verbs()");
        input_profile_set(INPUT_AUTO_PROFILE_FOR_MIXED);
    }
    else if (INPUT_STARTING_SOURCE_MODE == INPUT_SOURCE_MODE.MULTIDEVICE)
    {
        if (!variable_struct_exists(_global.__profile_dict, INPUT_AUTO_PROFILE_FOR_MULTIDEVICE)) __input_error("Default profile for multidevice \"", INPUT_AUTO_PROFILE_FOR_MULTIDEVICE, "\" has not been defined in __input_config_verbs()");
        input_profile_set(INPUT_AUTO_PROFILE_FOR_MULTIDEVICE);
    }
    
    
    
    //Make sure we're not misconfigured
    __input_validate_macros();
    
    return true;
}
