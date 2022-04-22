/// This function should be called in the scope of a gamepad class
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
        
        case os_operagx:
            if (description == "Pro Controller (")
            {
                raw_type = "SwitchProController";
                guessed_type = false;
            }
            else if (description == "Joy-Con L+R (STA")
            {
                raw_type = "SwitchJoyConPair";
                guessed_type = false;
            }
            else if (description == "Wireless Control") //Sony PS4 and PS5 gamepads
            {
                raw_type = "CommunityPS4";
                guessed_type = true;
            }
            else if (description == "Xbox 360 Control") //Any XInput gamepad
            {
                raw_type = "CommunityLikeXBox";
                guessed_type = true;
            }
            
            if (raw_type != undefined) break;
        
        //Opera GX also uses default case
        default:
            if (xinput == true)
            {
                raw_type = "CommunityLikeXBox";
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
                else if (string_count("ouya", _desc))
                {
                    raw_type = "CommunityOuya";
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
                else if ((__INPUT_ON_MOBILE && __INPUT_ON_APPLE) || _desc == "mfi" || string_count("nimbus", _desc) || string_count("horipad ultimate", _desc))
                {
                    raw_type = "AppleController";
                }
                else
                {
                    raw_type = "Unknown";
                }
            }
            
            #region Unique gamepad type overrides

            //MFi on Windows (bad GUID)
            if ((os_type == os_windows) && (vendor == "0d00") && (product == "0000")
            && (gamepad_button_count(index) == 15) && (gamepad_axis_count(index) == 4) && (gamepad_hat_count(index) == 0))
            {
                 __input_trace("Overriding gamepad type to MFi");
                description = "MFi Extended";
                raw_type = "AppleController";
                guessed_type = false;
            }

            //NeoGeo Mini (VID+PID conflict with common third party PS3 controller)
            if ((vendor == "6325") && (product == "7505"))
            {
                if (((os_type == os_windows) && (gamepad_get_description(index) == "USB ") && (gamepad_button_count(index) == 13) && (gamepad_axis_count(index) == 4))
                ||  ((os_type == os_linux  ) && (gamepad_get_description(index) == "GHICCod USB Gamepad"))
                ||  ((os_type == os_macosx ) && (gamepad_get_guid(index) == "03000000632500007505000000020000")))
                {
                    __input_trace("Overriding gamepad type to NeoGeo Mini");
                    description = "NeoGeo Mini";
                    raw_type = "CommunityNeoGeoMini";
                    guessed_type = false;
                }
            }
            
            //Nintendo Switch Online controllers on Linux (Identifiable on device name only)
            if ((os_type == os_linux) && (vendor == "7e05") && (product == "1720"))
            {
                if (string_count("Mega Drive/Genesis", description))
                {
                    __input_trace("Overriding gamepad type to Saturn");
                    raw_type = "CommunitySaturn";
                    guessed_type = false;
                }
            }

            #endregion
            
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
