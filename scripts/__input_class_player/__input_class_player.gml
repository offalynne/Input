function __input_class_player() constructor
{
    source          = INPUT_SOURCE.NONE;
    gamepad         = INPUT_NO_GAMEPAD;
    sources         = array_create(INPUT_SOURCE.__SIZE, undefined);
    verbs           = {};
    axis_thresholds = {};
    last_input_time = -1;
    cursor          = new __input_class_cursor();
    
    rebind_state      = 0;
    rebind_source     = undefined;
    rebind_gamepad    = undefined;
    rebind_verb       = undefined;
    rebind_alternate  = undefined;
    rebind_this_frame = false;
    rebind_backup_val     = undefined;
    
    config = { axis_thresholds : {} };
    
    /// @param axis
    /// @param min
    /// @param max
    axis_threshold_set = function(_axis, _min, _max)
    {
        var _axis_struct = variable_struct_get(config.axis_thresholds, _axis);
        if (!is_struct(_axis_struct))
        {
            _axis_struct = {};
            variable_struct_set(config.axis_thresholds, _axis, _axis_struct);
        }
        
        _axis_struct.mini = _min
        _axis_struct.maxi = _max;
        return _axis_struct;
    }
    
    /// @param axis
    axis_threshold_get = function(_axis)
    {
        var _struct = variable_struct_get(config.axis_thresholds, _axis);
        if (is_struct(_struct)) return _struct;
        return axis_threshold_set(_axis, INPUT_DEFAULT_MIN_THRESHOLD, INPUT_DEFAULT_MAX_THRESHOLD);
    }
    
    tick = function()
    {
        if (!rebind_this_frame && (rebind_state < 0)) rebind_state = 0;
        rebind_this_frame = false;
        
        var _verb_names = variable_struct_get_names(verbs);
        var _v = 0;
        repeat(array_length(_verb_names))
        {
            with(variable_struct_get(verbs, _verb_names[_v]))
            {
                previous_held = held;
                
                held  = false;
                value = 0.0;
                raw   = 0.0;
            }
            
            ++_v;
        }
        
        tick_source(global.__input_source_names[source]);
        
        var _verb_names = variable_struct_get_names(verbs);
        var _v = 0;
        repeat(array_length(_verb_names))
        {
            with(variable_struct_get(verbs, _verb_names[_v]))
            {
                if (value > 0)
                {
                    held      = true;
                    held_time = INPUT_BUFFERED_REALTIME? current_time : global.__input_frame;
                    
                    other.last_input_time = current_time;
                }
                
                if (previous_held == held)
                {
                    press   = false;
                    release = false;
                }
                else
                {
                    if (held)
                    {
                        consumed   = false;
                        press      = true;
                        release    = false;
                        press_time = INPUT_BUFFERED_REALTIME? current_time : global.__input_frame;
                    }
                    else
                    {
                        press        = false;
                        release      = true;
                        release_time = INPUT_BUFFERED_REALTIME? current_time : global.__input_frame;
                    }
                }
            }
            
            ++_v;
        }
        
        with(cursor)
        {
            tick();
            limit();
        }
    }
    
    tick_source = function(_source)
    {
        var _source_verb_struct = variable_struct_get(config, _source);
        if (is_struct(_source_verb_struct))
        {
            var _verb_names = variable_struct_get_names(_source_verb_struct);
            var _v = 0;
            repeat(array_length(_verb_names))
            {
                var _verb_name    = _verb_names[_v];
                var _raw          = 0.0;
                var _value        = 0.0;
                var _analogue     = undefined;
                var _raw_analogue = undefined;
                
                var _alternate_array = variable_struct_get(_source_verb_struct, _verb_name);
                var _a = 0;
                repeat(array_length(_alternate_array))
                {
                    var _binding = _alternate_array[_a];
                    if (is_struct(_binding))
                    {
                        switch(_binding.type)
                        {
                            case "key":
                                if (keyboard_check(_binding.value))
                                {
                                    _value        = 1.0;
                                    _raw          = 1.0;
                                    _analogue     = false;
                                    _raw_analogue = false;
                                }
                            break;
                            
                            case "gamepad button":
                                if (input_gamepad_check(gamepad, _binding.value))
                                {
                                    _value        = 1.0;
                                    _raw          = 1.0;
                                    _analogue     = false;
                                    _raw_analogue = false;
                                }
                            break;
                            
                            case "mouse button":
                                if (mouse_check_button(_binding.value))
                                {
                                    _value        = 1.0;
                                    _raw          = 1.0;
                                    _analogue     = false;
                                    _raw_analogue = false;
                                }
                            break;
                            
                            case "mouse wheel up":
                                if (mouse_wheel_up())
                                {
                                    _value        = 1.0;
                                    _raw          = 1.0;
                                    _analogue     = false;
                                    _raw_analogue = false;
                                }
                            break;
                            
                            case "mouse wheel down":
                                if (mouse_wheel_down())
                                {
                                    _value        = 1.0;
                                    _raw          = 1.0;
                                    _analogue     = false;
                                    _raw_analogue = false;
                                }
                            break;
                            
                            case "gamepad axis":
                                var _found_raw = input_gamepad_value(gamepad, _binding.value);
                                var _axis_threshold = axis_threshold_get(_binding.value);
                                
                                if (_binding.axis_negative) _found_raw = -_found_raw;
                                
                                var _found_value = _found_raw;
                                _found_value = (_found_value - _axis_threshold.mini) / (_axis_threshold.maxi - _axis_threshold.mini);
                                _found_value = clamp(_found_value, 0.0, 1.0);
                                
                                if (_found_raw > _raw)
                                {
                                    _raw          = _found_raw;
                                    _raw_analogue = true;
                                }
                                
                                if (_found_value > _value)
                                {
                                    _value    = _found_value;
                                    _analogue = true;
                                }
                            break;
                        }
                    }
                    
                    ++_a;
                }
                
                var _verb_struct = variable_struct_get(verbs, _verb_name);
                _verb_struct.value = _value;
                _verb_struct.raw = _raw;
                if (_analogue != undefined) _verb_struct.analogue = _analogue;
                if (_raw_analogue != undefined) _verb_struct.raw_analogue = _raw_analogue;
                
                ++_v;
            }
        }
    }
    
    /// @param source
    /// @param verb
    /// @param alternate
    /// @param bindingStruct
    set_binding = function(_source, _verb, _alternate, _binding_struct)
    {
        if (__INPUT_DEBUG)
        {
            __input_trace("Setting binding, args=", _source, ", ", _verb, ", ", _alternate, ", ", _binding_struct);
            __input_trace("callstack = ", debug_get_callstack());
        }
        
        if ((_source < 0) || (_source >= INPUT_SOURCE.__SIZE))
        {
            __input_error("Invalid source (", _source, ")");
            return undefined;
        }
        
        if (_alternate < 0)
        {
            __input_error("Invalid \"alternate\" argument (", _alternate, ")");
            return undefined;
        }
            
        if (_alternate >= INPUT_MAX_ALTERNATE_BINDINGS)
        {
            __input_error("\"alternate\" argument too large (", _alternate, " vs. ", INPUT_MAX_ALTERNATE_BINDINGS, ")\nIncrease INPUT_MAX_ALTERNATE_BINDINGS for more alternate binding slots");
            return undefined;
        }
        
        var _source_verb_struct = variable_struct_get(config, global.__input_source_names[_source]);
        if (!is_struct(_source_verb_struct))
        {
            if (__INPUT_DEBUG) __input_trace("Source verb struct not found, creating a new one");
            _source_verb_struct = {};
            variable_struct_set(config, global.__input_source_names[_source], _source_verb_struct);
        }
        else
        {
            if (__INPUT_DEBUG) __input_trace("Source verb struct = ", _source_verb_struct);
        }
        
        var _verb_alternate_array = variable_struct_get(_source_verb_struct, _verb);
        if (!is_array(_verb_alternate_array))
        {
            if (__INPUT_DEBUG) __input_trace("Verb alternate array not found, creating a new one");
            _verb_alternate_array = array_create(INPUT_MAX_ALTERNATE_BINDINGS, undefined);
            variable_struct_set(_source_verb_struct, _verb, _verb_alternate_array);
        }
        else
        {
            if (__INPUT_DEBUG) __input_trace("Verb alternate array = ", _verb_alternate_array);
        }
        
        if (__INPUT_DEBUG) __input_trace("Verb alternate array length = ", array_length(_verb_alternate_array));
        
        //FIXME - Workaround for Stadia controller bug maybe? 2020-01-05
        _verb_alternate_array[_alternate] = _binding_struct;
        variable_struct_set(_source_verb_struct, _verb, _verb_alternate_array);
        
        //Set up a verb container on the player separate from the bindings
        if (!is_struct(variable_struct_get(verbs, _verb)))
        {
            if (__INPUT_DEBUG) __input_trace("Verb not found on player, creating a new one");
            variable_struct_set(verbs, _verb, new __input_class_verb());
        }
        
        return _binding_struct;
    }
    
    any_input = function()
    {
        switch(source)
        {
            case INPUT_SOURCE.NONE:
                return false;
            break;
            
            case INPUT_SOURCE.KEYBOARD_AND_MOUSE:
                return (keyboard_check(vk_anykey) || global.__input_mouse_moved || mouse_check_button(mb_any) || mouse_wheel_up() || mouse_wheel_down());
            break;
            
            case INPUT_SOURCE.GAMEPAD:
                if (!gamepad_is_connected(gamepad)) return false;
                
                return (input_gamepad_check(gamepad, gp_face1)
                    ||  input_gamepad_check(gamepad, gp_face2)
                    ||  input_gamepad_check(gamepad, gp_face3)
                    ||  input_gamepad_check(gamepad, gp_face4)
                    ||  input_gamepad_check(gamepad, gp_padu)
                    ||  input_gamepad_check(gamepad, gp_padd)
                    ||  input_gamepad_check(gamepad, gp_padl)
                    ||  input_gamepad_check(gamepad, gp_padr)
                    ||  input_gamepad_check(gamepad, gp_shoulderl)
                    ||  input_gamepad_check(gamepad, gp_shoulderr)
                    ||  input_gamepad_check(gamepad, gp_shoulderlb)
                    ||  input_gamepad_check(gamepad, gp_shoulderrb)
                    ||  input_gamepad_check(gamepad, gp_start)
                    ||  input_gamepad_check(gamepad, gp_select)
                    ||  input_gamepad_check(gamepad, gp_stickl)
                    ||  input_gamepad_check(gamepad, gp_stickr)
                    ||  (abs(input_gamepad_value(gamepad, gp_axislh)) > axis_threshold_get(gp_axislh).mini)
                    ||  (abs(input_gamepad_value(gamepad, gp_axislv)) > axis_threshold_get(gp_axislv).mini)
                    ||  (abs(input_gamepad_value(gamepad, gp_axisrh)) > axis_threshold_get(gp_axisrh).mini)
                    ||  (abs(input_gamepad_value(gamepad, gp_axisrv)) > axis_threshold_get(gp_axisrv).mini));
            break;
        }
        
        return false;
    }
}
