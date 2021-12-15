/// This function should be called in the scope of a gamepad class

//On boot, create a lookup table for simple types based on raw types
global.__input_simple_type_lookup = {
	
    //Xbox
    XBox360Controller: "xbox 360",
    CommunityXBox360:  "xbox 360",
    SteamController:   "xbox 360", //Steam Controller uses Xb360 iconography
    SteamControllerV2: "xbox 360", //TODO - Revise for Deck if necessary
    MobileTouch:       "xbox 360", //Steam Link touch controls use Xb360 iconography
	
    XBoxOneController: "xbox one",
    CommunityXBoxOne:  "xbox one",
    CommunityLikeXBox: "xbox one",
    AppleController:   "xbox one", // Apple uses XbOne iconography excepting 'View' button, shoulders, triggers
    CommunityStadia:   "xbox one", //Stadia uses XbOne iconography excepting 'View' button, shoulders, triggers
    CommunityLuna:     "xbox one", //  Luna uses XbOne iconography excepting 'View' button
    
    //PlayStation
    PS3Controller: "psx",
    CommunityPSX:  "psx",

    PS4Controller: "ps4",
    CommunityPS4:  "ps4",

    PS5Controller: "ps5",
    
    //Switch
    SwitchHandheld:            "switch", //Attached JoyCon pair or Switch Lite
    SwitchJoyConPair:          "switch",
    SwitchProController:       "switch",
    XInputSwitchController:    "switch",
    SwitchInputOnlyController: "switch",
    CommunityLikeSwitch:       "switch",
    Community8BitDo:           "switch", //8BitDo are Switch gamepads (exceptions are typed appropriatiely)

    SwitchJoyConLeft:  "switch joycon left",
    SwitchJoyConRight: "switch joycon right",
	
    //Legacy
    CommunityGameCube: "gamecube",
    CommunitySaturn:   "saturn",
    CommunitySNES:     "snes",
    CommunityN64:      "n64",

    ////Retired first class types (see "xbox one"), remain identifiable via raw type
    //AppleController: "apple",
    //CommunityStadia: "stadia",
    //CommunityLuna:   "luna",
    //CommunityOuya:   "ouya",
    
    Unknown: "unknown",
    unknown: "unknown",
    UnknownNonSteamController: "unknown"
}

__input_resolve_steam_config();

function __input_resolve_steam_config()
{
    //Prevent Steam Input from aliasing PlayStation and Switch controllers as Xbox type
    var _steam_environ = environment_get_variable("SteamEnv");
    var _steam_configs = environment_get_variable("EnableConfiguratorSupport");

    //Test for Steam environment and valid Steam Input config
    //Check for empty string first per platform-weirdness
    if ((_steam_environ != ""  ) && (_steam_configs != ""   )
    && is_string(_steam_environ) && is_string(_steam_configs)
    && (_steam_environ == "1"  ) && (_steam_configs == string_digits(_steam_configs))
    && (_steam_configs != "65535"))
    {
        //Evaluate Steam Input configuration
        var _bitmask = real(string_digits(_steam_configs));
        if ((_bitmask & 1) != 0)
        {
            //Steam Input is configured to use controller type "PlayStation" (1)
            global.__input_simple_type_lookup[$ "SteamController"] = "unknown";
        }
        else if ((_bitmask & 8) != 0) 
        {
            //Steam Input is configured to use controller type "Switch" (8)
            var _switch_layout = environment_get_variable("SDL_GAMECONTROLLER_USE_BUTTON_LABELS");                    
            if ((_switch_layout != "") && is_string(_switch_layout) && (_switch_layout == "0"))
            {
                //XInput-style label swap for Switch (A/B, X/Y) is toggled off
                global.__input_simple_type_lookup[$ "SteamController"] = "unknown";
            }
        }
    }
}


