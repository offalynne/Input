/// @param verb
/// @param [playerIndex]
/// @param [alternate]

enum INPUT_REBIND_EVENT
{
    ERROR    = -1,
    WAITING  =  0,
    SUCCESS  =  1,
}

function input_rebind_tick()
{
    var _verb         = argument[0];
    var _player_index = ((argument_count > 1) && (argument[1] != undefined))? argument[1] : 0;
    var _alternate    = ((argument_count > 2) && (argument[2] != undefined))? argument[2] : 0;
    
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
            rebind_state     = 1;
            rebind_source    = source;
            rebind_gamepad   = gamepad;
            rebind_verb      = _verb;
            rebind_alternate = _alternate;
            rebind_backup    = input_binding_get(_verb, source, _player_index, _alternate);
            
            __input_trace("Rebinding started for player ", _player_index, " (source=", rebind_source, ", verb=", rebind_verb, ", alternate=", rebind_alternate, "), backup=", rebind_backup);
        }
        else
        {
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
            
            if (rebind_state == 1)
            {
                if (!any_input())
                {
                    __input_trace("Rebinding for player ", _player_index, " now listening for input");
                    rebind_state = 2;
                }
            }
            else if (rebind_state == 2)
            {
                var _success = false;
                
                switch(source)
                {
                    case INPUT_SOURCE.KEYBOARD_AND_MOUSE:
                        if (keyboard_key > 0)
                        {
                            set_binding(INPUT_SOURCE.KEYBOARD_AND_MOUSE, _verb, _alternate, new __input_class_binding("key", keyboard_key));
                            __input_trace("Rebinding success: Player ", _player_index, " verb=", _verb, " (alternate=", _alternate, ") set to key ", keyboard_key);
                            _success = true;
                        }
                        else if (mouse_button > 0)
                        {
                            set_binding(INPUT_SOURCE.KEYBOARD_AND_MOUSE, _verb, _alternate, new __input_class_binding("mouse button", mouse_button));
                            __input_trace("Rebinding success: Player ", _player_index, " verb=", _verb, " (alternate=", _alternate, ") set to mouse button ", mouse_button);
                            _success = true;
                        }
                        else if (mouse_wheel_up())
                        {
                            set_binding(INPUT_SOURCE.KEYBOARD_AND_MOUSE, _verb, _alternate, new __input_class_binding("mouse wheel up"));
                            __input_trace("Rebinding success: Player ", _player_index, " verb=", _verb, " (alternate=", _alternate, ") set to mouse wheel up");
                            _success = true;
                        }
                        else if (mouse_wheel_down())
                        {
                            set_binding(INPUT_SOURCE.KEYBOARD_AND_MOUSE, _verb, _alternate, new __input_class_binding("mouse wheel down"));
                            __input_trace("Rebinding success: Player ", _player_index, " verb=", _verb, " (alternate=", _alternate, ") set to mouse wheel down");
                            _success = true;
                        }
                    break;
                    
                    case INPUT_SOURCE.GAMEPAD:
                        var _button_array = [gp_face1, gp_face2, gp_face3, gp_face4, 
                                                gp_padu, gp_padd, gp_padl, gp_padr, 
                                                gp_shoulderl, gp_shoulderr, gp_shoulderlb, gp_shoulderrb,
                                                gp_start, gp_select, gp_stickl, gp_stickr];
                        
                        var _axis_array = [gp_axislh, gp_axislv, gp_axisrh, gp_axisrv,
                                           gp_shoulderlb, gp_shoulderrb];
                        
                        var _i = 0;
                        repeat(array_length(_button_array))
                        {
                            if (gamepad_button_check(gamepad, _button_array[_i]))
                            {
                                set_binding(INPUT_SOURCE.GAMEPAD, _verb, _alternate, new __input_class_binding("gamepad button", _button_array[_i]));
                                __input_trace("Rebinding success: Player ", _player_index, " verb=", _verb, " (alternate=", _alternate, ") set to gamepad button ", _button_array[_i]);
                                _success = true;
                            }
                            
                            ++_i;
                        }
                        
                        var _i = 0;
                        repeat(array_length(_axis_array))
                        {
                            var _axis     = _axis_array[_i];
                            var _value    = gamepad_axis_value(gamepad, _axis);
                            var _negative = (_value < 0);
                            
                            if (abs(_value) > input_axis_threshold_get(_axis, _player_index).mini)
                            {
                                set_binding(INPUT_SOURCE.GAMEPAD, _verb, _alternate, new __input_class_binding("gamepad axis", _axis_array[_i], _negative));
                                __input_trace("Rebinding success: Player ", _player_index, " verb=", _verb, " (alternate=", _alternate, ") set to gamepad axis ", _button_array[_i], " (negative=", _negative, ")");
                                _success = true;
                            }
                            
                            ++_i;
                        }
                    break;
                }
                
                if (_success)
                {
                    input_consume(_verb, _player_index);
                    rebind_state = -2;
                    return INPUT_REBIND_EVENT.SUCCESS;
                }
            }
        }
    }
    
    return INPUT_REBIND_EVENT.WAITING;
}