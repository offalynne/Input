/// @param verb
/// @param [playerIndex]
/// @param [alternate]

enum INPUT_REBIND_EVENT
{
    ERROR    = -1,
    WAITING  =  0,
    SUCCESS  =  1,
}

function input_rebind_tick_legacy()
{
    var _verb         = argument[0];
    var _player_index = ((argument_count > 1) && (argument[1] != undefined))? argument[1] : 0;
    var _alternate    = ((argument_count > 2) && (argument[2] != undefined))? argument[2] : 0;
    
    #region Check input arguments
    
    if (_player_index < 0)
    {
        __input_error("Invalid player index provided (", _player_index, ")");
        return undefined;
    }
    
    if (_player_index >= INPUT_MAX_PLAYERS)
    {
        __input_error("Player index too large (", _player_index, " vs. ", INPUT_MAX_PLAYERS, ")\nIncrease INPUT_MAX_PLAYERS to support more players");
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
    
    #endregion
    
    with(global.__input_players[_player_index])
    {
        global.__input_rebind_last_player = self;
        rebind_this_frame = true;
        
        if (rebind_state == -2)
        {
            return INPUT_REBIND_EVENT.SUCCESS;
        }
        else if (rebind_state == -1)
        {
            return INPUT_REBIND_EVENT.ERROR;
        }
        else if (rebind_state == 0)
        {
            rebind_state                = 1;
            rebind_source               = source;
            rebind_gamepad              = gamepad;
            rebind_verb                 = _verb;
            rebind_alternate            = _alternate;
            rebind_backup_val           = input_binding_get(_verb, source, _player_index, _alternate);
            rebind_backup_collision_ref = undefined;
            rebind_backup_collision_val = undefined;
            
            __input_trace("Rebinding started for player ", _player_index, " (source=", rebind_source, ", verb=", rebind_verb, ", alternate=", rebind_alternate, "), backup=", rebind_backup_val);
        }
        else
        {
            #region Error checking
            
            if (source == INPUT_SOURCE.NONE)
            {
                __input_trace("Rebinding failed: Source for player ", _player_index, " is INPUT_SOURCE.NONE");
                rebind_state = -1;
                return INPUT_REBIND_EVENT.ERROR;
            }
            
            if (rebind_verb != _verb)
            {
                __input_trace("Rebinding failed: Target verb for player ", _player_index, " changed (from ", rebind_verb, " to ", _verb, ")");
                rebind_state = -1;
                return INPUT_REBIND_EVENT.ERROR;
            }
            
            if (rebind_alternate != _alternate)
            {
                __input_trace("Rebinding failed: Target alternate for player ", _player_index, " changed (from ", rebind_alternate, " to ", _alternate, ")");
                rebind_state = -1;
                return INPUT_REBIND_EVENT.ERROR;
            }
            
            if (rebind_source != source)
            {
                __input_trace("Rebinding failed: Source for player ", _player_index, " changed (from ", rebind_source, " to ", source, ")");
                rebind_state = -1;
                return INPUT_REBIND_EVENT.ERROR;
            }
            
            if ((source == INPUT_SOURCE.GAMEPAD) && (rebind_gamepad != gamepad))
            {
                __input_trace("Rebinding failed: Gamepad for player ", _player_index, " changed (from ", rebind_gamepad, " to ", gamepad, ")");
                rebind_state = -1;
                return INPUT_REBIND_EVENT.ERROR;
            }
            
            if ((source == INPUT_SOURCE.GAMEPAD) && (gamepad == INPUT_NO_GAMEPAD))
            {
                __input_trace("Rebinding failed: Gamepad for player ", _player_index, " is INPUT_NO_GAMEPAD");
                rebind_state = -1;
                return INPUT_REBIND_EVENT.ERROR;
            }
            
            #endregion
            
            if (rebind_state == 1) //Waiting for the player to release all buttons
            {
                if (!any_input())
                {
                    __input_trace("Rebinding for player ", _player_index, " now listening for input");
                    rebind_state = 2;
                }
            }
            else if (rebind_state == 2) //Now grab the first button pressed
            {
                var _new_binding = undefined;
                
                #region Listeners
                
                switch(source)
                {
                    case INPUT_SOURCE.KEYBOARD_AND_MOUSE:
                        if (keyboard_key > 0)
                        {
                            _new_binding = new __input_class_binding("key", keyboard_key);
                        }
                        else if (mouse_button > 0)
                        {
                            _new_binding = new __input_class_binding("mouse button", mouse_button);
                        }
                        else if (mouse_wheel_up())
                        {
                            _new_binding = new __input_class_binding("mouse wheel up");
                        }
                        else if (mouse_wheel_down())
                        {
                            _new_binding = new __input_class_binding("mouse wheel down");
                        }
                    break;
                    
                    case INPUT_SOURCE.GAMEPAD:
                        var _check_array = [gp_face1, gp_face2, gp_face3, gp_face4, 
                                            gp_padu, gp_padd, gp_padl, gp_padr, 
                                            gp_shoulderl, gp_shoulderr, gp_shoulderlb, gp_shoulderrb,
                                            gp_start, gp_select, gp_stickl, gp_stickr,
                                            gp_axislh, gp_axislv, gp_axisrh, gp_axisrv];
                        
                        if (INPUT_SDL2_ALLOW_GUIDE) array_push(_check_array, gp_guide);
                        if (INPUT_SDL2_ALLOW_MISC1) array_push(_check_array, gp_misc1);
                        
                        var _i = 0;
                        repeat(array_length(_check_array))
                        {
                            var _check = _check_array[_i];
                            if (input_gamepad_is_axis(gamepad, _check))
                            {
                                var _value = input_gamepad_value(gamepad, _check);
                                if (abs(_value) > input_axis_threshold_get(_check, _player_index).mini)
                                {
                                    _new_binding = new __input_class_binding("gamepad axis", _check, (_value < 0));
                                }
                            }
                            else
                            {
                                if (input_gamepad_check(gamepad, _check))
                                {
                                    _new_binding = new __input_class_binding("gamepad button", _check);
                                }
                            }
                            
                            ++_i;
                        }
                    break;
                }
                
                #endregion
                
                if (is_struct(_new_binding))
                {
                    #region Check for any binding collisions
                    
                    var _found_count = 0;
                    
                    var _source_name = global.__input_source_names[source];
                    var _source_verb_struct = variable_struct_get(config, _source_name);
                    if (is_struct(_source_verb_struct))
                    {
                        var _verb_names = variable_struct_get_names(_source_verb_struct);
                        var _v = 0;
                        repeat(array_length(_verb_names))
                        {
                            var _verb = _verb_names[_v];
                            
                            var _alternate_array = variable_struct_get(_source_verb_struct, _verb);
                            var _a = 0;
                            repeat(array_length(_alternate_array))
                            {
                                var _binding = _alternate_array[_a];
                                if (is_struct(_binding))
                                {
                                    if ((_binding.type == _new_binding.type)
                                    &&  (_binding.value == _new_binding.value)
                                    &&  (_binding.axis_negative == _new_binding.axis_negative))
                                    {
                                        _found_count++;
                                        if (_found_count == 1)
                                        {
                                            rebind_backup_collision_ref = _binding;
                                            rebind_backup_collision_val = __input_binding_overwrite(rebind_backup_collision_ref, {});
                                            
                                            __input_binding_overwrite(rebind_backup_val, rebind_backup_collision_ref);
                                            __input_trace("Rebinding collision: Player ", _player_index, " verb=", _verb, " (alternate=", _a, ") set to ", rebind_backup_val);
                                        }
                                        else
                                        {
                                            __input_error("Duplicate bindings found, please check your bindings");
                                        }
                                    }
                                }
                                
                                ++_a;
                            }
                            
                            ++_v;
                        }
                    }
                    
                    #endregion
                    
                    if (__INPUT_DEBUG) __input_trace("Setting rebinding based on player input");
                    set_binding(source, rebind_verb, rebind_alternate, _new_binding);
                    __input_trace("Rebinding success: Player ", _player_index, " verb=", rebind_verb, " (alternate=", rebind_alternate, ") set to ", _new_binding);
                    
                    input_consume(rebind_verb, _player_index);
                    
                    rebind_state = -2;
                    return INPUT_REBIND_EVENT.SUCCESS;
                }
            }
        }
    }
    
    return INPUT_REBIND_EVENT.WAITING;
}

function input_rebind_tick()
{
    var _verb         = argument[0];
    var _player_index = ((argument_count > 1) && (argument[1] != undefined))? argument[1] : 0;
    var _alternate    = ((argument_count > 2) && (argument[2] != undefined))? argument[2] : 0;
    
    __input_error("input_rebind_tick() has been deprecated, please use input_rebind_tick_legacy() instead\nThis feature will be replaced in a future update");
    
    input_rebind_tick_legacy(_verb, _player_index, _alternate);
}