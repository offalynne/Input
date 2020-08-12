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
        
        if (((vendor == "0079") && (product == "0006"))
        ||  ((vendor == "11ff") && (product == "3331")))
        {
            __input_trace("Warning! Gamepad GUID is for a chipset too many possible remappings. Please remap manually using external software");
        }
        else if (xinput)
        {
            type = "XInput";
        }
        else
        {
            //TODO - Use structs instead?
            var _vp_array = variable_struct_get(global.__input_sdl2_database.by_vendor_product, vendor + product);
            var _os_array = variable_struct_get(global.__input_sdl2_database.by_platform, os_type);
            
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
                    
                    var _gm = variable_struct_get(global.__input_sdl2_look_up_table, _entry_0);
                    if (_gm != undefined)
                    {
                        var _invert   = false;
                        var _negative = false;
						var _positive = false; //TODO - Doesn't do anything yet
                        
                        while(true)
                        {
                            var _char = string_char_at(_entry_1, 1);
                            _entry_1 = string_delete(_entry_1, 1, 1);
                            
                            if (_char == "~")
                            {
                                _invert = true;
                            }
                            else if (_char == "-")
                            {
                                _negative = true;
                            }
                            else if (_char == "+")
                            {
                                _positive = true; //TODO - Nope, still doesn't do anything
                            }
                            else
                            {
                                var _raw_type = _char;
                                break;
                            }
                        }
                        
                        var _input_slot = floor(real(_entry_1));
                        var _mapping = set_mapping(_gm, _input_slot, _raw_type);
                        
                        if (_invert) _mapping.invert = true;
                        if (_negative) _mapping.negative = true;
                        if (_raw_type == "h") _mapping.hat_direction = floor(10*real(_entry_1)); //TODO - lol haxx
                        
                        //Special cases go here:
                        if (((vendor == "4c05") && (product == "cc09")) && (_raw_type == "a") && ((_input_slot == 3) || (_input_slot == 4)))
                        {
                            //PS4 controllers have a weird -1 -> +1 range on their triggers
                            _mapping.limit_range = true;
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