/// @param minPlayers
/// @param maxPlayers
/// @param leaveVerb

function input_assignment_tick(_min_players, _max_players, _leave_verb)
{
    if (_max_players < 1)
    {
        __input_error("Invalid maximum player count provided (", _max_players, ")");
        return undefined;
    }
    
    if (_max_players > INPUT_MAX_PLAYERS)
    {
        __input_error("Maximum player count too large (", _max_players, " vs. ", INPUT_MAX_PLAYERS, ")\nIncrease INPUT_MAX_PLAYERS to support more players");
        return undefined;
    }
    
    if (_min_players < 1)
    {
        __input_error("Invalid minimum player count provided (", _min_players, ")");
        return undefined;
    }
    
    if (_min_players > INPUT_MAX_PLAYERS)
    {
        __input_error("Minimum player count larger than maximum (", _min_players, " vs. ", _max_players, ")");
        return undefined;
    }
    
    var _abort = false;
    
    //Drop players down into empty spaces
    do
    {
        var _fail = false;
        var _p = INPUT_MAX_PLAYERS-1;
        repeat(INPUT_MAX_PLAYERS-1)
        {
            if (input_player_connected(_p) && !input_player_connected(_p-1))
            {
                __input_trace("Assignment: Moving player ", _p, " (connected) to ", _p-1, " (disconnected)");
                
                _fail = true;
                
                var _temp = global.__input_players[_p-1];
                global.__input_players[_p-1] = global.__input_players[_p];
                global.__input_players[_p] = _temp;
            }
            
            --_p;
        }
    }
    until (!_fail);
    
    //Disconnect all extraneous players
    var _p = _max_players;
    repeat(INPUT_MAX_PLAYERS - _max_players)
    {
        input_player_source_set(INPUT_SOURCE.NONE, _p);
        ++_p;
    }
    
    //Scan for input for the lowest index slot
    var _p = 0;
    repeat(_max_players)
    {
        if (!input_player_connected(_p))
        {
            var _new_device = __input_assignment_tick_input(_p);
            if (_new_device.source != INPUT_SOURCE.NONE)
            {
                input_player_source_set(_new_device.source, _p);
                if (_new_device.source == INPUT_SOURCE.GAMEPAD) input_player_gamepad_set(_new_device.gamepad, _p);
                
                __input_trace("Assignment: Player ", _p, " joined");
                
                global.__input_players[_p].tick();
                
                if (input_check_pressed(_leave_verb) && (input_players_connected() < _min_players) && (_min_players > 1))
                {
                    __input_trace("Assignment: Player ", _p, " aborted");
                    _abort = true;
                }
                
                //Make sure this doesn't trigger again
                input_consume(_leave_verb, _p);
            }
        }
        
        ++_p;
    }
    
    //Allow players to leave the game
    var _p = 0;
    repeat(_max_players)
    {
        if (input_check_pressed(_leave_verb, _p))
        {
            __input_trace("Assignment: Player ", _p, " left");
            input_player_source_set(INPUT_SOURCE.NONE, _p);
        }
        
        ++_p;
    }
    
    return _abort;
}

/// @param playerIndex
function __input_assignment_tick_input(_player_index)
{
    if (global.__input_keyboard_valid && __input_source_is_available(INPUT_SOURCE.KEYBOARD_AND_MOUSE) && keyboard_check_pressed(vk_anykey))
    {
        return { source : INPUT_SOURCE.KEYBOARD_AND_MOUSE, gamepad : undefined };
    }
    else if (global.__input_mouse_valid && __input_source_is_available(INPUT_SOURCE.KEYBOARD_AND_MOUSE)
         &&  (device_mouse_check_button_pressed(0, mb_any) || mouse_wheel_up() || mouse_wheel_down()))
    {
        return { source : INPUT_SOURCE.KEYBOARD_AND_MOUSE, gamepad : undefined };
    }
    else if (global.__input_gamepad_valid)
    {
        var _g = 0;
        repeat(gamepad_get_device_count())
        {
            if (gamepad_is_connected(_g) && __input_source_is_available(INPUT_SOURCE.GAMEPAD, _g))
            {
                if (input_gamepad_check_pressed(_g, gp_face1)
                ||  input_gamepad_check_pressed(_g, gp_face2)
                ||  input_gamepad_check_pressed(_g, gp_face3)
                ||  input_gamepad_check_pressed(_g, gp_face4)
                ||  input_gamepad_check_pressed(_g, gp_padu)
                ||  input_gamepad_check_pressed(_g, gp_padd)
                ||  input_gamepad_check_pressed(_g, gp_padl)
                ||  input_gamepad_check_pressed(_g, gp_padr)
                ||  input_gamepad_check_pressed(_g, gp_shoulderl)
                ||  input_gamepad_check_pressed(_g, gp_shoulderr)
                ||  input_gamepad_check_pressed(_g, gp_shoulderlb)
                ||  input_gamepad_check_pressed(_g, gp_shoulderrb)
                ||  input_gamepad_check_pressed(_g, gp_start)
                ||  input_gamepad_check_pressed(_g, gp_select)
                ||  input_gamepad_check_pressed(_g, gp_stickl)
                ||  input_gamepad_check_pressed(_g, gp_stickr)
                ||  (INPUT_SDL2_ALLOW_GUIDE && input_gamepad_check(_g, gp_guide))
                ||  (INPUT_SDL2_ALLOW_MISC1 && input_gamepad_check(_g, gp_misc1)))
                {
                    return { source : INPUT_SOURCE.GAMEPAD, gamepad : _g };
                }
            }
                    
            ++_g;
        }
    }
    
    return { source: INPUT_SOURCE.NONE, gamepad : INPUT_NO_GAMEPAD };
}