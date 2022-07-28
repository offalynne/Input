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

            if ((os_type == os_windows) && (vendor == "0d00") && (product == "0000") 
            &&  (button_count == 15) && (axis_count == 4) && (hat_count == 0))
            {
                //MFi on Windows (bad GUID)
                 __input_trace("Overriding gamepad type to MFi");
                description = "MFi Extended";
                raw_type = "AppleController";
                guessed_type = false;
            }

            if ((vendor == "6325") && (product == "7505"))
            {
                //NeoGeo Mini (VID+PID conflict with common third party PS3 controller)
                if (((os_type == os_windows) && (gamepad_get_description(index) == "USB ") && (button_count == 13) && (axis_count == 4))
                ||  ((os_type == os_linux  ) && (gamepad_get_description(index) == "GHICCod USB Gamepad"))
                ||  ((os_type == os_macosx ) && (guid == "03000000632500007505000000020000")))
                {
                    __input_trace("Overriding gamepad type to NeoGeo Mini");
                    description = "NeoGeo Mini";
                    raw_type = "CommunityNeoGeoMini";
                    guessed_type = false;
                }
            }
            
            if ((os_type == os_linux) && (vendor == "7e05") && (product == "1720"))
            {
                //Nintendo Switch Online controllers on Linux (Identifiable on device name only)
                if (string_count("Mega Drive/Genesis", description))
                {
                    __input_trace("Overriding gamepad type to Saturn");
                    raw_type = "CommunitySaturn";
                    guessed_type = false;
                }
            }
            
            if (os_type == os_linux)
            {
                //Linux hid-wiimote module
                //GUID and description do not work correctly for kernel drivers
                //so match a sequential device pattern with specific qualitites
                var _wii_type_match = "Unknown";
                if      ((button_count == 11) && (axis_count == 0) && (hat_count == 0) && (index > 1)) { _wii_type_match = "WiiRemote";     }
                else if ((button_count ==  0) && (axis_count == 3) && (hat_count == 0) && (index > 2)) { _wii_type_match = "WiiMotionPlus"; }
                else if ((button_count ==  2) && (axis_count == 3) && (hat_count == 1) && (index > 2)) { _wii_type_match = "WiiNunchuk";    }
                else if ((button_count == 15) && (axis_count == 0) && (hat_count == 3) && (index > 2)) { _wii_type_match = "WiiClassic";    }
                
                switch (_wii_type_match)
                {
                    case "WiiMotionPlus":
                    case "WiiNunchuk":                    
                    case "WiiClassic":
                        var _g = index;
                        repeat(index)
                        {
                            //Confirm accessory identity by finding Wii Remote device
                            --_g;
                            if (input_gamepad_is_connected(_g))
                            {
                                //MotionPlus, Nunchuk, and Classic Controller
                                //can all chain to a Wii Remote or MotionPlus
                                if ((global.__input_gamepads[@ _g].raw_type == "WiiRemote")
                                ||  (global.__input_gamepads[@ _g].raw_type == "WiiMotionPlus"))
                                {
                                    __input_trace("Overriding gamepad type to \"", _wii_type_match, "\"");
                                    if (_wii_type_match == "WiiClassic")
                                    {
                                        description = "Nintendo Wii Classic Controller";
                                    }
                                    raw_type = _wii_type_match;
                                    guessed_type = true;                                    
                                }
                                break;
                            }
                        }
                    break;
                        
                    case "WiiRemote":                    
                        var _g = index;
                        repeat(index)
                        {
                            --_g;
                            if (input_gamepad_is_connected(_g)) break;
                        }

                        //Confirm Wii Remote identity by finding component devices
                        if ((_g >= 1)
                        &&  (global.__input_gamepads[@ _g].hat_count    == 4)
                        &&  (global.__input_gamepads[@ _g].button_count == 0)
                        &&  (global.__input_gamepads[@ _g].axis_count   == 0))
                        {
                            //Found IR sensor
                            var _ir_index = _g;                    
                            repeat(_ir_index + 1)
                            {
                                --_g;
                                if (input_gamepad_is_connected(_g)) break;
                            }
                            
                            if ((_g >= 0)
                            &&  (global.__input_gamepads[@ _g].axis_count   == 3)
                            &&  (global.__input_gamepads[@ _g].button_count == 0)
                            &&  (global.__input_gamepads[@ _g].hat_count    == 0))
                            {
                                //Found IMU                                
                                var _imu_index = _g;
                                __input_trace("Overriding controller ", _imu_index ," type to \"WiiRemoteIMU\"");
                                with (global.__input_gamepads[@ _imu_index])
                                {
                                    raw_type = "WiiRemoteIMU";
                                    guessed_type = true;
                                    __input_gamepad_set_blacklist();                                    
                                }
                                
                                __input_trace("Overriding controller ", _ir_index ," type to \"WiiRemoteIRSensor\"");
                                with (global.__input_gamepads[@ _ir_index])
                                {
                                    raw_type = "WiiRemoteIRSensor";
                                    guessed_type = true;
                                    __input_gamepad_set_blacklist();                                    
                                }
                                
                                __input_trace("Overriding controller ", index ," type to \"WiiRemote\"");
                                description = "Nintendo Wii Remote";
                                raw_type = "WiiRemote";
                                guessed_type = true;
                            }
                        }
                    break;
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
