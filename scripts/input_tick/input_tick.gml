function input_tick()
{
    global.__input_frame++;
    
    global.__input_mouse_moved = (point_distance(display_mouse_get_x(), display_mouse_get_y(), global.__input_mouse_x, global.__input_mouse_y) > 2);
    global.__input_mouse_x = display_mouse_get_x();
    global.__input_mouse_y = display_mouse_get_y();
    
	var _g = 0;
	repeat(array_length(global.__input_gamepads))
	{
		var _gamepad = global.__input_gamepads[_g];
		if (is_struct(_gamepad)) _gamepad.tick();
		++_g;
	}
	
    var _p = 0;
    repeat(INPUT_MAX_PLAYERS)
    {
        global.__input_players[_p].tick();
        ++_p;
    }
}

#region Initialisation

__input_trace("Welcome to Input by @jujuadams! This is version ", __INPUT_VERSION, ", ", __INPUT_DATE);

global.__input_frame              = 0;
global.__input_mouse_x            = 0;
global.__input_mouse_y            = 0;
global.__input_mouse_moved        = false;
global.__input_cursor_verb_u      = undefined;
global.__input_cursor_verb_d      = undefined;
global.__input_cursor_verb_l      = undefined;
global.__input_cursor_verb_r      = undefined;
global.__input_cursor_speed       = 0;
global.__input_cursor_using_mouse = true;
global.__input_rebind_last_player = undefined;
global.__input_keyboard_valid     = false;
global.__input_mouse_valid        = false;
global.__input_gamepad_valid      = false;
global.__input_source_names       = ["none", "keyboard and mouse", "gamepad"];
global.__input_players            = array_create(INPUT_MAX_PLAYERS, undefined);
global.__input_default_player     = new __input_class_player();
global.__input_gamepads           = array_create(gamepad_get_device_count(), undefined);

var _p = 0;
repeat(INPUT_MAX_PLAYERS)
{
    global.__input_players[@ _p] = new __input_class_player();
    ++_p;
}

#endregion

