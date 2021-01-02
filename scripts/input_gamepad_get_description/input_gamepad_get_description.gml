/// @param gamepadIndex

function input_gamepad_get_description(_index)
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
        if (description != undefined) return description;
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
                description = gamepad_get_description(index);
                return description;
            break;
            
            case os_ps4:
                description = gamepad_get_description(index);
                return description;
            break;
            
            case os_xboxone:
                description = gamepad_get_description(index);
                return description;
            break;
        }
        
        if (((vendor == "0079") && (product == "0006"))
        ||  ((vendor == "11ff") && (product == "3331")))
        {
            __input_trace("Warning! Gamepad GUID is for a chipset that's used in countless different controllers. There are too many possible remappings. Please remap manually using external software");
            description = gamepad_get_description(index);
            return description;
        }
        else if (xinput)
        {
            description = "XInput";
            return description;
        }
        else if ((os_type == os_macosx) && ((gamepad_get_mapping(index) == "") || (gamepad_get_mapping(index) == "no mapping")))
        {
            __input_trace("Warning! Gamepad already has a native GameMaker remapping");
            description = gamepad_get_description(index);
            return description;
        }
        else if (!INPUT_SDL2_REMAPPING)
        {
            __input_trace("Skipping SDL2 remapping");
            description = gamepad_get_description(index);
            return description;
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
                    
                    var _entry_name = string_copy(_entry, 1, _pos-1);
                    var _entry_1 = string_delete(_entry, 1, _pos);
                    
                    var _gm = variable_struct_get(global.__input_sdl2_look_up_table, _entry_name);
                    if (_gm != undefined)
                    {
                        var _invert   = false;
                        var _negative = false;
						var _positive = false;
                        
                        if (string_char_at(_entry_1, string_length(_entry_1)) == "~")
                        {
                            _entry_1 = string_delete(_entry_1, string_length(_entry_1), 1);
                            _invert = true;
                        }
                        
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
                                _positive = true;
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
                        if (_positive) _mapping.positive = true;
                        if (_raw_type == "h") _mapping.hat_mask = floor(10*real(_entry_1)); //TODO - lol haxx
                        
                        var _is_trigger_axis = (_raw_type == "a") && string_pos("trigger", _entry_name);
                        if (((os_type == os_macosx) && _is_trigger_axis) //MacOS triggers seem to always be from -1 -> +1
                        ||  ((os_type == os_windows) && ((vendor == "4c05") && (product == "cc09")) && _is_trigger_axis)) //PS4 controllers return -1 -> +1 for their triggers on Windows
                        {
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
        }
    }
}