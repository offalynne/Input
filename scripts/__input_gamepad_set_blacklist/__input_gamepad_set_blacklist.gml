/// This function should be called in the scope of a gamepad class

function __input_gamepad_set_blacklist()
{
    __INPUT_GLOBAL_STATIC_LOCAL  //Set static _global
    
    //Don't blacklist on preconfigured platforms
    if (!__INPUT_SDL2_SUPPORT) return;
    
    if ((axis_count == 0) && (button_count == 0) && (hat_count == 0))
    {
        //Smoke check invalid devices
        __input_trace("Warning! Controller ", index, " (VID+PID \"", vendor + product, "\") blacklisted: no button or axis");
        blacklisted = true;
        return;
    }
    
    if (__INPUT_ON_WINDOWS)
    {
        if ((vendor == "7e05") && (product == "0920") && (button_count > 21))
        {
            //Switch Pro Controller over USB. Normally does not operate, runs haywire with Steam open
            if (!__INPUT_SILENT) __input_trace("Warning! Controller is blacklisted (Switch Pro Controller over USB)");
            blacklisted = true;
            return;
        }
        
        if (((vendor == "4c05") && (product == "6802"))    //PS3 controller
        && (((axis_count ==  4) && (button_count == 19))   //Bad driver
         || ((axis_count ==  8) && (button_count == 0))))  //DsHidMini gyro
        {
            //Unsupported configuration for PS3 controller
            if (!__INPUT_SILENT) __input_trace("Warning! Controller is blacklisted (Incorrectly configured PS3 controller)");
            blacklisted = true;
            return;
        }
    }
    else if (__INPUT_ON_LINUX)
    {
        if (_global.__on_steam_deck)
        {
            if ((button_count == 144) && (axis_count == 0))
            {
                //Unsupported virtual keyboard device 
                if (!__INPUT_SILENT) __input_trace("Warning! Controller ", index, " is blacklisted (Steam Deck virtual keyboard)");
                blacklisted = true;
                return;
            }

            if (raw_type == "CommunitySteamDeck")
            {
                //Do not blacklist built-in gamepad
                return;
            }
        }
        
        var _joycon_imu_axis_count = 6;
        if ((button_count == 0) && (axis_count == _joycon_imu_axis_count) && (hat_count == 0))
        {
            var _i = 0;
            repeat(_joycon_imu_axis_count)
            {
                //Joy-Con IMU and gyro axes rest above zero
                if (gamepad_axis_value(index, _i) <= 0) break;        
                ++_i;
            }
        
            if (_i == _joycon_imu_axis_count)
            {
                //Unsupported hid-nintendo module motion device
                if (!__INPUT_SILENT) __input_trace("Warning! Controller ", index, " blacklisted (matches Joy-Con motion unit)");
                blacklisted = true;
                return;
            }
        }
        
        if ((raw_type == "HIDWiiMotionPlus") || (raw_type == "HIDWiiRemoteNunchuk")
        ||  (raw_type == "HIDWiiRemoteIMU")  || (raw_type == "HIDWiiRemoteIRSensor"))
        {
            //Unsupported hid-wiimote module motion device 
            if (!__INPUT_SILENT) __input_trace("Warning! Controller ", index, " is blacklisted, type (\"", raw_type, "\")");
            blacklisted = true;
            return;
        }
    }
    
    if ((vendor != "de28") && variable_struct_exists(_global.__ignore_gamepad_types, simple_type))
    {
        //Block device types indicated by Steam Input
        if (!__INPUT_SILENT) __input_trace("Warning! Controller type is blacklisted by Steam Input (\"", simple_type, "\")");
        blacklisted = true;
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
    
    if (is_struct(_os_guid_dict) && variable_struct_exists(_os_guid_dict, guid))
    {
        if (!__INPUT_SILENT) __input_trace("Warning! Controller is blacklisted (found by GUID \"", guid, "\")");
        blacklisted = true;
        return;
    }
    else if (is_struct(_os_vidpid_dict) && variable_struct_exists(_os_vidpid_dict, string(vendor) + string(product)))
    {
        if (!__INPUT_SILENT) __input_trace("Warning! Controller is blacklisted (found by VID+PID \"", vendor, product, "\")");
        blacklisted = true;
        return;
    }
    else if (is_array(_os_desc_array))
    {
        var _description_lower = string_replace_all(string_lower(gamepad_get_description(index)), " ", "");
        var _i = 0;
        repeat(array_length(_os_desc_array))
        {
            if (string_pos(_os_desc_array[_i], _description_lower) > 0)
            {
                if (!__INPUT_SILENT) __input_trace("Warning! Controller is blacklisted (banned substring \"", _os_desc_array[_i], "\" found in description)");
                blacklisted = true;
                return;
            }
            
            ++_i;
        }
    }
}