#region Classes

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
    rebind_backup     = undefined;
    
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
                var _verb_name = _verb_names[_v];
                var _raw       = 0.0;
                var _value     = 0.0;
                var _analogue  = undefined;
                
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
                                    _value    = 1.0;
                                    _raw      = 1.0;
                                    _analogue = false;
                                }
                            break;
                            
                            case "gamepad button":
                                if (input_gamepad_button_check(gamepad, _binding.value))
                                {
                                    _value    = 1.0;
                                    _raw      = 1.0;
                                    _analogue = false;
                                }
                            break;
                            
                            case "mouse button":
                                if (mouse_check_button(_binding.value))
                                {
                                    _value    = 1.0;
                                    _raw      = 1.0;
                                    _analogue = false;
                                }
                            break;
                            
                            case "mouse wheel up":
                                if (mouse_wheel_up())
                                {
                                    _value    = 1.0;
                                    _raw      = 1.0;
                                    _analogue = false;
                                }
                            break;
                            
                            case "mouse wheel down":
                                if (mouse_wheel_down())
                                {
                                    _value    = 1.0;
                                    _raw      = 1.0;
                                    _analogue = false;
                                }
                            break;
                            
                            case "gamepad axis":
                                var _found_raw = input_gamepad_axis_value(gamepad, _binding.value);
                                var _axis_threshold = axis_threshold_get(_binding.value);
                                
                                if (_binding.axis_negative) _found_raw = -_found_raw;
                                
                                var _found_value = _found_raw;
                                _found_value = (_found_value - _axis_threshold.mini) / (_axis_threshold.maxi - _axis_threshold.mini);
                                _found_value = clamp(_found_value, 0.0, 1.0);
                                
                                if (_found_raw > _raw) _raw = _found_raw;
                                
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
                
                variable_struct_get(verbs, _verb_name).value = _value;
                variable_struct_get(verbs, _verb_name).raw   = _raw;
                if (_analogue != undefined) variable_struct_get(verbs, _verb_name).analogue = _analogue;
                
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
            _source_verb_struct = {};
            variable_struct_set(config, global.__input_source_names[_source], _source_verb_struct);
        }
        
        var _verb_alternate_array = variable_struct_get(_source_verb_struct, _verb);
        if (!is_array(_verb_alternate_array))
        {
            _verb_alternate_array = array_create(INPUT_MAX_ALTERNATE_BINDINGS, undefined);
            variable_struct_set(_source_verb_struct, _verb, _verb_alternate_array);
        }
        
        _verb_alternate_array[@ _alternate] = _binding_struct;
        
        //Set up a verb container on the player separate from the bindings
        if (!is_struct(variable_struct_get(verbs, _verb)))
        {
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
                
                return (input_gamepad_button_check(gamepad, gp_face1)
                    ||  input_gamepad_button_check(gamepad, gp_face2)
                    ||  input_gamepad_button_check(gamepad, gp_face3)
                    ||  input_gamepad_button_check(gamepad, gp_face4)
                    ||  input_gamepad_button_check(gamepad, gp_padu)
                    ||  input_gamepad_button_check(gamepad, gp_padd)
                    ||  input_gamepad_button_check(gamepad, gp_padl)
                    ||  input_gamepad_button_check(gamepad, gp_padr)
                    ||  input_gamepad_button_check(gamepad, gp_shoulderl)
                    ||  input_gamepad_button_check(gamepad, gp_shoulderr)
                    ||  input_gamepad_button_check(gamepad, gp_shoulderlb)
                    ||  input_gamepad_button_check(gamepad, gp_shoulderrb)
                    ||  input_gamepad_button_check(gamepad, gp_start)
                    ||  input_gamepad_button_check(gamepad, gp_select)
                    ||  input_gamepad_button_check(gamepad, gp_stickl)
                    ||  input_gamepad_button_check(gamepad, gp_stickr)
                    ||  (abs(input_gamepad_axis_value(gamepad, gp_axislh)) > axis_threshold_get(gp_axislh))
                    ||  (abs(input_gamepad_axis_value(gamepad, gp_axislv)) > axis_threshold_get(gp_axislv))
                    ||  (abs(input_gamepad_axis_value(gamepad, gp_axisrh)) > axis_threshold_get(gp_axisrh))
                    ||  (abs(input_gamepad_axis_value(gamepad, gp_axisrv)) > axis_threshold_get(gp_axisrv)));
            break;
        }
        
        return false;
    }
}

function __input_class_cursor() constructor
{
    x = 0;
    y = 0;
    
    limit_l = undefined;
    limit_t = undefined;
    limit_r = undefined;
    limit_b = undefined;
    
    limit_x = undefined;
    limit_y = undefined;
    limit_radius = undefined;
    
    tick = function()
    {
        if (global.__input_mouse_valid && (other.source == INPUT_SOURCE.KEYBOARD_AND_MOUSE) && (global.__input_mouse_moved || global.__input_cursor_using_mouse))
        {
            global.__input_cursor_using_mouse = true;
            x = mouse_x;
            y = mouse_y;
        }
        
        if (!global.__input_mouse_moved)
        {
            if ((global.__input_cursor_verb_u != undefined)
            &&  (global.__input_cursor_verb_d != undefined)
            &&  (global.__input_cursor_verb_l != undefined)
            &&  (global.__input_cursor_verb_r != undefined))
            {
                var _struct_u = variable_struct_get(other.verbs, global.__input_cursor_verb_u);
                var _struct_d = variable_struct_get(other.verbs, global.__input_cursor_verb_d);
                var _struct_l = variable_struct_get(other.verbs, global.__input_cursor_verb_l);
                var _struct_r = variable_struct_get(other.verbs, global.__input_cursor_verb_r);
                
                var _dx = (_struct_d.consumed? 0.0 : clamp(_struct_d.raw, 0.0, 1.0)) - (_struct_u.consumed? 0.0 : clamp(_struct_u.raw, 0.0, 1.0));
                var _dy = (_struct_r.consumed? 0.0 : clamp(_struct_r.raw, 0.0, 1.0)) - (_struct_l.consumed? 0.0 : clamp(_struct_l.raw, 0.0, 1.0));
                
                var _d = sqrt(_dx*_dx + _dy*_dy);
                if (_d > 0)
                {
                    global.__input_cursor_using_mouse = false;
                    _d = (global.__input_cursor_speed/_d) * clamp((_d - INPUT_DEFAULT_MIN_THRESHOLD) / (INPUT_DEFAULT_MAX_THRESHOLD - INPUT_DEFAULT_MIN_THRESHOLD), 0.0, 1.0);
                    x += _d*_dx;
                    y += _d*_dy;
                }
            }
        }
    }
    
    limit = function()
    {
        if ((limit_l != undefined)
        &&  (limit_t != undefined)
        &&  (limit_r != undefined)
        &&  (limit_b != undefined))
        {
            x = clamp(x, limit_l, limit_r);
            y = clamp(y, limit_t, limit_b);
        }
        else if ((limit_x != undefined) && (limit_y != undefined) && (limit_radius != undefined))
        {
            var _dx = x - limit_x;
            var _dy = y - limit_y;
            var _d  = sqrt(_dx*_dx + _dy*_dy);
            
            if ((_d > 0) && (_d > limit_radius))
            {
                _d = limit_radius / _d;
                 x = limit_x + _d*_dx;
                 y = limit_y + _d*_dy;
            }
        }
    }
}

