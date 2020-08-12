/// @param gamepadIndex

function input_gamepad_get_type(_index)
{
    if (is_struct(_index))
    {
        var _gamepad = _index;
    }
    else
    {
        var _gamepad = global.__input_gamepads[_index];
    }
    
    if (!is_struct(_gamepad)) return undefined;
    
    with(_gamepad)
    {
        //If we have a cached value, return it
        if (type != undefined) return type;
        //Otherwise, we discover what kind of gamepad this is...
        
        //Unpack the vendor/product IDs from the gamepad's GUID
        if (os_type == os_windows)
        {
            var _result = __input_gamepad_guid_parse(guid, true); //Windows uses an older version of SDL
            vendor  = _result.vendor;
            product = _result.product;
            xinput  = (index < 4);
        }
        else if ((os_type == os_macosx) || (os_type == os_linux) || (os_type == os_ios) || (os_type == os_android))
        {
            var _result = __input_gamepad_guid_parse(guid, false); //Windows uses an older version of SDL
            vendor  = _result.vendor;
            product = _result.product;
            xinput  = undefined;
        }
        else
        {
            vendor  = undefined;
            product = undefined;
            xinput  = undefined;
        }
        
        //If we're on a specific OS, report the gamepad accordingly
        switch(os_type)
        {
            case os_switch:
                type = "Joy-Con";
                return type;
            break;
        
            case os_ps4:
                type = "DualShock 4";
                return type;
            break;
        
            case os_xboxone:
                type = "Xbox One";
                return type;
            break;
        }
        
        if (xinput)
        {
            type = "XInput";
        }
        else
        {
            //TODO - Read SDL bindings
            if ((vendor == "4c05") && (product == "cc09")) //PS4 controller
            {
                type = "DualShock 4";
                
                set_mapping(gp_face1     ,  1, "button");
                set_mapping(gp_face2     ,  2, "button");
                set_mapping(gp_face3     ,  0, "button");
                set_mapping(gp_face4     ,  3, "button");
                set_mapping(gp_shoulderl ,  4, "button");
                set_mapping(gp_shoulderr ,  5, "button");
                //6 = Trigger L
                //7 = Trigger R
                set_mapping(gp_select    ,  8, "button");
                set_mapping(gp_start     ,  9, "button");
                set_mapping(gp_stickl    , 10, "button");
                set_mapping(gp_stickr    , 11, "button");
                //12 = Guide
                //13 = Trackpad Click
                set_mapping(gp_axislh    , 0, "axis");
                set_mapping(gp_axislv    , 1, "axis");
                set_mapping(gp_axisrh    , 2, "axis");
                set_mapping(gp_shoulderlb, 3, "axis").limit_range = true;
                set_mapping(gp_shoulderrb, 4, "axis").limit_range = true;
                set_mapping(gp_axisrv    , 5, "axis");
            }
        }
    }
}