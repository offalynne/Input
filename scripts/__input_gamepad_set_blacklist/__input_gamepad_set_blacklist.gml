// Feather disable all
/// This function should be called in the scope of a gamepad class

function __input_gamepad_set_blacklist()
{
    __INPUT_GLOBAL_STATIC_LOCAL  //Set static _global
    
    //Don't blacklist on preconfigured platforms
    if (!__INPUT_SDL2_SUPPORT) return;

    //Don't blacklist devices being handled by SDL's HID drivers in GMRT
    if ((__vendor != "") && (__product != "") && (string_copy(__guid, 29, 2) == "68")) return;

    //Smoke check invalid devices
    if ((__axis_count == 0) && (__button_count == 0) && (__hat_count == 0))
    {
        __input_trace("Warning! Controller ", __index, " (VID+PID \"", __vendor + __product, "\") __blacklisted: no button or axis");
        __blacklisted = true;
        return;
    }

    //Filter non-gamepad joystick devices
    if ((!INPUT_SDL2_ALLOW_NONGAMEPAD_JOYSTICKS)
    &&  (__input_string_contains(__raw_type, "Wheel", "Flightstick", "Throttle", "Guitar", "Drumkit", "Dancepad", "Skateboard")))
    {
        if (!__INPUT_SILENT) __input_trace("Warning! Device ", __index, " is blacklisted (Not a gamepad)");
        __blacklisted = true;
        return;
    }
    
    var _description_lower = string_replace_all(string_lower(gamepad_get_description(__index)), " ", "");
    
    switch(os_type)
    {
        case os_windows:
            if ((__vendor == "7e05") && (__product == "0920") && (__button_count > 21))
            {
                //Switch Pro Controller over USB. Normally does not operate, runs haywire with Steam open
                if (!__INPUT_SILENT) __input_trace("Warning! Controller ", __index, " is blacklisted (Switch Pro Controller over USB)");
                __blacklisted = true;
                return;
            }
        
            if (((__vendor == "4c05") && (__product == "6802"))  //PS3 controller
            && (((__axis_count ==  4) && (__button_count == 19))   //Bad driver
             || ((__axis_count ==  8) && (__button_count == 0))))  //DsHidMini gyro
            {
                //Unsupported configuration for PS3 controller
                if (!__INPUT_SILENT) __input_trace("Warning! Controller ", __index, " is blacklisted (Incorrectly configured PS3 controller)");
                __blacklisted = true;
                return;
            }
        break;
        
        case os_linux:
            if (_global.__on_steam_deck)
            {
                if ((__button_count == 144) && (__axis_count == 0))
                {
                    //Unsupported virtual keyboard device 
                    if (!__INPUT_SILENT) __input_trace("Warning! Controller ", __index, " is blacklisted (Steam Deck virtual keyboard)");
                    __blacklisted = true;
                    return;
                }

                if (__raw_type == "CommunitySteamDeck")
                {
                    //Do not blacklist built-in gamepad
                    return;
                }
            }
        
            var _joycon_imu_axis_count = 6;
            if ((__button_count == 0) && (__axis_count == _joycon_imu_axis_count) && (__hat_count == 0))
            {
                var _i = 0;
                repeat(_joycon_imu_axis_count)
                {
                    //Joy-Con IMU and gyro axes rest above zero
                    if (gamepad_axis_value(__index, _i) <= 0) break;        
                    ++_i;
                }
        
                if (_i == _joycon_imu_axis_count)
                {
                    //Unsupported hid-nintendo module motion device
                    if (!__INPUT_SILENT) __input_trace("Warning! Controller ", __index, " __blacklisted (matches Joy-Con motion unit)");
                    __blacklisted = true;
                    return;
                }
            }
        
            if ((__raw_type == "HIDWiiMotionPlus") || (__raw_type == "HIDWiiRemoteNunchuk")
            ||  (__raw_type == "HIDWiiRemoteIMU")  || (__raw_type == "HIDWiiRemoteIRSensor"))
            {
                //Unsupported hid-wiimote module motion device 
                if (!__INPUT_SILENT) __input_trace("Warning! Controller ", __index, " is blacklisted, type (\"", __raw_type, "\")");
                __blacklisted = true;
                return;
            }
        break;
        
        case os_android:
            if (__input_string_contains(_description_lower, "keyboard", "mouse") 
            && !__input_string_contains(_description_lower, "joystick", "pg-9167", "harmonix"))
            {
                //Misidentified keyboard or mouse on Android
                if (!__INPUT_SILENT) __input_trace("Warning! Controller ", __index, " is blacklisted, type (matches mouse or keyboard)");
                __blacklisted = true;
                return;
            }
        break;
    }

    
    if ((__vendor != "de28") && variable_struct_exists(_global.__ignore_gamepad_types, __simple_type))
    {
        //Block device types indicated by Steam Input
        if (!__INPUT_SILENT) __input_trace("Warning! Controller type is blacklisted by Steam Input (\"", __simple_type, "\")");
        __blacklisted = true;
        return;
    }
    
    //Figure out which string to use to find the correct blacklist for the current OS
    var _os = undefined;
    switch(os_type)
    {
        case os_windows: _os = "windows"; break;
        case os_linux:   _os = "linux";   break;
        case os_macosx:  _os = "macos";   break;
        case os_android: _os = "android"; break;
        
        default:
            __input_error("OS not supported");
        break;
    }
    
    //Check the platform blacklists to see if this gamepad is banned
    var _os_filter_dict  = _global.__blacklist_dictionary[$ _os];
    var _os_guid_dict    = is_struct(_os_filter_dict)? _os_filter_dict[$ "guid"                ] : undefined;
    var _os_vidpid_dict  = is_struct(_os_filter_dict)? _os_filter_dict[$ "vid+pid"             ] : undefined;
    var _os_desc_array   = is_struct(_os_filter_dict)? _os_filter_dict[$ "description contains"] : undefined;
    
    if (is_struct(_os_guid_dict) && variable_struct_exists(_os_guid_dict, __guid))
    {
        if (!__INPUT_SILENT) __input_trace("Warning! Controller is blacklisted (found by GUID \"", __guid, "\")");
        __blacklisted = true;
        return;
    }
    else if (is_struct(_os_vidpid_dict) && variable_struct_exists(_os_vidpid_dict, string(__vendor) + string(__product)))
    {
        if (!__INPUT_SILENT) __input_trace("Warning! Controller is blacklisted (found by VID+PID \"", __vendor, __product, "\")");
        __blacklisted = true;
        return;
    }
    else if (is_array(_os_desc_array))
    {
        var _i = 0;
        repeat(array_length(_os_desc_array))
        {
            if (string_pos(_os_desc_array[_i], _description_lower) > 0)
            {
                if (!__INPUT_SILENT) __input_trace("Warning! Controller is blacklisted (banned substring \"", _os_desc_array[_i], "\" found in description)");
                __blacklisted = true;
                return;
            }
            
            ++_i;
        }
    }
}
