/// @param gamepadStruct

function __input_gamepad_set_mapping(_gamepad)
{
    with(_gamepad)
    {
        //If we're on a specific OS, don't remap anything
        if ((os_type == os_switch) || (os_type == os_ps4) || (os_type == os_xboxone)) exit;
        
        if (xinput)
        {
            description = "XInput";
                
            if (os_type == os_windows)
            {
                set_mapping(gp_padu,   0, "b", "dpup");
                set_mapping(gp_padd,   1, "b", "dpdown");
                set_mapping(gp_padl,   2, "b", "dpleft");
                set_mapping(gp_padr,   3, "b", "dpright");
                set_mapping(gp_start,  4, "b", "start");
                set_mapping(gp_select, 5, "b", "back");
                    
                set_mapping(gp_stickl, 6, "b", "leftstick");
                set_mapping(gp_stickr, 7, "b", "rightstick");
                set_mapping(gp_shoulderl, 8, "b", "leftshoulder");
                set_mapping(gp_shoulderr, 9, "b", "rightshoulder");
                    
                set_mapping(gp_face1, 12, "b", "a");
                set_mapping(gp_face2, 13, "b", "b");
                set_mapping(gp_face3, 14, "b", "x");
                set_mapping(gp_face4, 15, "b", "y");
                    
                set_mapping(gp_axislh, 0, "a", "leftx");
                set_mapping(gp_axislv, 1, "a", "lefty").reverse = true;
                set_mapping(gp_axisrh, 2, "a", "rightx");
                set_mapping(gp_axisrv, 3, "a", "righty").reverse = true;
                    
                //This bit is weird but it enables analogue input from triggers so...
                set_mapping(gp_shoulderlb, 4106, "a", "lefttrigger");
                set_mapping(gp_shoulderrb, 4107, "a", "righttrigger");
            }
                
            exit;
        }
        else if (INPUT_SDL2_REMAPPING && is_array(sdl2_definition))
        {
            var _i = 2;
            repeat(array_length(sdl2_definition) - 3)
            {
                var _entry = sdl2_definition[_i];
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
                    var _mapping = set_mapping(_gm, _input_slot, _raw_type, _entry_name);
                            
                    if (_invert) _mapping.invert = true;
                    if (_negative) _mapping.negative = true;
                    if (_positive) _mapping.positive = true;
                    if (_raw_type == "h") _mapping.hat_mask = floor(10*real(_entry_1)); //TODO - lol haxx
                            
                    if (__INPUT_DEBUG) __input_trace(_entry_name, " = ", _raw_type, _entry_1);
                            
                    var _is_trigger_axis = (_raw_type == "a") && string_pos("trigger", _entry_name);
                    if (((os_type == os_macosx) && _is_trigger_axis) //MacOS triggers seem to always be from -1 -> +1
                    ||  ((os_type == os_windows) && ((vendor == "4c05") && ((product == "cc09") || (product == "c405"))) && _is_trigger_axis)) //PS4 controllers return -1 -> +1 for their triggers on Windows
                    {
                        if (__INPUT_DEBUG) __input_trace("  (Limiting axis range)");
                        _mapping.limit_range = true;
                    }
                }
                        
                ++_i;
            }
        }
    }
}