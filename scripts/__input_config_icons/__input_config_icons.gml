/// This struct contains mappings from binding labels - a combination of keyboard key names, mouse button
/// names, and abstract gamepad names - to more friendly terms that you can show a player. Typically you'd
/// set up this function to return sprites such that you can draw gamepad icons as visual icons.
/// 
/// Default values in this struct reflect the particular, and sometimes unexpected, buttons that each gamepad
/// binding maps to on the actual physical hardware. There are a handful of special cases at the top of the
/// struct that are used to handle errors or misconfigurations.

INPUT_ICONS {
    
    #region Special Cases
    
    //Special case: When a non-binding is being evaluated
    "not a binding": "not a binding",
    
    //Special case: When an invalid binding is being evaluated (usually happens when no source is assigned for a player)
    "unknown": "unknown",
    
    //Special case: Fallback gamepad icons
    //These are used when a gamepad is not recognised or an icon definition doesn't exist for a specific gamepad type
    "gamepad fallback": {
        "gamepad face south":         "A",
        "gamepad face east":          "B",
        "gamepad face west":          "X",
        "gamepad face north":         "Y",
        "gamepad shoulder l":         "LB",
        "gamepad shoulder r":         "RB",
        "gamepad trigger l":          "LT",
        "gamepad trigger r":          "RT",
        "gamepad select":             "view",
        "gamepad start":              "menu",
        "gamepad dpad left":          "dpad left",
        "gamepad dpad right":         "dpad right",
        "gamepad dpad up":            "dpad up",
        "gamepad dpad down":          "dpad down",
        
        "gamepad thumbstick l left":  "thumbstick l left",
        "gamepad thumbstick l right": "thumbstick l right",
        "gamepad thumbstick l up":    "thumbstick l up",
        "gamepad thumbstick l down":  "thumbstick l down",
        "gamepad thumbstick l click": "thumbstick l click",
        
        "gamepad thumbstick r left":  "thumbstick r left",
        "gamepad thumbstick r right": "thumbstick r right",
        "gamepad thumbstick r up":    "thumbstick r up",
        "gamepad thumbstick r down":  "thumbstick r down",
        "gamepad thumbstick r click": "thumbstick r click",
        
        //Used for PlayStation 4 + 5 touchpad clicks (and occasionally other gamepads if INPUT_SDL2_ALLOW_EXTENDED is set to <true>)
        "gamepad touchpad click":     "touchpad click",
        
        //These are much less commonly used than the above
        //Please set INPUT_SDL2_ALLOW_EXTENDED to <true> to enable these gamepad buttons
        "gamepad guide":              "guide",
        "gamepad misc 1":             "misc",
        "gamepad paddle 1":           "paddle 1",
        "gamepad paddle 2":           "paddle 2",
        "gamepad paddle 3":           "paddle 3",
        "gamepad paddle 4":           "paddle 4",
    },
    
    #endregion
    
    //Optional remapping for keyboard and mouse
    //This is useful for turning keyboard keys into sprite icons to match other assets, or for returning formatted strings (e.g. for use with Scribble)
    //Any keyboard key label not in this struct will simply fall through
    "keyboard and mouse": {
        
    },
    
    #region Gamepads
    
    //Xbox One controllers
    "xbox one": {
        "gamepad face south":         "A",
        "gamepad face east":          "B",
        "gamepad face west":          "X",
        "gamepad face north":         "Y",
        "gamepad shoulder l":         "LB",
        "gamepad shoulder r":         "RB",
        "gamepad trigger l":          "LT",
        "gamepad trigger r":          "RT",
        "gamepad select":             "view",
        "gamepad start":              "menu",
        "gamepad dpad left":          "dpad left",
        "gamepad dpad right":         "dpad right",
        "gamepad dpad up":            "dpad up",
        "gamepad dpad down":          "dpad down",
        
        "gamepad thumbstick l left":  "thumbstick l left",
        "gamepad thumbstick l right": "thumbstick l right",
        "gamepad thumbstick l up":    "thumbstick l up",
        "gamepad thumbstick l down":  "thumbstick l down",
        "gamepad thumbstick l click": "thumbstick l click",
        
        "gamepad thumbstick r left":  "thumbstick r left",
        "gamepad thumbstick r right": "thumbstick r right",
        "gamepad thumbstick r up":    "thumbstick r up",
        "gamepad thumbstick r down":  "thumbstick r down",
        "gamepad thumbstick r click": "thumbstick r click",
        
        //These are used for Elite controllers only
        "gamepad paddle 1":           "P1",
        "gamepad paddle 2":           "P3",  //Thanks SDL
        "gamepad paddle 3":           "P2",  //Many thanks
        "gamepad paddle 4":           "P4",
    },
    
    //PlayStation 5
    "ps5": {
        "gamepad face south":         "cross",
        "gamepad face east":          "circle",
        "gamepad face west":          "square",
        "gamepad face north":         "triangle",
        "gamepad shoulder l":         "L1",
        "gamepad shoulder r":         "R1",
        "gamepad trigger l":          "L2",
        "gamepad trigger r":          "R2",
        "gamepad select":             "create",
        "gamepad start":              "options",
        "gamepad dpad left":          "dpad left",
        "gamepad dpad right":         "dpad right",
        "gamepad dpad up":            "dpad up",
        "gamepad dpad down":          "dpad down",
        
        "gamepad thumbstick l left":  "thumbstick l left",
        "gamepad thumbstick l right": "thumbstick l right",
        "gamepad thumbstick l up":    "thumbstick l up",
        "gamepad thumbstick l down":  "thumbstick l down",
        "gamepad thumbstick l click": "L3",
        
        "gamepad thumbstick r left":  "thumbstick r left",
        "gamepad thumbstick r right": "thumbstick r right",
        "gamepad thumbstick r up":    "thumbstick r up",
        "gamepad thumbstick r down":  "thumbstick r down",
        "gamepad thumbstick r click": "R3",
        
        "gamepad touchpad click": "touchpad click",
        
        //Not available on the PlayStation 5 console itself but available on other platforms
        "gamepad misc 1":         "mic",
    },
    
    //Switch handheld/dual JoyCon/Pro Controller
    "switch": {
        "gamepad face south":         "B",
        "gamepad face east":          "A",
        "gamepad face west":          "Y",
        "gamepad face north":         "X",
        "gamepad shoulder l":         "L",
        "gamepad shoulder r":         "R",
        "gamepad trigger l":          "ZL",
        "gamepad trigger r":          "ZR",
        "gamepad select":             "plus",
        "gamepad start":              "minus",
        "gamepad dpad left":          "dpad left",
        "gamepad dpad right":         "dpad right",
        "gamepad dpad up":            "dpad up",
        "gamepad dpad down":          "dpad down",
        
        "gamepad thumbstick l left":  "thumbstick l left",
        "gamepad thumbstick l right": "thumbstick l right",
        "gamepad thumbstick l up":    "thumbstick l up",
        "gamepad thumbstick l down":  "thumbstick l down",
        "gamepad thumbstick l click": "thumbstick l click",
        
        "gamepad thumbstick r left":  "thumbstick r left",
        "gamepad thumbstick r right": "thumbstick r right",
        "gamepad thumbstick r up":    "thumbstick r up",
        "gamepad thumbstick r down":  "thumbstick r down",
        "gamepad thumbstick r click": "thumbstick r click",
        
        //Not available on the Switch console itself but available on other platforms
        "gamepad guide":              "home",
        "gamepad misc 1":             "capture",
    },
    
    //Left-hand Switch JoyCon
    //This setup assums horizontal hold type
    "switch joycon left": {
        "gamepad face south":         "face south",
        "gamepad face east":          "face east",
        "gamepad face west":          "face west", 
        "gamepad face north":         "face north",
        "gamepad shoulder l":         "SL",
        "gamepad shoulder r":         "SR",
        "gamepad start":              "minus",
        
        "gamepad thumbstick l left":  "thumbstick left",
        "gamepad thumbstick l right": "thumbstick right",
        "gamepad thumbstick l up":    "thumbstick up",
        "gamepad thumbstick l down":  "thumbstick down",
        "gamepad thumbstick l click": "thumbstick click",
        
        //Not available on the Switch console itself but available on other platforms
        "gamepad select":             "capture",
    },
    
    //Right-hand Switch JoyCon
    //This setup assums horizontal hold type
    "switch joycon right": {
        "gamepad face south":         "face south",
        "gamepad face east":          "face east",
        "gamepad face west":          "face west", 
        "gamepad face north":         "face north",
        "gamepad shoulder l":         "SL",
        "gamepad shoulder r":         "SR",
        "gamepad start":              "plus",
        
        "gamepad thumbstick l left":  "thumbstick left",
        "gamepad thumbstick l right": "thumbstick right",
        "gamepad thumbstick l up":    "thumbstick up",
        "gamepad thumbstick l down":  "thumbstick down",
        "gamepad thumbstick l click": "thumbstick click",
        
        //Not available on the Switch console itself but available on other platforms
        "gamepad select":             "home",
    },
    
    //Xbox 360
    "xbox 360": {
        "gamepad face south":         "A",
        "gamepad face east":          "B",
        "gamepad face west":          "X",
        "gamepad face north":         "Y",
        "gamepad shoulder l":         "LB",
        "gamepad shoulder r":         "RB",
        "gamepad trigger l":          "LT",
        "gamepad trigger r":          "RT",
        "gamepad select":             "back",
        "gamepad start":              "start",
        "gamepad dpad left":          "dpad left",
        "gamepad dpad right":         "dpad right",
        "gamepad dpad up":            "dpad up",
        "gamepad dpad down":          "dpad down",
        
        "gamepad thumbstick l left":  "thumbstick l left",
        "gamepad thumbstick l right": "thumbstick l right",
        "gamepad thumbstick l up":    "thumbstick l up",
        "gamepad thumbstick l down":  "thumbstick l down",
        "gamepad thumbstick l click": "thumbstick l click",
        
        "gamepad thumbstick r left":  "thumbstick r left",
        "gamepad thumbstick r right": "thumbstick r right",
        "gamepad thumbstick r up":    "thumbstick r up",
        "gamepad thumbstick r down":  "thumbstick r down",
        "gamepad thumbstick r click": "thumbstick r click",
    },
    
    //PlayStation 4
    "ps4": {
        "gamepad face south":         "cross",
        "gamepad face east":          "circle",
        "gamepad face west":          "square",
        "gamepad face north":         "triangle",
        "gamepad shoulder l":         "L1",
        "gamepad shoulder r":         "R1",
        "gamepad trigger l":          "L2",
        "gamepad trigger r":          "R2",
        "gamepad select":             "share",
        "gamepad start":              "options",
        "gamepad dpad left":          "dpad left",
        "gamepad dpad right":         "dpad right",
        "gamepad dpad up":            "dpad up",
        "gamepad dpad down":          "dpad down",
        
        "gamepad thumbstick l left":  "thumbstick l left",
        "gamepad thumbstick l right": "thumbstick l right",
        "gamepad thumbstick l up":    "thumbstick l up",
        "gamepad thumbstick l down":  "thumbstick l down",
        "gamepad thumbstick l click": "L3",
        
        "gamepad thumbstick r left":  "thumbstick r left",
        "gamepad thumbstick r right": "thumbstick r right",
        "gamepad thumbstick r up":    "thumbstick r up",
        "gamepad thumbstick r down":  "thumbstick r down",
        "gamepad thumbstick r click": "R3",
        
        "gamepad touchpad click": "touchpad click",
    },
    
    
    //PlayStation 1-3
    "psx": {
        "gamepad face south":         "cross",
        "gamepad face east":          "circle",
        "gamepad face west":          "square",
        "gamepad face north":         "triangle",
        "gamepad shoulder l":         "L1",
        "gamepad shoulder r":         "R1",
        "gamepad trigger l":          "L2",
        "gamepad trigger r":          "R2",
        "gamepad select":             "select",
        "gamepad start":              "start",
        "gamepad dpad left":          "dpad left",
        "gamepad dpad right":         "dpad right",
        "gamepad dpad up":            "dpad up",
        "gamepad dpad down":          "dpad down",
        
        "gamepad thumbstick l left":  "thumbstick l left",
        "gamepad thumbstick l right": "thumbstick l right",
        "gamepad thumbstick l up":    "thumbstick l up",
        "gamepad thumbstick l down":  "thumbstick l down",
        "gamepad thumbstick l click": "L3",
        
        "gamepad thumbstick r left":  "thumbstick r left",
        "gamepad thumbstick r right": "thumbstick r right",
        "gamepad thumbstick r up":    "thumbstick r up",
        "gamepad thumbstick r down":  "thumbstick r down",
        "gamepad thumbstick r click": "R3",
    },
    
    //Nintendo Gamecube
    "gamecube": {
        "gamepad face south":         "A",
        "gamepad face east":          "X",
        "gamepad face west":          "B",
        "gamepad face north":         "Y",
        "gamepad shoulder r":         "Z",
        "gamepad trigger l":          "L",
        "gamepad trigger r":          "R",
        "gamepad start":              "start",
        "gamepad dpad left":          "dpad left",
        "gamepad dpad right":         "dpad right",
        "gamepad dpad up":            "dpad up",
        "gamepad dpad down":          "dpad down",
        
        "gamepad thumbstick l left":  "thumbstick l left",
        "gamepad thumbstick l right": "thumbstick l right",
        "gamepad thumbstick l up":    "thumbstick l up",
        "gamepad thumbstick l down":  "thumbstick l down",
        
        "gamepad thumbstick r left":  "thumbstick r left",
        "gamepad thumbstick r right": "thumbstick r right",
        "gamepad thumbstick r up":    "thumbstick r up",
        "gamepad thumbstick r down":  "thumbstick r down",
        
        // Switch GameCube controllers and adapters only
        "gamepad thumbstick l click": "thumbstick l click",
        "gamepad thumbstick r click": "thumbstick r click",
        "gamepad guide":              "home",
        "gamepad misc 1":             "capture",
    },
    
    //Nintendo 64
    "n64": {
        "gamepad face south":         "A",
        "gamepad face east":          "B",
        "gamepad shoulder l":         "L",
        "gamepad shoulder r":         "R",
        "gamepad trigger l":          "Z",
        "gamepad start":              "start",
        "gamepad dpad up":            "dpad up",
        "gamepad dpad down":          "dpad down",
        "gamepad dpad left":          "dpad left",
        "gamepad dpad right":         "dpad right",
        
        "gamepad thumbstick l left":  "thumbstick left",
        "gamepad thumbstick l right": "thumbstick right",
        "gamepad thumbstick l up":    "thumbstick up",
        "gamepad thumbstick l down":  "thumbstick down",
        
        "gamepad thumbstick r left":  "C left",
        "gamepad thumbstick r right": "C right",
        "gamepad thumbstick r up":    "C up",
        "gamepad thumbstick r down":  "C down",
    },
    
    //Sega Saturn
    "saturn": {
        "gamepad face south": "A",
        "gamepad face east":  "B",
        "gamepad face west":  "X",
        "gamepad face north": "Y",
        "gamepad shoulder l": "L",
        "gamepad shoulder r": "Z",
        "gamepad trigger l":  "R",
        "gamepad trigger r":  "C",
        "gamepad select":     "mode",
        "gamepad start":      "start",
        "gamepad dpad up":    "dpad up",
        "gamepad dpad down":  "dpad down",
        "gamepad dpad left":  "dpad left",
        "gamepad dpad right": "dpad right",
    },
    
    //Super Nintendo
    "snes": {
        "gamepad face south": "B",
        "gamepad face east":  "A",
        "gamepad face west":  "Y",
        "gamepad face north": "X",
        "gamepad shoulder l": "L",
        "gamepad shoulder r": "R",
        "gamepad select":     "select",
        "gamepad start":      "start",
        "gamepad dpad up":    "dpad up",
        "gamepad dpad down":  "dpad down",
        "gamepad dpad left":  "dpad left",
        "gamepad dpad right": "dpad right",
    },
    
    #endregion
};