/// @param type
/// @param value
/// @param axisNegative
function __input_class_binding() constructor
{
    type          = argument[0];
    value         = (argument_count > 1)? argument[1] : undefined;
    axis_negative = (argument_count > 2)? bool(argument[2]) : undefined;
}

/// @param type
/// @param value
/// @param axisNegative
function __input_class_verb() constructor
{
    consumed = false;
    
    previous_held = false;
    
    press   = false;
    held    = false;
    release = false;
    value   = 0.0;
    raw     = 0.0;
    
    press_time   = -1;
    held_time    = -1;
    release_time = -1;
    
    analogue = false;
}

#endregion

#region Gamepad Class

/// @param index
function __input_class_gamepad(_index) constructor
{
    index             = _index;
    description       = gamepad_get_description(_index);
    guid              = gamepad_get_guid(_index);
    xinput            = undefined;
    mapping_gm_to_raw = {};
    mapping_raw_to_gm = {};
	mapping_array     = [];
    custom_mapping    = true;
	type              = undefined;
	vendor            = undefined;
	product           = undefined;
    
	/// @param GMconstant
    get_held = function(_gm)
    {
        if (!custom_mapping) return gamepad_button_check(index, _gm);
        var _mapping = variable_struct_get(mapping_gm_to_raw, _gm);
        if (_mapping == undefined) return 0.0;
        return _mapping.held;
    }
    
	/// @param GMconstant
    get_pressed = function(_gm)
    {
        if (!custom_mapping) return gamepad_button_check_pressed(index, _gm);
        var _mapping = variable_struct_get(mapping_gm_to_raw, _gm);
        if (_mapping == undefined) return 0.0;
        return _mapping.press;
    }
    
	/// @param GMconstant
    get_released = function(_gm)
    {
        if (!custom_mapping) return gamepad_button_check_released(index, _gm);
        var _mapping = variable_struct_get(mapping_gm_to_raw, _gm);
        if (_mapping == undefined) return 0.0;
        return _mapping.release;
    }
    
	/// @param GMconstant
    get_value = function(_gm)
    {
        if (!custom_mapping) return gamepad_axis_value(index, _gm);
        var _mapping = variable_struct_get(mapping_gm_to_raw, _gm);
        if (_mapping == undefined) return 0.0;
        return _mapping.value;
    }
    
	/// @param GMconstant
	/// @param raw
	/// @param rawType
    set_mapping = function(_gm, _raw, _type)
    {
        if (!custom_mapping)
        {
            __input_trace("Gamepad ", index, " has a custom mapping, clearing GM's internal mapping string");
            gamepad_test_mapping(index, "");
            custom_mapping = true;
        }
        
        var _mapping = {
            gm            : _gm,
            raw           : _raw,
            type          : _type,
            invert        : false,
            negative      : false,
            limit_range   : false,
            hat_direction : undefined,
			
			held_previous : false,
			value         : 0.0,
			held          : false,
			press         : false,
			release       : false,
        };
        
        variable_struct_set(mapping_gm_to_raw, _gm , _mapping);
        variable_struct_set(mapping_raw_to_gm, _raw, _mapping);
		mapping_array[@ array_length(mapping_array)] = _mapping;
        
        return _mapping;
    }
	
	tick = function()
	{
		var _index = index;
		
		var _i = 0;
		repeat(array_length(mapping_array))
		{
			with(mapping_array[_i])
			{
				held_previous = held;
				value         = 0.0;
				held          = false;
				press         = false;
				release       = false;
				
				switch(type)
				{
					case "button": value = gamepad_button_check(_index, raw); break;
					case "axis":   value = gamepad_axis_value(  _index, raw); break;
					case "hat":
						value = gamepad_hat_value(_index, raw);
						value = value & hat_direction;
					break;
				}
				
		        if (negative) value = -value;
		        if (limit_range) value = 0.5 + 0.5*value;
		        if (invert) value = 1 - value;
				
				held = (abs(value) > 0.2);
				
				if (held_previous != held)
				{
					if (held)
					{
						press = true;
					}
					else
					{
						release = true;
					}
				}
			}
			
			++_i;
		}
	}
	
	input_gamepad_get_type(index);
    __input_trace("Gamepad ", index, " discovered: \"", description, "\", type=\"", type, "\" (vendor=", vendor, ", product=", product, ")");
}

