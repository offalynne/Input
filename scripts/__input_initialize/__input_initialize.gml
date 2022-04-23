__input_initialize();

function __input_initialize()
{
    if (variable_global_exists("__input_frame")) exit;
    
    //Set up the extended debug functionality
    global.__input_debug_log = "input___" + string_replace_all(string_replace_all(date_datetime_string(date_current_datetime()), ":", "-"), " ", "___") + ".txt";
    if (INPUT_EXTERNAL_DEBUG_LOG && __INPUT_DEBUG)
    {
        show_debug_message("Input: Set external debug log to \"" + string(global.__input_debug_log) + "\"");
        exception_unhandled_handler(__input_exception_handler);
    }
    
    __input_trace("Welcome to Input by @jujuadams and @offalynne! This is version ", __INPUT_VERSION, ", ", __INPUT_DATE);
    
    //Global frame counter. This is used for input buffering
    global.__input_frame = 0;
    
    //Whether momentary input has been cleared
    global.__input_cleared = false;
    
    //Mouse tracking variables. These are used to detect when the mouse has moved
    global.__input_mouse_x     = 0;
    global.__input_mouse_y     = 0;
    global.__input_mouse_moved = false;
    
    //Windows focus tracking
    global.__input_window_focus = true;
    
    //Windows tap-to-click tracking
    global.__input_tap_presses  = 0;
    global.__input_tap_releases = 0;
    global.__input_tap_click    = false;
    
    //Touch pointer tracking
    global.__input_pointer_index         = 0;
    global.__input_pointer_pressed       = false;
    global.__input_pointer_released      = false;
    global.__input_pointer_pressed_index = undefined;
    global.__input_pointer_durations     = array_create(INPUT_MAX_TOUCHPOINTS, 0);
    
    //Cursor tracking variables. This is Input's abstraction layer for the mouse, allowing mouse-like functionality cross-platform
    global.__input_cursor_verb_u      = undefined;
    global.__input_cursor_verb_d      = undefined;
    global.__input_cursor_verb_l      = undefined;
    global.__input_cursor_verb_r      = undefined;
    global.__input_cursor_speed       = 0;
    global.__input_cursor_using_mouse = true;
    
    //Whether these particular input sources are valid
    //This is determined by what default keybindings are set up
    global.__input_keyboard_default_defined = false;
    global.__input_mouse_default_defined    = false;
    global.__input_gamepad_default_defined  = false;
    
    //Disallow keyboard bindings on specified platforms unless explicitly enabled
    global.__input_keyboard_allowed = (__INPUT_KEYBOARD_SUPPORT && ((os_type != os_android) || INPUT_ANDROID_KEYBOARD_ALLOWED) && ((os_type != os_switch) || INPUT_SWITCH_KEYBOARD_ALLOWED));

    //Disallow mouse bindings on specified platforms (unless explicitly enabled)
    global.__input_mouse_allowed = !(__INPUT_ON_PS || __INPUT_ON_XDK || (__INPUT_TOUCH_SUPPORT && !INPUT_TOUCH_POINTER_ALLOWED));

    //Whether mouse is blocked due to Window focus state
    global.__input_mouse_blocked = false;
    
    //Whether to swap A/B gamepad buttons for default bindings
    global.__input_swap_ab = false;
    
    //Struct to store all the keyboard keys we want to ignore
    global.__input_ignore_key_dict = {};
    
    //Struct to store ignored gamepad types
    global.__input_ignore_gamepad_types = {}
    
    //Names for sources. I suspect this'll get sliced out at some point when I start recoding the binding system to serialise per controller type
    global.__input_config_category_names = ["none",               //INPUT_SOURCE.NONE
                                            "keyboard and mouse", //INPUT_SOURCE.KEYBOARD_AND_MOUSE
                                            "gamepad",            //INPUT_SOURCE.GAMEPAD
                                            "joycon"];
    
    //Two structs that are returned by input_players_get_status() and input_gamepads_get_status()
    //These are "static" structs that are reset and populated by input_tick()
    global.__input_players_status = {
        any_changed: false,
        new_connections: [],
        new_disconnections: [],
        players: array_create(INPUT_MAX_PLAYERS, INPUT_STATUS.DISCONNECTED),
    }
    
    global.__input_gamepads_status = {
        any_changed: false,
        new_connections: [],
        new_disconnections: [],
        gamepads: array_create(gamepad_get_device_count(), INPUT_STATUS.DISCONNECTED),
    }
    
    //Array of players. Each player is a struct (instanceof __input_class_player) that contains lotsa juicy information
    global.__input_players = array_create(INPUT_MAX_PLAYERS, undefined);
    var _p = 0;
    repeat(INPUT_MAX_PLAYERS)
    {
        global.__input_players[@ _p] = new __input_class_player();
        ++_p;
    }
    
    //The default player. This player struct holds default binding data
    global.__input_default_player = new __input_class_player();
    
    //The last player (struct) that was rebinding a key. Used for input_rebind_undo()
    global.__input_rebind_last_player = undefined;
    
    //Array of currently connected gamepads. If an element is <undefined> then the gamepad is disconnected
    //Each gamepad in this array is an instance of __input_class_gamepad
    //Gamepad structs contain remapping information and current button state
    global.__input_gamepads = array_create(gamepad_get_device_count(), undefined);
    
    //Our database of SDL2 definitions, used for the aforementioned remapping information
    global.__input_sdl2_database = {
        by_guid           : {},
        by_vendor_product : {},
    };
    
    global.__input_sdl2_look_up_table = {
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
    }
    
    if (INPUT_SDL2_ALLOW_EXTENDED)
    {
        global.__input_sdl2_look_up_table.guide    = gp_guide;
        global.__input_sdl2_look_up_table.misc1    = gp_misc1;
        global.__input_sdl2_look_up_table.touchpad = gp_touchpad;
        global.__input_sdl2_look_up_table.paddle1  = gp_paddle1;
        global.__input_sdl2_look_up_table.paddle2  = gp_paddle2;
        global.__input_sdl2_look_up_table.paddle3  = gp_paddle3;
        global.__input_sdl2_look_up_table.paddle4  = gp_paddle4;
    }
    
    #region Gamepad mapping database
    
    if (!__INPUT_SDL2_SUPPORT || !INPUT_SDL2_REMAPPING)
    {
        __input_trace("Skipping loading SDL database");
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
  
    var _default_xbox_type = "xbox one"; //Default type assigned to XInput and Xbox-like gamepads
    
    #region Gamepad type identification
    
    //Lookup table for simple gamepad types based on raw types
    global.__input_simple_type_lookup = {
    
        //Xbox
        CommunityLikeXBox: _default_xbox_type,

        XBoxOneController: "xbox one",
        SteamControllerV2: "xbox one",
        CommunityXBoxOne:  "xbox one",
        AppleController:   "xbox one", // Apple uses Xbox One iconography excepting 'View' button, shoulders, triggers
        CommunityStadia:   "xbox one", //Stadia uses Xbox One iconography excepting 'View' button, shoulders, triggers
        CommunityLuna:     "xbox one", //  Luna uses Xbox One iconography excepting 'View' button
        
        XBox360Controller:  "xbox 360",
        CommunityXBox360:   "xbox 360",
        CommunityDreamcast: "xbox 360", //        Xbox 360 uses Dreamcast iconography
        SteamController:    "xbox 360", //Steam Controller uses X-Box 360 iconography
        MobileTouch:        "xbox 360", //      Steam Link uses X-Box 360 iconography
        
        //PlayStation
        PS5Controller: "ps5",
        PS4Controller: "ps4",
        CommunityPS4:  "ps4",
        PS3Controller: "psx",
        CommunityPSX:  "psx",
        
        //Switch
        SwitchHandheld:            "switch", //Attached JoyCon pair or Switch Lite
        SwitchJoyConPair:          "switch",
        SwitchProController:       "switch",
        XInputSwitchController:    "switch",
        SwitchInputOnlyController: "switch",
        CommunityLikeSwitch:       "switch",
        Community8BitDo:           "switch", //8BitDo are Switch gamepads (exceptions typed appropriately)

        SwitchJoyConLeft:  "switch joycon left",
        SwitchJoyConRight: "switch joycon right",
        
        //Legacy
        CommunityGameCube:     "gamecube",
        CommunityN64:          "n64",
        CommunitySaturn:       "saturn",
        CommunitySNES:         "snes",
        CommunitySuperFamicom: "snes",
        
        Unknown: "unknown",
        unknown: "unknown",
        
        UnknownNonSteamController: "unknown",
        CommunityUnknown:          "unknown",
        CommunitySteam:            "unknown"
        
    }
    
    //Parse controller type database
    global.__input_raw_type_dictionary = { none : _default_xbox_type };

    //Load the controller type database
    if (__INPUT_ON_CONSOLE || __INPUT_ON_OPERAGX || (os_type == os_ios))
    {
        __input_trace("Skipping loading controller type database");
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
    
    global.__input_blacklist_dictionary = {};
    if (!__INPUT_SDL2_SUPPORT)
    {
        __input_trace("Skipping loading controller blacklist database");
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
    
    #region Gamepad button labels and colors
    
    global.__input_button_label_dictionary = {};
    global.__input_button_color_dictionary = {};
    
    if (INPUT_LOAD_BUTTON_LABELS_AND_COLORS)
    {
        if (file_exists(INPUT_BUTTON_LABEL_PATH))
        {
            __input_load_button_label_csv(INPUT_BUTTON_LABEL_PATH);
        }
        else
        {
            __input_trace("Warning! \"", INPUT_BUTTON_LABEL_PATH, "\" not found in Included Files");
        }
        
        if (file_exists(INPUT_BUTTON_COLOR_PATH))
        {
            __input_load_button_color_csv(INPUT_BUTTON_COLOR_PATH);
        }
        else
        {
            __input_trace("Warning! \"", INPUT_BUTTON_COLOR_PATH, "\" not found in Included Files");
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
        input_ignore_key_add(vk_meta1);
        input_ignore_key_add(vk_meta2);
        
        input_ignore_key_add(0xFF); //Vendor key
        
        if (__INPUT_ON_MOBILE && __INPUT_ON_APPLE)
        {
            input_ignore_key_add(124); //Screenshot
        }
        
        if (__INPUT_ON_WEB)
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
        
        if (os_type == os_uwp)
        {
            input_ignore_key_add(195); //XInput A 
            input_ignore_key_add(196); //XInput B 
            input_ignore_key_add(197); //XInput X 
            input_ignore_key_add(198); //XInput Y 
            input_ignore_key_add(200); //XInput LB 
            input_ignore_key_add(199); //XInput RB 
            input_ignore_key_add(201); //XInput LT 
            input_ignore_key_add(202); //XInput RT 
            input_ignore_key_add(209); //XInput LS 
            input_ignore_key_add(210); //XInput RS 
            input_ignore_key_add(208); //XInput Back 
            input_ignore_key_add(207); //XInput Start         
            input_ignore_key_add(203); //XInput DP Up 
            input_ignore_key_add(204); //XInput DP Down 
            input_ignore_key_add(205); //XInput DP Left
            input_ignore_key_add(206); //XInput DP Right        
            input_ignore_key_add(214); //XInput -LX
            input_ignore_key_add(213); //XInput +LX 
            input_ignore_key_add(211); //XInput -LY 
            input_ignore_key_add(212); //XInput +LY 
            input_ignore_key_add(218); //XInput -RX 
            input_ignore_key_add(217); //XInput +RX 
            input_ignore_key_add(215); //XInput -RY 
            input_ignore_key_add(216); //XInput +RY 
        }
    }
    
    //Keyboard ignore level 2+
    if (INPUT_IGNORE_RESERVED_KEYS_LEVEL > 1)
    {
        input_ignore_key_add(144); //Num Lock
        input_ignore_key_add(145); //Scroll Lock
        
        if (__INPUT_ON_WEB || (os_type == os_windows) || (os_type == os_uwp))
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
            input_ignore_key_add(0xB6); //Laumch App 1
            input_ignore_key_add(0xB7); //Launch App 2
            
            input_ignore_key_add(0xFB); //Zoom
        }
    }
    
    #endregion
    
    #region Steam Input
    
    if (((os_type == os_linux) || (os_type == os_macosx)) && !__INPUT_ON_WEB)
    {
        //Define the virtual controller's identity
        var _os = ((os_type == os_macosx)? "macos"    : "linux");
        var _id = ((os_type == os_macosx)? "5e048e02" : "de28ff11");
    
        //Access the blacklist
        var _blacklist_os = (is_struct(global.__input_blacklist_dictionary)? global.__input_blacklist_dictionary[$ _os] : undefined);
        var _blacklist_id = (is_struct(_blacklist_os)? _blacklist_os[$ "vid+pid"] : undefined);
    
        if (is_struct(_blacklist_os) && (_blacklist_id == undefined))
        {
            //Add 'Vendor ID + Product ID' category
            _blacklist_os[$ "vid+pid"] = {};
            _blacklist_id = (is_struct(_blacklist_os)? _blacklist_os[$ "vid+pid"] : undefined);
        }
    
        //Blacklist the Steam virtual controller
        if (is_struct(_blacklist_id)) _blacklist_id[$ _id] = true;   
    }
    
    if ((os_type == os_linux) && !__INPUT_ON_WEB)
    {
        var _steam_environ = environment_get_variable("SteamEnv");
        var _steam_configs = environment_get_variable("EnableConfiguratorSupport");
    
        if ((_steam_environ != "") && (_steam_environ == "1")
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
        
            if (environment_get_variable("SDL_GAMECONTROLLER_IGNORE_DEVICES") == "")
            {
                //If ignore hint isn't set, GM accesses controllers meant to be blocked
                //We address this by adding the Steam config types to our own blocklist
                if (_steam_switch)  array_push(_ignore_list, "switch");
                if (_steam_ps)      array_push(_ignore_list, "ps4", "ps5");
                if (_steam_xbox)    array_push(_ignore_list, "xbox 360", "xbox one");        
                if (_steam_generic) array_push(_ignore_list, "snes", "saturn", "n64", "gamecube", "psx", "xbox", "switch joycon left", "switch joycon right", "unknown");
             
                var _i = 0;
                repeat(array_length(_ignore_list))
                {
                    global.__input_ignore_gamepad_types[$ _ignore_list[_i]] = true;
                }
            }
            
            //Check for a reducible type configuration
            var _steam_switch_labels = environment_get_variable("SDL_GAMECONTROLLER_USE_BUTTON_LABELS");
            if (!_steam_generic && !_steam_ps
            && (!_steam_switch || ((_steam_switch_labels != "") && (_steam_switch_labels == "1"))))
            {
                //The remaining configurations are in the Xbox Controller style including:
                //Steam Controller, Steam Link, Steam Deck, Xbox or Switch with AB/XY swap
                global.__input_simple_type_lookup[$ "CommunitySteam"] = _default_xbox_type;
            }
        }
    }

    #endregion
    
    //By default GameMaker registers double click (or tap) as right mouse button
    //We want to be able to identify the actual mouse buttons correctly, and have our own double-input handling
    device_mouse_dbclick_enable(false);
}
