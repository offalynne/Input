/// @param [playerIndex]

enum INPUT_BINDING_SCAN_EVENT
{
    SUCCESS_THIS_FRAME = -1,  //input_binding_scan_tick() has been called twice this frame for this player, and the first execution succeeded
    ERROR_THIS_FRAME   = -2,  //input_binding_scan_tick() has been called twice this frame for this player, and the first execution failed due to an error
    SOURCE_INVALID     = -10, //Player source is not rebindable (is INPUT_SOURCE.NONE)
    SOURCE_CHANGED     = -11, //Player source changed
    GAMEPAD_CHANGED    = -12, //Gamepad index changed
    GAMEPAD_INVALID    = -13, //Player gamepad is invalid (is INPUT_NO_GAMEPAD)
}

function input_binding_scan_tick()
{
    var _player_index = ((argument_count > 0) && (argument[0] != undefined))? argument[0] : 0;
    
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
    
    #endregion
    
    with(global.__input_players[_player_index])
    {
        global.__input_rebind_last_player = self;
        rebind_this_frame = true;
        
        if (rebind_state == -2)
        {
            return INPUT_BINDING_SCAN_EVENT.SUCCESS_THIS_FRAME;
        }
        else if (rebind_state == -1)
        {
            return INPUT_BINDING_SCAN_EVENT.ERROR_THIS_FRAME;
        }
        else if (rebind_state == 0)
        {
            rebind_state   = 1;
            rebind_source  = source;
            rebind_gamepad = gamepad;
            
            __input_trace("Binding scan started for player ", _player_index, " (source=", rebind_source, ", gamepad=", gamepad, ")");
        }
        else
        {
            #region Error checking
            
            if (source == INPUT_SOURCE.NONE)
            {
                __input_trace("Binding scan failed: Source for player ", _player_index, " is INPUT_SOURCE.NONE");
                rebind_state = -1;
                return INPUT_BINDING_SCAN_EVENT.SOURCE_INVALID;
            }
            
            if (rebind_source != source)
            {
                __input_trace("Binding scan failed: Source for player ", _player_index, " changed (from ", rebind_source, " to ", source, ")");
                rebind_state = -1;
                return INPUT_BINDING_SCAN_EVENT.SOURCE_CHANGED;
            }
            
            if ((source == INPUT_SOURCE.GAMEPAD) && (rebind_gamepad != gamepad))
            {
                __input_trace("Binding scan failed: Gamepad for player ", _player_index, " changed (from ", rebind_gamepad, " to ", gamepad, ")");
                rebind_state = -1;
                return INPUT_BINDING_SCAN_EVENT.GAMEPAD_CHANGED;
            }
            
            if ((source == INPUT_SOURCE.GAMEPAD) && (gamepad == INPUT_NO_GAMEPAD))
            {
                __input_trace("Binding scan failed: Gamepad for player ", _player_index, " is INPUT_NO_GAMEPAD");
                rebind_state = -1;
                return INPUT_BINDING_SCAN_EVENT.GAMEPAD_INVALID;
            }
            
            #endregion
            
            if (rebind_state == 1) //Waiting for the player to release all buttons
            {
                if (!any_input())
                {
                    __input_trace("Now scanning for a new binding from player ", _player_index);
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
                    rebind_state = -2;
                    
                    __input_trace("Binding found for player ", _player_index, ": \"", input_binding_get_name(_new_binding), "\"");
                    
                    return _new_binding;
                }
            }
        }
    }
    
    return undefined;
}