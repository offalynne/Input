/// This function should be called in the scope of a gamepad class
function __input_gamepad_set_type()
{
    __INPUT_GLOBAL_STATIC_LOCAL  //Set static _global
    
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
            var _irregular_guid = (vendor + product == "");
            
            if (xinput == true)
            {
                raw_type = "CommunityLikeXBox";
                guessed_type = true;
            }
            else if (variable_struct_exists(_global.__raw_type_dictionary, vendor + product))
            {
                raw_type = _global.__raw_type_dictionary[$ vendor + product];
                guessed_type = false;
            }
            else
            {
                //Guess the raw type of controller we have based on its description
                guessed_type = true;
                
                if (!__INPUT_SILENT)
                {
                    if (_irregular_guid)
                    {
                        __input_trace("Warning! VID+PID not found. Guessing controller type based on description = \"", description, "\"");
                    }
                    else
                    {
                        __input_trace("Warning! VID+PID \"", vendor + product, "\" not found in raw type database. Guessing controller type based on description = \"", description, "\"");
                    }
                }
                
                var _desc = string_lower(description);
                if (__input_string_contains(_desc, "8bitdo"))
                {
                    raw_type = "Community8BitDo";
                    if (__input_string_contains(_desc, "ultimate", "zero") && !__input_string_contains(_desc, "zero 2"))
                    {
                        raw_type = "CommunityLikeXBox";
                    }
                    else if (__input_string_contains(_desc, " s30", " m30"))
                    {
                        raw_type = "CommunitySaturn";
                    }
                    else if (__input_string_contains(_desc, " p30"))
                    {
                        raw_type = "CommunityPSX";
                    }
                }
                else if (__input_string_contains(_desc, "snes"))
                {
                    raw_type = "CommunitySNES";
                }
                else if (__input_string_contains(_desc, "retroid", "sfc"))
                {
                    raw_type = "CommunitySuperFamicom";
                }
                else if (__input_string_contains(_desc, "saturn"))
                {
                    raw_type = "CommunitySaturn"
                }
                else if (__input_string_contains(_desc, "stadia"))
                {
                    raw_type = "CommunityStadia";
                }
                else if (__input_string_contains(_desc, "luna", "amazon game"))
                {
                    raw_type = "CommunityLuna";
                }
                else if (__input_string_contains(_desc, "ouya"))
                {
                    raw_type = "CommunityOuya";
                }
                else if (__input_string_contains(_desc, "steam"))
                {
                    raw_type = "SteamController";
                }
                else if (__input_string_contains(_desc, "ps5", "dualsense"))
                {
                    raw_type = "PS5Controller";
                }
                else if (__input_string_contains(_desc, "ps4", "dualshock 4", "sony interactive entertainment wireless controller"))
                {
                    raw_type = "CommunityPS4";
                }
                else if (__input_string_contains(_desc, "playstation", "ps1", "ps2", "ps3", "dualshock"))
                {
                    raw_type = "CommunityPSX"; //Catch all remaining PlayStation gamepads as PSX
                }
                else if (__input_string_contains(_desc, "for switch", "for nintendo switch", "switch controller", "switch pro controller", "lic pro controller", "wii"))
                {
                    raw_type = "CommunityLikeSwitch";
                }
                else if (__input_string_contains(_desc, "joy-con (l/r)"))
                {
                    raw_type = "SwitchJoyConPair";
                }
                else if (__input_string_contains(_desc, "joy-con (l)", "left joy-con"))
                {
                    raw_type = "SwitchJoyConLeft";
                }
                else if (__input_string_contains(_desc, "joy-con (r)", "right joy-con"))
                {
                    raw_type = "SwitchJoyConRight";
                }
                else if (__input_string_contains(_desc, "gamecube"))
                {
                    raw_type = "CommunityGameCube";
                }
                else if (__input_string_contains(_desc, "xbox elite", "xbox wireless", "xbox one", "xbox bluetooth"))
                {
                    raw_type = "CommunityXBoxOne";
                }
                else if (__input_string_contains(_desc, "xbox 360", "xbox360", "logitech gamepad f"))
                {
                    raw_type = "CommunityXBox360";
                }
                else if (__input_string_contains(_desc, "xbox"))
                {
                    raw_type = "CommunityLikeXBox";
                }
                else if (__INPUT_ON_IOS || __input_string_contains(_desc, "nimbus", "horipad ultimate", "mfi"))
                {
                    raw_type = "AppleController";
                }
                else
                {
                    raw_type = "Unknown";
                }
            }
            
            #region Unique gamepad type overrides
            
            if ((vendor == "3412") && (product == "adbe") && (button_count == 12) && (axis_count == 6) && (hat_count == 0) && __INPUT_ON_WINDOWS)
            {
                //vJoy for Wii U GCN USB driver on Windows
                if (!__INPUT_SILENT) __input_trace("Overridding controller ", index ," type to GameCube");
                description = "GameCube";
                raw_type = "CommunityGameCube";
                guessed_type = false;                
            }
            else if ((vendor == "0d00") && (product == "0000") && (button_count == 15) && (axis_count == 4) && (hat_count == 0) && __INPUT_ON_WINDOWS)
            {
                //MFi on Windows (bad GUID)
                if (!__INPUT_SILENT) __input_trace("Overriding controller ", index ," type to MFi");
                description = "MFi Extended";
                raw_type = "AppleController";
                guessed_type = false;
            }
            else if ((vendor == "6325") && (product == "7505") && __INPUT_ON_WINDOWS)
            {
                //VID+PID conflicts with a Shanwan ICU most often used for third party PS3 style controllers
                if ((button_count == 17) && (hat_count == 0))
                {
                    //NeoGeo Mini
                    if (!__INPUT_SILENT) __input_trace("Overriding controller ", index ," type to NeoGeo Mini");
                    description = "NeoGeo Mini";
                    raw_type = "CommunityNeoGeoMini";
                    guessed_type = false;
                }
                else if ((button_count == 13) && (hat_count == 1))
                {
                    //Several third party N64 controllers including retro-bit's Tribute 64
                    if (!__INPUT_SILENT) __input_trace("Overriding controller ", index ," type to N64");
                    description = "N64";
                    raw_type = "CommunityN64";
                    guessed_type = false;
                }
            }
            else if (((vendor == "8f0e") && (product == "1330"))                                                                                         //HuiJia gamepad or Mayflash N64
                 &&   (__INPUT_ON_MACOS && (hat_count == 2))                                                                                        //Both slots on one device on Mac
                 ||  ((__INPUT_ON_WINDOWS || __INPUT_ON_LINUX) && (button_count == 25) && (axis_count == 6) && (hat_count == 0)                //Windows and Linux identity
                 &&  ((__input_string_contains(gamepad_get_guid(index + 1), "8f0e") && __input_string_contains(gamepad_get_guid(index + 1), "1330"))     //Port comes in pairs, look ahead
                 ||  ((__input_string_contains(gamepad_get_guid(index - 1), "8f0e") && __input_string_contains(gamepad_get_guid(index - 1), "1330")))))) //Port comes in pairs, look behind
            {
                //MayFlash N64 controller
                if (!__INPUT_SILENT) __input_trace("Overriding controller ", index ," type to N64");
                description = "N64 Adapter";
                raw_type = "CommunityN64";
                guessed_type = false;
            }
            else if (((vendor == "d620") || (product == "10a7")) && (hat_count == 0) && __INPUT_ON_WINDOWS                                              //MagicNS or Mayflash N64 Adapter
                 &&  ((__input_string_contains(gamepad_get_guid(index + 1), "d620") && __input_string_contains(gamepad_get_guid(index + 1), "10a7"))    //Port comes in pairs, look ahead
                 ||  ((__input_string_contains(gamepad_get_guid(index - 1), "d620") && __input_string_contains(gamepad_get_guid(index - 1), "10a7"))))) //Port comes in pairs, look behind
            {
                //MayFlash N64 controller
                if (!__INPUT_SILENT) __input_trace("Overriding controller ", index ," type to N64");
                description = "N64 Adapter";
                raw_type = "CommunityN64";
                guessed_type = false;
            }
            else if ((button_count == 11) && (axis_count == 2) && (hat_count == 0) && __INPUT_ON_LINUX)
            {
                //More kernel module weirdness: these devices behave differently
                //in GameMaker than they do in SDL so we require our own mapping
                if (guid == "050000007e0500000620000001800000")
                {
                    //hid-nintendo Left JoyCon
                    raw_type = "HIDJoyConLeft";
                    guessed_type = false;
                }
                else if (_irregular_guid)
                {
                    //hid-nintendo Right JoyCon
                    raw_type = "HIDJoyConRight";
                    guessed_type = true;
                }
            }
            else if (__input_string_contains(description, "Classic Controller") && (axis_count == 10) && (hat_count == 1) && __INPUT_ON_ANDROID)
            {
                raw_type = "CommunityVCSClassic";
                guessed_type = true;
            }
            else if (_irregular_guid && (axis_count == 1) && (button_count  == 5) && (hat_count == 1) && __INPUT_ON_LINUX)
            {
                //Atari VCS Classic Joystick
                raw_type = "HIDAtariVCSClassic";
                guessed_type = true;
            }
            else if (__INPUT_ON_LINUX)
            {                
                //Linux hid-wiimote module
                //GUID and description do not work correctly for kernel drivers
                //so match a sequential device pattern with specific qualitites
                var _wii_type_match = "Unknown";
                if      ((button_count == 11) && (axis_count == 0) && (hat_count == 0) && (index > 1)) { _wii_type_match = "HIDWiiRemote";     }
                else if ((button_count ==  0) && (axis_count == 3) && (hat_count == 0) && (index > 2)) { _wii_type_match = "HIDWiiMotionPlus"; }
                else if ((button_count ==  2) && (axis_count == 3) && (hat_count == 1) && (index > 2)) { _wii_type_match = "HIDWiiNunchuk";    }
                else if ((button_count == 15) && (axis_count == 0) && (hat_count == 3) && (index > 2)) { _wii_type_match = "HIDWiiClassic";    }
            
                switch(_wii_type_match)
                {
                    case "HIDWiiMotionPlus":
                    case "HIDWiiNunchuk":                    
                    case "HIDWiiClassic":
                        var _g = index;
                        repeat(index)
                        {
                            //Confirm accessory identity by finding Wii Remote device
                            --_g;
                            if (input_gamepad_is_connected(_g))
                            {
                                //MotionPlus, Nunchuk, and Classic Controller
                                //can all chain to a Wii Remote or MotionPlus
                                if ((_global.__gamepads[@ _g].raw_type == "HIDWiiRemote")
                                ||  (_global.__gamepads[@ _g].raw_type == "HIDWiiMotionPlus"))
                                {
                                    if (!__INPUT_SILENT) __input_trace("Overriding controller ", _g ," type to \"", _wii_type_match, "\"");
                                    if (_wii_type_match == "HIDWiiClassic")
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
                    
                    case "HIDWiiRemote":                    
                        var _g = index;
                        repeat(index)
                        {
                            --_g;
                            if (input_gamepad_is_connected(_g)) break;
                        }

                        //Confirm Wii Remote identity by finding component devices
                        if ((_g >= 1)
                        &&  (_global.__gamepads[@ _g].hat_count    == 4)
                        &&  (_global.__gamepads[@ _g].button_count == 0)
                        &&  (_global.__gamepads[@ _g].axis_count   == 0))
                        {
                            //Found IR sensor
                            var _ir_index = _g;
                            repeat(_ir_index + 1)
                            {
                                --_g;
                                if (input_gamepad_is_connected(_g)) break;
                            }
                        
                            if ((_g >= 0)
                            &&  (_global.__gamepads[@ _g].axis_count   == 3)
                            &&  (_global.__gamepads[@ _g].button_count == 0)
                            &&  (_global.__gamepads[@ _g].hat_count    == 0))
                            {
                                //Found IMU                                
                                var _imu_index = _g;
                                if (!__INPUT_SILENT) __input_trace("Overriding controller ", _imu_index ," type to \"HIDWiiRemoteIMU\"");
                                with (_global.__gamepads[@ _imu_index])
                                {
                                    raw_type = "HIDWiiRemoteIMU";
                                    guessed_type = true;
                                    __input_gamepad_set_blacklist();
                                    __input_gamepad_set_mapping();
                                }
                            
                                if (!__INPUT_SILENT) __input_trace("Overriding controller ", _ir_index ," type to \"HIDWiiRemoteIRSensor\"");
                                with (_global.__gamepads[@ _ir_index])
                                {
                                    raw_type = "HIDWiiRemoteIRSensor";
                                    guessed_type = true;
                                    __input_gamepad_set_blacklist();
                                    __input_gamepad_set_mapping();                                  
                                }
                            
                                if (!__INPUT_SILENT) __input_trace("Overriding controller ", index ," type to \"HIDWiiRemote\"");
                                description = "Nintendo Wii Remote";
                                raw_type = "HIDWiiRemote";
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
    if (variable_struct_exists(_global.__simple_type_lookup, raw_type))
    {
        simple_type = _global.__simple_type_lookup[$ raw_type];
    }
    else
    {
        simple_type = INPUT_GAMEPAD_TYPE_UNKNOWN;
        if (!__INPUT_SILENT) __input_trace("Warning! Raw type \"", raw_type, "\" not found in lookup table, setting simple type to \"", simple_type, "\"");
    }
}
