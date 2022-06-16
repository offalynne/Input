/// This struct contains mappings from binding labels - a combination of keyboard key names, mouse button
/// names, and abstract gamepad names - to more friendly terms that you can show a player. Typically you'd
/// set up this function to return sprites such that you can draw gamepad icons as visual icons.
/// 
/// Default values in this struct reflect the particular, and sometimes unexpected, buttons that each gamepad
/// binding maps to on the actual physical hardware. There are a handful of special cases at the top of the
/// struct that are used to handle errors or misconfigurations. In the interest of YYC compatibility, spaces
/// in key names in this stuct are filtered to underscores.

INPUT_ICONS {
    
    #region Special Cases
    
    //Special case: When a non-binding is being evaluated
    "not_a_binding": "not a binding",
    
    //Special case: When an invalid binding is being evaluated (usually happens when no source is assigned for a player)
    "unknown": "unknown",
    
    //Special case: Fallback gamepad icons
    //These are used when a gamepad is not recognised or an icon definition doesn't exist for a specific gamepad type
    "gamepad_fallback": {
        "gamepad_face_south":         "A",
        "gamepad_face_east":          "B",
        "gamepad_face_west":          "X",
        "gamepad_face_north":         "Y",
        "gamepad_shoulder_l":         "LB",
        "gamepad_shoulder_r":         "RB",
        "gamepad_trigger_l":          "LT",
        "gamepad_trigger_r":          "RT",
        "gamepad_select":             "view",
        "gamepad_start":              "menu",
        "gamepad_dpad_up":            "dpad up",
        "gamepad_dpad_down":          "dpad down",
        "gamepad_dpad_left":          "dpad left",        
        "gamepad_dpad_right":         "dpad right",
        
        "gamepad_thumbstick_l_left":  "thumbstick l left",
        "gamepad_thumbstick_l_right": "thumbstick l right",
        "gamepad_thumbstick_l_up":    "thumbstick l up",
        "gamepad_thumbstick_l_down":  "thumbstick l down",
        "gamepad_thumbstick_l_click": "thumbstick l click",
        
        "gamepad_thumbstick_r_left":  "thumbstick r left",
        "gamepad_thumbstick_r_right": "thumbstick r right",
        "gamepad_thumbstick_r_up":    "thumbstick r up",
        "gamepad_thumbstick_r_down":  "thumbstick r down",
        "gamepad_thumbstick_r_click": "thumbstick r click",
        
        //Used for PlayStation 4 + 5 touchpad clicks (and occasionally other gamepads if INPUT_SDL2_ALLOW_EXTENDED is set to <true>)
        "gamepad_touchpad_click":     "touchpad click",
        
        //These are much less commonly used than the above
        //Please set INPUT_SDL2_ALLOW_EXTENDED to <true> to enable these gamepad buttons
        "gamepad_guide":              "guide",
        "gamepad_misc_1":             "misc",
        "gamepad_paddle_1":           "paddle 1",
        "gamepad_paddle_2":           "paddle 2",
        "gamepad_paddle_3":           "paddle 3",
        "gamepad_paddle_4":           "paddle 4",
    },
    
    #endregion
    
    //Optional remapping for keyboard and mouse
    //This is useful for turning keyboard keys into sprite icons to match other assets, or for returning formatted strings (e.g. for use with Scribble)
    //Any keyboard key label not in this struct will simply fall through
    "keyboard and mouse": {
        
    },
    
    #region Gamepads
    
    //Xbox One controllers
    "xbox_one": {
        "gamepad_face_south":         "A",
        "gamepad_face_east":          "B",
        "gamepad_face_west":          "X",
        "gamepad_face_north":         "Y",
        "gamepad_shoulder_l":         "LB",
        "gamepad_shoulder_r":         "RB",
        "gamepad_trigger_l":          "LT",
        "gamepad_trigger_r":          "RT",
        "gamepad_select":             "view",
        "gamepad_start":              "menu",
        "gamepad_dpad_up":            "dpad up",
        "gamepad_dpad_down":          "dpad down",
        "gamepad_dpad_left":          "dpad left",        
        "gamepad_dpad_right":         "dpad right",
        
        "gamepad_thumbstick_l_left":  "thumbstick l left",
        "gamepad_thumbstick_l_right": "thumbstick l right",
        "gamepad_thumbstick_l_up":    "thumbstick l up",
        "gamepad_thumbstick_l_down":  "thumbstick l down",
        "gamepad_thumbstick_l_click": "thumbstick l click",
        
        "gamepad_thumbstick_r_left":  "thumbstick r left",
        "gamepad_thumbstick_r_right": "thumbstick r right",
        "gamepad_thumbstick_r_up":    "thumbstick r up",
        "gamepad_thumbstick_r_down":  "thumbstick r down",
        "gamepad_thumbstick_r_click": "thumbstick r click",
        
        //These are used for Elite controllers only
        "gamepad_paddle_1":           "P1",
        "gamepad_paddle_2":           "P3",  //Thanks SDL
        "gamepad_paddle_3":           "P2",  //Many thanks
        "gamepad_paddle_4":           "P4",
    },
    
    //PlayStation 5
    "ps5": {
        "gamepad_face_south":         "cross",
        "gamepad_face_east":          "circle",
        "gamepad_face_west":          "square",
        "gamepad_face_north":         "triangle",
        "gamepad_shoulder_l":         "L1",
        "gamepad_shoulder_r":         "R1",
        "gamepad_trigger_l":          "L2",
        "gamepad_trigger_r":          "R2",
        "gamepad_select":             "create",
        "gamepad_start":              "options",
        "gamepad_thumbstick_l_click": "L3",
        "gamepad_thumbstick_r_click": "R3",
        "gamepad_dpad_up":            "dpad up",
        "gamepad_dpad_down":          "dpad down",
        "gamepad_dpad_left":          "dpad left",        
        "gamepad_dpad_right":         "dpad right",
        
        "gamepad_thumbstick_l_left":  "thumbstick l left",
        "gamepad_thumbstick_l_right": "thumbstick l right",
        "gamepad_thumbstick_l_up":    "thumbstick l up",
        "gamepad_thumbstick_l_down":  "thumbstick l down",
        
        "gamepad_thumbstick_r_left":  "thumbstick r left",
        "gamepad_thumbstick_r_right": "thumbstick r right",
        "gamepad_thumbstick_r_up":    "thumbstick r up",
        "gamepad_thumbstick_r_down":  "thumbstick r down",
        
        "gamepad_touchpad_click": "touchpad click",
        
        //Not available on the PlayStation 5 console itself but available on other platforms
        "gamepad_misc_1":         "mic",
    },
    
    //Switch handheld/dual JoyCon/Pro Controller
    "switch": {
        "gamepad_face_south":         "B",
        "gamepad_face_east":          "A",
        "gamepad_face_west":          "X",
        "gamepad_face_north":         "Y",
        "gamepad_shoulder_l":         "L",
        "gamepad_shoulder_r":         "R",
        "gamepad_trigger_l":          "ZL",
        "gamepad_trigger_r":          "ZR",
        "gamepad_select":             "plus",
        "gamepad_start":              "minus",
        "gamepad_dpad_up":            "dpad up",
        "gamepad_dpad_down":          "dpad down",
        "gamepad_dpad_left":          "dpad left",        
        "gamepad_dpad_right":         "dpad right",
        
        "gamepad_thumbstick_l_left":  "thumbstick l left",
        "gamepad_thumbstick_l_right": "thumbstick l right",
        "gamepad_thumbstick_l_up":    "thumbstick l up",
        "gamepad_thumbstick_l_down":  "thumbstick l down",
        "gamepad_thumbstick_l_click": "LS",
        
        "gamepad_thumbstick_r_left":  "thumbstick r left",
        "gamepad_thumbstick_r_right": "thumbstick r right",
        "gamepad_thumbstick_r_up":    "thumbstick r up",
        "gamepad_thumbstick_r_down":  "thumbstick r down",
        "gamepad_thumbstick_r_click": "RS",
        
        //Not available on the Switch console itself but available on other platforms
        "gamepad_guide":              "home",
        "gamepad_misc_1":             "capture",
    },
    
    //Left-hand Switch JoyCon
    //This setup assums horizontal hold type
    "switch_joycon_left": {
        "gamepad_face_south":         "face south",
        "gamepad_face_east":          "face east",
        "gamepad_face_west":          "face west", 
        "gamepad_face_north":         "face north",
        "gamepad_shoulder_l":         "SL",
        "gamepad_shoulder_r":         "SR",
        "gamepad_start":              "minus",
        
        "gamepad_thumbstick_l_left":  "thumbstick left",
        "gamepad_thumbstick_l_right": "thumbstick right",
        "gamepad_thumbstick_l_up":    "thumbstick up",
        "gamepad_thumbstick_l_down":  "thumbstick down",
        "gamepad_thumbstick_l_click": "LS",
        
        //Not available on the Switch console itself but available on other platforms
        "gamepad_select":             "capture",
    },
    
    //Right-hand Switch JoyCon
    //This setup assums horizontal hold type
    "switch_joycon_right": {
        "gamepad_face_south":         "face south",
        "gamepad_face_east":          "face east",
        "gamepad_face_west":          "face west", 
        "gamepad_face_north":         "face north",
        "gamepad_shoulder_l":         "SL",
        "gamepad_shoulder_r":         "SR",
        "gamepad_start":              "plus",
        
        "gamepad_thumbstick_l_left":  "thumbstick left",
        "gamepad_thumbstick_l_right": "thumbstick right",
        "gamepad_thumbstick_l_up":    "thumbstick up",
        "gamepad_thumbstick_l_down":  "thumbstick down",
        "gamepad_thumbstick_l_click": "LS",
        
        //Not available on the Switch console itself but available on other platforms
        "gamepad_select":             "home",
    },
    
    //Xbox 360
    "xbox_360": {
        "gamepad_face_south":         "A",
        "gamepad_face_east":          "B",
        "gamepad_face_west":          "X",
        "gamepad_face_north":         "Y",
        "gamepad_shoulder_l":         "LB",
        "gamepad_shoulder_r":         "RB",
        "gamepad_trigger_l":          "LT",
        "gamepad_trigger_r":          "RT",
        "gamepad_select":             "back",
        "gamepad_start":              "start",
        "gamepad_dpad_up":            "dpad up",
        "gamepad_dpad_down":          "dpad down",
        "gamepad_dpad_left":          "dpad left",        
        "gamepad_dpad_right":         "dpad right",
        
        "gamepad_thumbstick_l_left":  "thumbstick l left",
        "gamepad_thumbstick_l_right": "thumbstick l right",
        "gamepad_thumbstick_l_up":    "thumbstick l up",
        "gamepad_thumbstick_l_down":  "thumbstick l down",
        "gamepad_thumbstick_l_click": "thumbstick l click",
        
        "gamepad_thumbstick_r_left":  "thumbstick r left",
        "gamepad_thumbstick_r_right": "thumbstick r right",
        "gamepad_thumbstick_r_up":    "thumbstick r up",
        "gamepad_thumbstick_r_down":  "thumbstick r down",
        "gamepad_thumbstick_r_click": "thumbstick r click",
    },
    
    //PlayStation 4
    "ps4": {
        "gamepad_face_south":         "cross",
        "gamepad_face_east":          "circle",
        "gamepad_face_west":          "square",
        "gamepad_face_north":         "triangle",
        "gamepad_shoulder_l":         "L1",
        "gamepad_shoulder_r":         "R1",
        "gamepad_trigger_l":          "L2",
        "gamepad_trigger_r":          "R2",
        "gamepad_select":             "share",
        "gamepad_start":              "options",
        "gamepad_dpad_up":            "dpad up",
        "gamepad_dpad_down":          "dpad down",
        "gamepad_dpad_left":          "dpad left",        
        "gamepad_dpad_right":         "dpad right",
        
        "gamepad_thumbstick_l_left":  "thumbstick l left",
        "gamepad_thumbstick_l_right": "thumbstick l right",
        "gamepad_thumbstick_l_up":    "thumbstick l up",
        "gamepad_thumbstick_l_down":  "thumbstick l down",
        "gamepad_thumbstick_l_click": "L3",
        
        "gamepad_thumbstick_r_left":  "thumbstick r left",
        "gamepad_thumbstick_r_right": "thumbstick r right",
        "gamepad_thumbstick_r_up":    "thumbstick r up",
        "gamepad_thumbstick_r_down":  "thumbstick r down",
        "gamepad_thumbstick_r_click": "R3",
        
        "gamepad_touchpad_click": "touchpad click",
    },
    
    //Nintendo Gamecube
    "gamecube": {
        "gamepad_face_south":         "A",
        "gamepad_face_east":          "X",
        "gamepad_face_west":          "B",
        "gamepad_face_north":         "Y",
        "gamepad_shoulder_r":         "Z",
        "gamepad_trigger_l":          "L",
        "gamepad_trigger_r":          "R",
        "gamepad_start":              "start",
        "gamepad_dpad_up":            "dpad up",
        "gamepad_dpad_down":          "dpad down",
        "gamepad_dpad_left":          "dpad left",        
        "gamepad_dpad_right":         "dpad right",
        
        "gamepad_thumbstick_l_left":  "thumbstick l left",
        "gamepad_thumbstick_l_right": "thumbstick l right",
        "gamepad_thumbstick_l_up":    "thumbstick l up",
        "gamepad_thumbstick_l_down":  "thumbstick l down",
        
        "gamepad_thumbstick_r_left":  "thumbstick r left",
        "gamepad_thumbstick_r_right": "thumbstick r right",
        "gamepad_thumbstick_r_up":    "thumbstick r up",
        "gamepad_thumbstick_r_down":  "thumbstick r down",
		
        // Switch GameCube controllers and adapters only
        "gamepad_thumbstick_l_click": "thumbstick l click",
        "gamepad_thumbstick_r_click": "thumbstick r click",
		"gamepad_guide":              "home",
        "gamepad_misc_1":             "capture",
    },
    
    //PlayStation 1-3
    "psx": {
        "gamepad_face_south":         "cross",
        "gamepad_face_east":          "circle",
        "gamepad_face_west":          "square",
        "gamepad_face_north":         "triangle",
        "gamepad_shoulder_l":         "L1",
        "gamepad_shoulder_r":         "R1",
        "gamepad_trigger_l":          "L2",
        "gamepad_trigger_r":          "R2",
        "gamepad_select":             "select",
        "gamepad_start":              "start",
        "gamepad_dpad_up":            "dpad up",
        "gamepad_dpad_down":          "dpad down",
        "gamepad_dpad_left":          "dpad left",        
        "gamepad_dpad_right":         "dpad right",
        
        "gamepad_thumbstick_l_left":  "thumbstick l left",
        "gamepad_thumbstick_l_right": "thumbstick l right",
        "gamepad_thumbstick_l_up":    "thumbstick l up",
        "gamepad_thumbstick_l_down":  "thumbstick l down",
        "gamepad_thumbstick_l_click": "L3",
        
        "gamepad_thumbstick_r_left":  "thumbstick r left",
        "gamepad_thumbstick_r_right": "thumbstick r right",
        "gamepad_thumbstick_r_up":    "thumbstick r up",
        "gamepad_thumbstick_r_down":  "thumbstick r down",
        "gamepad_thumbstick_r_click": "R3",
    },
    
    //Nintendo 64
    "n64": {
        "gamepad_face_south":         "A",
        "gamepad_face_east":          "B",
        "gamepad_shoulder_l":         "L",
        "gamepad_shoulder_r":         "R",
        "gamepad_trigger_l":          "Z",
        "gamepad_start":              "start",
        "gamepad_dpad_up":            "dpad up",
        "gamepad_dpad_down":          "dpad down",
        "gamepad_dpad_left":          "dpad left",        
        "gamepad_dpad_right":         "dpad right",
        
        "gamepad_thumbstick_l_left":  "thumbstick left",
        "gamepad_thumbstick_l_right": "thumbstick right",
        "gamepad_thumbstick_l_up":    "thumbstick up",
        "gamepad_thumbstick_l_down":  "thumbstick down",
        
        "gamepad_thumbstick_r_left":  "C left",
        "gamepad_thumbstick_r_right": "C right",
        "gamepad_thumbstick_r_up":    "C up",
        "gamepad_thumbstick_r_down":  "C down",
    },
    
    //Sega Saturn
    "saturn": {
        "gamepad_face_south": "A",
        "gamepad_face_east":  "B",
        "gamepad_face_west":  "X",
        "gamepad_face_north": "Y",
        "gamepad_shoulder_l": "L",
        "gamepad_shoulder_r": "Z",
        "gamepad_trigger_l":  "R",
        "gamepad_trigger_r":  "C",
        "gamepad_select":     "mode",
        "gamepad_start":      "start",
        "gamepad_dpad_up":    "dpad up",
        "gamepad_dpad_down":  "dpad down",
        "gamepad_dpad_left":  "dpad left",        
        "gamepad_dpad_right": "dpad right",
    },
    
    //Super Nintendo
    "snes": {
        "gamepad_face_south": "B",
        "gamepad_face_east":  "A",
        "gamepad_face_west":  "Y",
        "gamepad_face_north": "X",
        "gamepad_shoulder_l": "L",
        "gamepad_shoulder_r": "R",
        "gamepad_select":     "select",
        "gamepad_start":      "start",
        "gamepad_dpad_up":    "dpad up",
        "gamepad_dpad_down":  "dpad down",
        "gamepad_dpad_left":  "dpad left",        
        "gamepad_dpad_right": "dpad right",
    },
    
    #endregion
};