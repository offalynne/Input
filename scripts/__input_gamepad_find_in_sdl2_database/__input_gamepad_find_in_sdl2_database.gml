/// @param gamepadStruct

function __input_gamepad_find_in_sdl2_database(_gamepad)
{
    with(_gamepad)
    {
        //If we're on a specific OS, don't remap anything
        if ((os_type == os_switch) || (os_type == os_ps4) || (os_type == os_xboxone))
        {
            description = gamepad_get_description(index);
            exit;
        }
        
        //Check the global (OS = "all") blacklists to see if this gamepad is banned
        var _os_filter_dict  = global.__input_blacklist_dictionary[$ "all"];
        var _os_vid_pid_dict = is_struct(_os_filter_dict)? _os_filter_dict[$ "vid+pid"             ] : undefined;
        var _os_guid_dict    = is_struct(_os_filter_dict)? _os_filter_dict[$ "guid"                ] : undefined;
        var _os_desc_array   = is_struct(_os_filter_dict)? _os_filter_dict[$ "description contains"] : undefined;
        
        if (is_struct(_os_vid_pid_dict) && variable_struct_exists(_os_vid_pid_dict, vendor + product))
        {
            __input_trace("Warning! Controller is blacklisted (cross-platform, found by VID+PID \"", vendor + product, "\")");
            blacklisted = true;
        }
        
        if (is_struct(_os_guid_dict) && variable_struct_exists(_os_guid_dict, guid))
        {
            __input_trace("Warning! Controller is blacklisted (cross-platform, found by GUID \"", guid, "\")");
            blacklisted = true;
        }
        
        if (is_array(_os_desc_array))
        {
            var _description_lower = string_lower(gamepad_get_description(index));
            var _i = 0;
            repeat(array_length(_os_desc_array))
            {
                if (string_pos(_os_desc_array[_i], _description_lower) > 0)
                {
                    __input_trace("Warning! Controller is blacklisted (cross-platform, banned substring \"", _os_desc_array[_i], "\" found in description)");
                    blacklisted = true;
                    break;
                }
                    
                ++_i;
            }
        }
        
        //Figure out which string to use to find the correct blacklist for the current OS
        var _os = undefined;
        switch(os_type)
        {
            case os_windows: _os = "windows"; break;
            case os_uwp:     _os = "uwp";     break;
            case os_linux:   _os = "linux";   break;
            case os_macosx:  _os = "mac";     break;
            case os_ios:     _os = "ios";     break;
            case os_tvos:    _os = "tvos";    break;
            case os_android: _os = "android"; break;
            
            default:
                __input_error("OS not supported");
            break;
        }
        
        //Check the global (OS = "all") blacklists to see if this gamepad is banned
        var _os_filter_dict  = global.__input_blacklist_dictionary[$ _os];
        var _os_vid_dict     = is_struct(_os_filter_dict)? _os_filter_dict[$ "vid"                 ] : undefined;
        var _os_vid_pid_dict = is_struct(_os_filter_dict)? _os_filter_dict[$ "vid+pid"             ] : undefined;
        var _os_guid_dict    = is_struct(_os_filter_dict)? _os_filter_dict[$ "guid"                ] : undefined;
        var _os_desc_array   = is_struct(_os_filter_dict)? _os_filter_dict[$ "description contains"] : undefined;
        
        if (is_struct(_os_vid_dict) && variable_struct_exists(_os_vid_dict, vendor))
        {
            __input_trace("Warning! Controller is blacklisted (cross-platform, found by VID \"", vendor, "\")");
            blacklisted = true;
        }
        
        if (is_struct(_os_vid_pid_dict) && variable_struct_exists(_os_vid_pid_dict, vendor + product))
        {
            __input_trace("Warning! Controller is blacklisted (cross-platform, found by VID+PID \"", vendor + product, "\")");
            blacklisted = true;
        }
        
        if (is_struct(_os_guid_dict) && variable_struct_exists(_os_guid_dict, guid))
        {
            __input_trace("Warning! Controller is blacklisted (cross-platform, found by GUID \"", guid, "\")");
            blacklisted = true;
        }
        
        if (is_array(_os_desc_array))
        {
            var _description_lower = string_lower(gamepad_get_description(index));
            var _i = 0;
            repeat(array_length(_os_desc_array))
            {
                if (string_pos(_os_desc_array[_i], _description_lower) > 0)
                {
                    __input_trace("Warning! Controller is blacklisted (OS-specific, banned substring \"", _os_desc_array[_i], "\" found in description)");
                    blacklisted = true;
                    break;
                }
                    
                ++_i;
            }
        }
        
        if (blacklisted)
        {
            description = gamepad_get_description(index);
            exit;
        }
        
        if (xinput)
        {
            description = "XInput";
            exit;
        }
        
        if ((os_type == os_macosx) && ((gamepad_get_mapping(index) == "") || (gamepad_get_mapping(index) == "no mapping")))
        {
            __input_trace("Warning! Gamepad already has a native GameMaker remapping");
            description = gamepad_get_description(index);
            exit;
        }
        
        if (!INPUT_SDL2_REMAPPING)
        {
            __input_trace("Skipping SDL2 remapping");
            description = gamepad_get_description(index);
            exit;
        }
        
        //Check to see if our device GUID matches the SDL2 database perfectly somewhere
        var _guid_dict = global.__input_sdl2_database.by_guid;
        if (variable_struct_exists(_guid_dict, guid))
        {
            var _definition = _guid_dict[$ guid];
            sdl2_definition = _definition;
            description     = _definition[1];
            
            exit;
        }
        
        var _definition = undefined;
        
        //Otherwise search through our vendor+product IDs
        var _vp_array = variable_struct_get(global.__input_sdl2_database.by_vendor_product, vendor + product);
        
        if (array_length(_vp_array) > 0) //Get the first binding for this vendor+product and OS
        {
            var _definition = _vp_array[0];
        }
                
        if (is_array(_definition))
        {
            sdl2_definition = _definition;
            description     = _definition[1];
        }
        else
        {
            __input_trace("Warning! No SDL defintion found for ", guid, " (vendor=", vendor, ", product=", product, ")");
            description = "Unknown";
        }
    }
}
