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
            vendor  = "";
            product = "";
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
			//TODO - Use structs instead?
            var _vp_array = variable_struct_get(global.__input_gamepad_database.by_vendor_product, vendor + product);
            var _os_array = variable_struct_get(global.__input_gamepad_database.by_platform, os_type);
            
            var _result_array = [];
            
            var _v = 0;
            repeat(array_length(_vp_array))
            {
                var _definition = _vp_array[_v];
                
                var _o = 0;
                repeat(array_length(_os_array))
                {
                    if (_os_array[_o] == _definition)
                    {
                        _result_array[@ array_length(_result_array)] = _definition;
                        break;
                    }
                    
                    ++_o;
                }
                
                ++_v;
            }
            
            var _definition = undefined;
            if (array_length(_result_array) > 0) //Get the first binding for this vendor+product and OS
            {
                var _definition = _result_array[0];
            }
            else if (array_length(_vp_array) > 0) //If that fails, try using the binding for this gamepad from any OS
            {
                var _definition = _vp_array[0];
            }
            
            if (is_array(_definition))
            {
                description = _definition[1];
				
				var _i = 2;
				repeat(array_length(_definition) - 3)
				{
					var _entry = _definition[_i];
					var _pos = string_pos(":", _entry);
					
					var _entry_0 = string_copy(_entry, 1, _pos-1);
					var _entry_1 = string_delete(_entry, 1, _pos);
					
					var _gm = undefined;
					switch(_entry_0) //TODO - Use a struct instead?
					{
						case "a":             _gm = gp_face1;      break;
						case "b":             _gm = gp_face2;      break;
						case "x":             _gm = gp_face3;      break;
						case "y":             _gm = gp_face4;      break;
						case "dpup":          _gm = gp_padu;       break;
						case "dpdown":        _gm = gp_padd;       break;
						case "dpleft":        _gm = gp_padl;       break;
						case "dpright":       _gm = gp_padr;       break;
						case "leftx":         _gm = gp_axislh;     break;
						case "lefty":         _gm = gp_axislv;     break;
						case "rightx":        _gm = gp_axisrh;     break;
						case "righty":        _gm = gp_axisrv;     break;
						case "leftshoulder":  _gm = gp_shoulderl;  break;
						case "rightshoulder": _gm = gp_shoulderr;  break;
						case "lefttrigger":   _gm = gp_shoulderlb; break;
						case "righttrigger":  _gm = gp_shoulderrb; break;
						case "back":          _gm = gp_select;     break; //TODO - Do we want to support "guide" as well?
						case "start":         _gm = gp_start;      break;
						case "leftstick":     _gm = gp_stickl;     break;
						case "rightstick":    _gm = gp_stickr;     break;
					}
					
					if (_gm != undefined)
					{
						var _raw_type = string_char_at(_entry_1, 1);
						_entry_1 = string_delete(_entry_1, 1, 1);
						
						//TODO - haha wow I am lazy
						if (_raw_type == "h")
						{
							set_mapping(_gm, floor(real(_entry_1)), _raw_type).hat_direction = floor(10*real(_entry_1));
						}
						else
						{
							set_mapping(_gm, real(_entry_1), _raw_type);
						}
					}
					
					++_i;
				}
            }
            else
            {
                __input_trace("Warning! No SDL defintion found for vendor=", vendor, ", product=", product);
                description = "Unknown";
            }
            
            type = description;
        }
    }
}