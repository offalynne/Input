/// @param gamepadStruct

//On boot, create a lookup table for simple types based on raw types
global.__input_simple_type_lookup = {
    SteamController:   "steam",
    SteamControllerV2: "steam",
    MobileTouch:       "steam",
    
    XBox360Controller: "xbox 360",
    CommunityXBox360:  "xbox 360",
    CommunityLikeXBox: "xbox 360",
    
    XBoxOneController: "xbox one",
    CommunityXBoxOne:  "xbox one",
    
    PS3Controller: "psx",
    CommunityPSX:  "psx",
    
    PS4Controller: "ps4",
    CommunityPS4:  "ps4",
    
    PS5Controller: "ps5",
    
    AppleController: "apple",
    
    SwitchProController: "switch pro",

    SwitchHandheld: "switch handheld", //Attached pair, or Switch Lite

    SwitchJoyConLeft:  "switch joycon left",
    SwitchJoyConRight: "switch joycon right",
    SwitchJoyConPair:  "switch joycon pair",
    
    SwitchInputOnlyController: "switch",
    XInputSwitchController:    "switch",
    CommunityLikeSwitch:       "switch",
    Community8BitDo:           "switch", //Same labels for 8BitDo and Switch controllers
    
    CommunitySaturn: "saturn",
    
    CommunitySNES: "snes",
    
    CommunityGameCube: "gamecube",
    
    CommunityOuya: "ouya",
    
    CommunityStadia: "stadia",
    
    CommunityLuna: "luna",
    
    UnknownNonSteamController: "unknown",
    Unknown: "unknown",
    unknown: "unknown",
}

function __input_gamepad_set_type(_gamepad)
{
    if (!is_struct(_gamepad)) return "unknown";
    
    with(_gamepad)
    {
        //If we're on a specific OS, set the gamepad type accordingly
        switch(os_type)
        {
            case os_switch:
                
                switch(description)
                {
                    case "Joy-Con (L)":
                        raw_type = "SwitchJoyConLeft";
                    break;

                    case "Joy-Con (R)":
                        raw_type = "SwitchJoyConRight";
                    break;
                        
                    case "Joy-Con":
                        raw_type = "SwitchJoyConPair";
                    break;

                    case "Pro Controller":
                        raw_type = "SwitchProController";
                    break;

                    case "Handheld": //JoyCon L+R railed or Lite (Slot 0 only)
                    default:
                        raw_type = "SwitchHandheld";
                    break;
                }
                
                guessed_type = false;
            break;
            
            case os_ps4:
                raw_type = "PS4Controller";
                guessed_type = false;
            break;
            
            case os_xboxone:
                raw_type = "XBoxOneController";
                guessed_type = false;
            break;
            
            default:
                if (xinput == true)
                {
                    //XInput driver standardizes on X360, does not provide GUID
                    raw_type = "XBox360Controller";
                    guessed_type = true;
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
                    __input_trace("Warning! \"", vendor + product, "\" not found in raw type database. Guessing controller type based on \"", description, "\"");
                    
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
                        //Catch all remaining PlayStation gamepads as PSX
                        raw_type = "CommunityPSX";
                    }
                    else if (string_count("for switch", _desc) || string_count("for switch", _desc) || string_count("switch controller", _desc) || string_count("lic pro controller", _desc))
                    {
                        raw_type = "CommunityLikeSwitch";
                    }
                    else if (string_count("gamecube", _desc))
                    {
                        raw_type = "CommunityGameCube";
                    }
                    else if (string_count("xbox one", _desc))
                    {
                        raw_type = "CommunityXBoxOne";
                    }
                    else if (string_count("xbox 360", _desc) || string_count("xbox360", _desc))
                    {
                        raw_type = "CommunityXBox360";
                    }
                    else
                    {
                        raw_type = "Unknown";
                    }
                }
            break;
        }
        
        //Discover the simple type from the raw type
        if (variable_struct_exists(global.__input_raw_type_dictionary, raw_type))
        {
            simple_type = global.__input_raw_type_dictionary[$ raw_type];
        }
        else
        {
            simple_type = "unknown";
            __input_trace("Warning! Raw type \"", raw_type, "\" not found in lookup table, setting simple type to \"", simple_type, "\"");
        }
    }
    
    return simple_type;
}