function __input_gamepad_set_type()
{
    //If we're on a specific OS, set the gamepad type accordingly
    switch(os_type)
    {
        case os_switch:
            switch(description)
            {
                case "Handheld": //JoyCon L+R railed or Lite (Slot 0 only)
                    raw_type = "SwitchHandheld";
                break;
                
                case "Pro Controller":
                    raw_type = "SwitchProController";
                break;
                
                case "Joy-Con (L)":
                    raw_type = "SwitchJoyConLeft";
                break;
                
                case "Joy-Con (R)":
                    raw_type = "SwitchJoyConRight";
                break;
                
                case "Joy-Con":
                default:
                    raw_type = "SwitchJoyConPair";
                break;
            }
            
            guessed_type = false;
        break;
        
        case os_ps4:
            raw_type = "PS4Controller";
            guessed_type = false;
        break;
        
        case os_ps5:
            raw_type = "PS5Controller";
            guessed_type = false;
        break;
        
        case os_xboxone:
        case os_xboxseriesxs:
            raw_type = "XBoxOneController";
            guessed_type = false;
        break;
        
        default:
            if (xinput == true)
            {
                if (os_type == os_uwp)
                {
                    //UWP is used on newer hardware, including XB1 and XBX/S. For compliance, we should show Xbox One icons
                    raw_type = "XBoxOneController";
                    guessed_type = true;
                }
                else
                {
                    //XInput driver standardizes on X360, does not provide GUID
                    raw_type = "XBox360Controller";
                    guessed_type = true;
                }
            }
            else if (variable_struct_exists(global.__input_raw_type_dictionary, vendor + product))
            {
                raw_type = global.__input_raw_type_dictionary[$ vendor + product];
                guessed_type = false;
            }
            else
            {
                //Guess the raw type of controller we have based on its description
                guessed_type = true;
                
                if (vendor + product == "")
                {
                    __input_trace("Warning! VID+PID not found. Guessing controller type based on description = \"", description, "\"");
                }
                else
                {
                    __input_trace("Warning! VID+PID \"", vendor + product, "\" not found in raw type database. Guessing controller type based on description = \"", description, "\"");
                }
                
                var _desc = string_lower(description);
                if (string_count("8bitdo", _desc))
                {
                    raw_type = "Community8BitDo";
                }
                else if (string_count("snes", _desc))
                {
                    raw_type = "CommunitySNES";
                }
                else if (string_count("saturn", _desc))
                {
                    raw_type = "CommunitySaturn"
                }
                else if (string_count("stadia", _desc))
                {
                    raw_type = "CommunityStadia";
                }
                else if (string_count("luna", _desc) || string_count("amazon game", _desc))
                {
                    raw_type = "CommunityLuna";
                }
                else if (string_count("steam", _desc))
                {
                    raw_type = "SteamController";
                }
                else if (string_count("ps5", _desc) || string_count("dualsense", _desc))
                {
                    raw_type = "PS5Controller";
                }
                else if (string_count("ps4", _desc) || string_count("dualshock 4", _desc) || string_count("sony interactive entertainment wireless controller", _desc))
                {
                    raw_type = "CommunityPS4";
                }
                else if (string_count("playstation", _desc) || string_count("ps1", _desc) || string_count("ps2", _desc) || string_count("ps3", _desc) || string_count("dualshock", _desc))
                {
                    raw_type = "CommunityPSX"; //Catch all remaining PlayStation gamepads as PSX
                }
                else if (string_count("for switch", _desc) || string_count("for nintendo switch", _desc) || string_count("switch controller", _desc) || string_count("lic pro controller", _desc))
                {
                    raw_type = "CommunityLikeSwitch";
                }
                else if (string_count("gamecube", _desc))
                {
                    raw_type = "CommunityGameCube";
                }
                else if (string_count("xbox elite", _desc) || string_count("xbox wireless", _desc) || string_count("xbox one", _desc) || string_count("xbox bluetooth", _desc))
                {
                    raw_type = "CommunityXBoxOne";
                }
                else if (string_count("xbox 360", _desc) || string_count("xbox360", _desc))
                {
                    raw_type = "CommunityXBox360";
                }
                else if (string_count("xbox", _desc))
                {
                    raw_type = "CommunityLikeXBox";
                }
                else if (__INPUT_ON_MOBILE && __INPUT_ON_APPLE)
                {
                    raw_type = "AppleController";
                }
                else
                {
                    raw_type = "Unknown";
                }
            }
        break;
    }
    
    //Discover the simple type from the raw type
    if (variable_struct_exists(global.__input_simple_type_lookup, raw_type))
    {
        simple_type = global.__input_simple_type_lookup[$ raw_type];
    }
    else
    {
        simple_type = "unknown";
        __input_trace("Warning! Raw type \"", raw_type, "\" not found in lookup table, setting simple type to \"", simple_type, "\"");
    }
}
