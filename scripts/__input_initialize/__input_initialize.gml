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

    //Disallow mouse bindings on unsupported platforms (unless explicitly enabled)
    global.__input_mouse_allowed = !(__INPUT_ON_PS || __INPUT_ON_XDK || (__INPUT_TOUCH_SUPPORT && !INPUT_TOUCH_POINTER_ALLOWED));

    //Whether mouse is blocked due to Window focus state
    global.__input_mouse_blocked = false;
	
	//Whether to swap A/B gamepad buttons for default bindings
	global.__input_swap_ab = false;
	
	//Struct to store all the keyboard keys we want to ignore
	global.__input_ignore_key_dict = {};
	
	//Names for sources. I suspect this'll get sliced out at some point when I start recoding the binding system to serialise per controller type
	global.__input_config_category_names = ["none",               //INPUT_SOURCE.NONE
	                                        "keyboard and mouse", //INPUT_SOURCE.KEYBOARD_AND_MOUSE
	                                        "gamepad",            //INPUT_SOURCE.GAMEPAD
	                                        "joycon"];
	
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
	
	if (INPUT_SDL2_ALLOW_GUIDE) global.__input_sdl2_look_up_table.guide = gp_guide;
	if (INPUT_SDL2_ALLOW_MISC1) global.__input_sdl2_look_up_table.misc1 = gp_misc1;
	
	//Load the SDL2 database
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
	        if (is_string(_external_string) && (_external_string != ""))
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
	
	//Parse controller type database
	global.__input_raw_type_dictionary = { none : "XBox360Controller" };
	
	//Load the controller type database
	if (!__INPUT_ON_DESKTOP && (os_type != os_android))
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
	
	if (__INPUT_ON_CONSOLE || __INPUT_ON_WEB)
	{
	    __input_trace("Skipping loading controller blacklist database");
	}
	else
	{
	    //Parse the controller type database
	    global.__input_blacklist_dictionary = {};
    
	    if (file_exists(INPUT_BLACKLIST_PATH))
	    {
	        __input_load_blacklist_csv(INPUT_BLACKLIST_PATH);
	    }
	    else
	    {
	        __input_trace("Warning! \"", INPUT_BLACKLIST_PATH, "\" not found in Included Files");
	    }
	}
	
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
	    input_ignore_key_add(144); //num lock
	    input_ignore_key_add(145); //scroll lock
		
	    if (__INPUT_ON_WEB || (os_type == os_windows) || (os_type == os_uwp))
	    {
	        input_ignore_key_add(0x15); //IME key
	        input_ignore_key_add(0x16); //IME key
	        input_ignore_key_add(0x17); //IME key
	        input_ignore_key_add(0x18); //IME key
	        input_ignore_key_add(0x19); //IME key
	        input_ignore_key_add(0x1A); //IME key
	        input_ignore_key_add(0xE5); //IME key
			
	        input_ignore_key_add(0xA6); //Browser key
	        input_ignore_key_add(0xA7); //Browser key
	        input_ignore_key_add(0xA8); //Browser key
	        input_ignore_key_add(0xA9); //Browser key
	        input_ignore_key_add(0xAA); //Browser key
	        input_ignore_key_add(0xAB); //Browser key
	        input_ignore_key_add(0xAC); //Browser key
			
	        input_ignore_key_add(0xAD); //Media key
	        input_ignore_key_add(0xAE); //Media key
	        input_ignore_key_add(0xAF); //Media key
	        input_ignore_key_add(0xB0); //Media key
	        input_ignore_key_add(0xB1); //Media key
	        input_ignore_key_add(0xB2); //Media key
	        input_ignore_key_add(0xB3); //Media key
	        input_ignore_key_add(0xB4); //Media key
	        input_ignore_key_add(0xB5); //Media key
	        input_ignore_key_add(0xB6); //Media key
	        input_ignore_key_add(0xB7); //Media key
	    }
	}
	
	//By default GameMaker registers double click (or tap) as right mouse button
	//We want to be able to identify the actual mouse buttons correctly, and have our own double-input handling
	device_mouse_dbclick_enable(false);
}