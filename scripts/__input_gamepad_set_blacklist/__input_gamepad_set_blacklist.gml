/// This function should be called in the scope of a gamepad class

function __input_gamepad_set_blacklist()
{
    //Don't blacklist on preconfigured platforms
    if (!__INPUT_SDL2_SUPPORT) exit;
    
    //Identify gamepad components
    var _axis_count   = gamepad_axis_count(index); 
    var _button_count = gamepad_button_count(index);
    
    if ((_axis_count == 0) && (_button_count == 0))
    {
        //Smoke check invalid devices
        __input_trace("Warning! Controller ", index, " (VID+PID \"", vendor + product, "\" blacklisted: no button or axis");
        blacklisted = true;
        exit;
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
    var _os_filter_dict  = global.__input_blacklist_dictionary[$ _os];
    var _os_guid_dict    = is_struct(_os_filter_dict)? _os_filter_dict[$ "guid"                ] : undefined;
    var _os_desc_array   = is_struct(_os_filter_dict)? _os_filter_dict[$ "description contains"] : undefined;
    
    if (is_struct(_os_guid_dict) && variable_struct_exists(_os_guid_dict, guid))
    {
        __input_trace("Warning! Controller is blacklisted (found by GUID \"", guid, "\")");
        blacklisted = true;
    }
    else if (is_array(_os_desc_array))
    {
        var _description_lower = string_replace_all(string_lower(gamepad_get_description(index)), " ", "");
        var _i = 0;
        repeat(array_length(_os_desc_array))
        {
            if (string_pos(_os_desc_array[_i], _description_lower) > 0)
            {
                __input_trace("Warning! Controller is blacklisted (banned substring \"", _os_desc_array[_i], "\" found in description)");
                blacklisted = true;
                break;
            }
            
            ++_i;
        }
    }
    
    //Block device types indicated by Steam Input
    if ((vendor != "de28") && variable_struct_exists(global.__input_ignore_gamepad_types, simple_type))
    {
        __input_trace("Warning! Controller type is blacklisted by Steam Input (\"", simple_type, "\")");
        blacklisted = true;
    }
    
    //Block devices presenting in bad states
    if (!blacklisted)
    {        
        if (_os == "windows")
        {
            if ((vendor == "7e05") && (product == "0920") && (_button_count == 23))
            {
                //Switch Pro Controller over USB
                //Runs haywire if Steam is open
                blacklisted = true;
            }
            else if ((vendor == "4c05") && (product == "6802"))
            {
                //PS3 Controller
                if (((_axis_count == 4) && (_button_count == 19)) //Bad driver
                ||  ((_axis_count == 8) && (_button_count == 0))) //DsHidMini gyro
                {
                    //Bad mapping
                    blacklisted = true;
                }
            }
        }
        
        if (blacklisted)
        {
            __input_trace("Warning! Controller manually blacklisted.");
        }
    }
}