#endregion

#region Binding Functions

//These are globally scoped because otherwise they'd get serialised by input_bindings_write()

/// @param source
function __input_binding_duplicate(_source)
{
    with(_source)
    {
        return new __input_class_binding(type, value, axis_negative);
    }
}

/// @param from
/// @param to
function __input_binding_overwrite(_from, _to)
{
    with(_to)
    {
        type          = _from.type;
        value         = _from.value;
        axis_negative = _from.axis_negative;
    }
}

#endregion

#region Utility

/// @param source
/// @param [gamepad]
function __input_source_is_available()
{
    var _source  = argument[0];
    var _gamepad = ((argument_count > 1) && (argument[1] != undefined))? argument[1] : INPUT_NO_GAMEPAD;
    
    switch(_source)
    {
        case INPUT_SOURCE.NONE:
            return true;
        break;
        
        case INPUT_SOURCE.GAMEPAD:
            if (!global.__input_gamepad_valid) return false;
            if (_gamepad == INPUT_NO_GAMEPAD) return true;
            
            var _p = 0;
            repeat(INPUT_MAX_PLAYERS)
            {
                if ((global.__input_players[_p].source == INPUT_SOURCE.GAMEPAD) && (global.__input_players[_p].gamepad == _gamepad)) return false;
                ++_p;
            }
        break;
        
        case INPUT_SOURCE.KEYBOARD_AND_MOUSE:
            if (!global.__input_keyboard_valid && !global.__input_mouse_valid) return false;
            
            var _p = 0;
            repeat(INPUT_MAX_PLAYERS)
            {
                if (global.__input_players[_p].source == INPUT_SOURCE.KEYBOARD_AND_MOUSE) return false;
                ++_p;
            }
        break;
    }
    
    return true;
}

function __input_trace()
{
    var _string = "";
    var _i = 0;
    repeat(argument_count)
    {
        _string += string(argument[_i]);
        ++_i;
    }
    
    show_debug_message("Input: " + _string);
}

function __input_error()
{
    var _string = "";
    var _i = 0;
    repeat(argument_count)
    {
        _string += string(argument[_i]);
        ++_i;
    }
    
    show_error("Input:\n" + _string + "\n ", false);
}

#endregion

#region Internal macros

#macro __INPUT_VERSION "3.0.0.pre000"
#macro __INPUT_DATE    "2020-08-11"

enum INPUT_SOURCE
{
    NONE,
    KEYBOARD_AND_MOUSE,
    GAMEPAD,
    __SIZE
}

#macro INPUT_NO_GAMEPAD  -1

#endregion