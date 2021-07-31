/// This function should be called in the scope of a gamepad class

function __input_gamepad_set_mapping()
{
    //If we're on PlayStation or Xbox, don't remap anything special
    if ((os_type == os_ps4) || (os_type == os_ps5) || (os_type == os_xboxone) || (os_type == os_xboxseriesxs))
    {
        set_mapping(gp_padu,   gp_padu,   "b", "dpup");
        set_mapping(gp_padd,   gp_padd,   "b", "dpdown");
        set_mapping(gp_padl,   gp_padl,   "b", "dpleft");
        set_mapping(gp_padr,   gp_padr,   "b", "dpright");
        set_mapping(gp_start,  gp_start,  "b", "start");
        set_mapping(gp_select, gp_select, "b", "back");
        
        set_mapping(gp_shoulderl,  gp_shoulderl,  "b", "leftshoulder");
        set_mapping(gp_shoulderr,  gp_shoulderr,  "b", "rightshoulder");
        set_mapping(gp_shoulderlb, gp_shoulderlb, "a", "lefttrigger");
        set_mapping(gp_shoulderrb, gp_shoulderrb, "a", "righttrigger");
        
        set_mapping(gp_face1, gp_face1, "b", "a");
        set_mapping(gp_face2, gp_face2, "b", "b");
        set_mapping(gp_face3, gp_face3, "b", "x");
        set_mapping(gp_face4, gp_face4, "b", "y");
        
        set_mapping(gp_axislh, gp_axislh, "a", "leftx");
        set_mapping(gp_axislv, gp_axislv, "a", "lefty");
        set_mapping(gp_axisrh, gp_axisrh, "a", "rightx");
        set_mapping(gp_axisrv, gp_axisrv, "a", "righty");
        set_mapping(gp_stickl, gp_stickl, "b", "leftstick");
        set_mapping(gp_stickr, gp_stickr, "b", "rightstick");
        
        exit;
    }
    
    //Switch requires some extra setup
    if (os_type == os_switch)
    {
        //Disallow dpad input from single Joy-Cons. This happens when moving the thumbstick around in horizontal mode
        if ((raw_type != "SwitchJoyConLeft") && (raw_type != "SwitchJoyConRight"))
        {
            set_mapping(gp_padu, gp_padu, "b", "dpup");
            set_mapping(gp_padd, gp_padd, "b", "dpdown");
            set_mapping(gp_padl, gp_padl, "b", "dpleft");
            set_mapping(gp_padr, gp_padr, "b", "dpright");
        }
        
        if ((raw_type == "SwitchJoyConLeft") || (raw_type == "SwitchJoyConRight"))
        {
            if (INPUT_SWITCH_HORIZONTAL_HOLDTYPE)
            {
                //Single Joy-Cons in horizontal report L/R/ZL/ZR as shoulder buttons even though they rest in the player's palm. No idea why, but we disallow that
                set_mapping(gp_shoulderl,  gp_shoulderl, "b", "leftshoulder");
                set_mapping(gp_shoulderr,  gp_shoulderr, "b", "rightshoulder");
            }
            else
            {
                //SL/SR are still technically active in vertical mode too but that's silly so we ignore them
                set_mapping(gp_shoulderl,  gp_shoulderl,  "b", "leftshoulder");
                set_mapping(gp_shoulderlb, gp_shoulderlb, "b", "lefttrigger");
            }
        }
        else
        {
            //Even in other gamepad modes Switch triggers are digital rather than analogue so we treat those as strict buttons
            set_mapping(gp_shoulderl,  gp_shoulderl,  "b", "leftshoulder");
            set_mapping(gp_shoulderr,  gp_shoulderr,  "b", "rightshoulder");
            set_mapping(gp_shoulderlb, gp_shoulderlb, "b", "lefttrigger");
            set_mapping(gp_shoulderrb, gp_shoulderrb, "b", "righttrigger");
        }
        
        set_mapping(gp_face1, gp_face1, "b", "a");
        set_mapping(gp_face2, gp_face2, "b", "b");
        set_mapping(gp_face3, gp_face3, "b", "x");
        set_mapping(gp_face4, gp_face4, "b", "y");
                                  
        set_mapping(gp_start, gp_start, "b", "start");
        
        //No select button exists for single Joy-Cons so ignore this entirely
        if ((raw_type != "SwitchJoyConLeft") && (raw_type != "SwitchJoyConRight"))
        {
            set_mapping(gp_select, gp_select, "b", "back");
        }
        
        set_mapping(gp_axislh, gp_axislh, "a", "leftx");
        set_mapping(gp_axislv, gp_axislv, "a", "lefty");
        set_mapping(gp_axisrh, gp_axisrh, "a", "rightx");
        set_mapping(gp_axisrv, gp_axisrv, "a", "righty");
        set_mapping(gp_stickl, gp_stickl, "b", "leftstick");
        set_mapping(gp_stickr, gp_stickr, "b", "rightstick");
        
        exit;
    }
    
    if (xinput)
    {
        description = "XInput";
        
        if (os_type == os_windows)
        {
            //Default XInput mapping for Windows. This mapping is super common!
            
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
            
            //Search for leading -/+ in the entry name
            //This basically only ever gets used for Switch joycons
            var _output_negative = false;
            var _output_positive = false;
            
            if (string_char_at(_entry_name, 1) == "-")
            {
                _output_negative = true;
                _entry_name = string_delete(_entry_name, 1, 1);
            }
            else if (string_char_at(_entry_name, 1) == "+")
            {
                _output_positive = true;
                _entry_name = string_delete(_entry_name, 1, 1);
            }
            
            //Find the GameMaker-native constant for this entry name e.g. gp_face1, gp_axislh
            var _gm_constant = variable_struct_get(global.__input_sdl2_look_up_table, _entry_name);
            if (_gm_constant == undefined)
            {
                __input_trace("Warning! Entry name \"", _entry_name, "\" not recognised (full string was \"", _entry, "\")");
            }
            else
            {
                var _input_invert   = false;
                var _input_negative = false;
    			var _input_positive = false;
                
                if (string_char_at(_entry_1, string_length(_entry_1)) == "~")
                {
                    _entry_1 = string_delete(_entry_1, string_length(_entry_1), 1);
                    _input_invert = true;
                }
                
                while(true)
                {
                    var _char = string_char_at(_entry_1, 1);
                    _entry_1 = string_delete(_entry_1, 1, 1);
                    
                    if (_char == "~")
                    {
                        _input_invert = true;
                    }
                    else if (_char == "-")
                    {
                        _input_negative = true;
                    }
                    else if (_char == "+")
                    {
                        _input_positive = true;
                    }
                    else
                    {
                        var _raw_type = _char;
                        break;
                    }
                }
                
                //Determine which input index to scan for
                //We floor this to cope with hats have decimal parts for their mask
                var _input_slot = floor(real(_entry_1));
                
                //If we're in hat mode but we have a sign for the output direction then this is a hat-on-axis mode
                if (_raw_type == "h")
                {
                    if (_output_negative || _output_positive) _raw_type = "h->a";
                }
                
                //Try to find out if this constant has been set already
                var _mapping = mapping_gm_to_raw[$ _gm_constant];
                if (_raw_type == "h->a")
                {
                    //Try to reuse the same mapping struct for hat-on-axis
                    if (_mapping == undefined)
                    {
                        _mapping = set_mapping(_gm_constant, undefined, _raw_type, _entry_name);
                    }
                    
                    if (_output_negative)
                    {
                        _mapping.raw_negative = _input_slot;
                    }
                    else if (_output_positive)
                    {
                        _mapping.raw_positive = _input_slot;
                    }
                }
                else
                {
                    if (_mapping == undefined)
                    {
                        _mapping = set_mapping(_gm_constant, _input_slot, _raw_type, _entry_name);
                    }
                    else 
                    {
                        __input_trace("Warning! Mapping for \"", _entry, "\" is a redefinition of entry name \"", _entry_name, "\"");
                    }
                }
                
                //If necessary, apply modifiers to the mapping input
                if (_input_invert  ) _mapping.invert = true;
                if (_input_negative) _mapping.negative = true;
                if (_input_positive) _mapping.positive = true;
                
                //Now manage the hat masks, including setting up hat-on-axis masks
                if ((_raw_type == "h") || (_raw_type == "h->a"))
                {
                    var _hat_mask = floor(10*real(_entry_1)); //TODO - lol haxx
                    if (_raw_type == "h")
                    {
                        _mapping.hat_mask = _hat_mask;
                    }
                    else if (_raw_type == "h->a")
                    {
                        if (_output_negative)
                        {
                            _mapping.hat_mask_negative = _hat_mask;
                        }
                        else if (_output_positive)
                        {
                            _mapping.hat_mask_positive = _hat_mask;
                        }
                    }
                }
                
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