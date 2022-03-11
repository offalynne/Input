/// @param [playerIndex]

function input_source_hotswap_tick(_player_index = 0)
{
    if (_player_index < 0)
    {
        __input_error("Invalid player index provided (", _player_index, ")");
        return undefined;
    }
    
    if (_player_index >= INPUT_MAX_PLAYERS)
    {
        __input_error("Player index too large (", _player_index, " must be less than ", INPUT_MAX_PLAYERS, ")\nIncrease INPUT_MAX_PLAYERS to support more players");
        return undefined;
    }
    
    with(global.__input_players[_player_index])
    {
        if ((last_input_time < 0) || (current_time - last_input_time > INPUT_HOTSWAP_DELAY))
        {
            var _new_device = __input_hotswap_tick_input(_player_index);
            if (_new_device.source != INPUT_SOURCE.NONE)
            {
                input_player_source_set(_new_device.source, _player_index);
                if (_new_device.source == INPUT_SOURCE.GAMEPAD) input_player_gamepad_set(_new_device.gamepad, _player_index);
                return true;
            }
        }
    }
    
    return false;
}

/// @param playerIndex
function __input_hotswap_tick_input(_player_index)
{
    //Check gamepad input before keyboard input to correctly handle Android duplicating button presses with keyboard presses
    if (global.__input_gamepad_default_defined)
    {
        var _player = global.__input_players[_player_index];
        
        var _g = 0;
        repeat(gamepad_get_device_count())
        {
            if (gamepad_is_connected(_g) && ((_player.gamepad == _g) || (input_source_is_available(INPUT_SOURCE.GAMEPAD, _g))))
            {
                var _active = false;
                
                //Check buttons
                if (input_gamepad_check(_g, gp_face1)
                ||  input_gamepad_check(_g, gp_face2)
                ||  input_gamepad_check(_g, gp_face3)
                ||  input_gamepad_check(_g, gp_face4)
                ||  input_gamepad_check(_g, gp_padu)
                ||  input_gamepad_check(_g, gp_padd)
                ||  input_gamepad_check(_g, gp_padl)
                ||  input_gamepad_check(_g, gp_padr)
                ||  input_gamepad_check(_g, gp_shoulderl)
                ||  input_gamepad_check(_g, gp_shoulderr)
                ||  input_gamepad_check(_g, gp_start)
                ||  input_gamepad_check(_g, gp_select)
                ||  input_gamepad_check(_g, gp_stickl)
                ||  input_gamepad_check(_g, gp_stickr)
                ||  (!input_gamepad_is_axis(_g, gp_shoulderlb) && input_gamepad_check(_g, gp_shoulderlb))
                ||  (!input_gamepad_is_axis(_g, gp_shoulderrb) && input_gamepad_check(_g, gp_shoulderrb)))
                {
                    _active = true;
                }
                
                //Check axes
                if  (INPUT_HOTSWAP_ON_GAMEPAD_AXIS)
                {
                    if ((abs(input_gamepad_value(_g, gp_shoulderlb)) > input_axis_threshold_get(gp_shoulderlb, _player_index).mini)
                    ||  (abs(input_gamepad_value(_g, gp_shoulderrb)) > input_axis_threshold_get(gp_shoulderrb, _player_index).mini)
                    ||  (abs(input_gamepad_value(_g, gp_axislv)) > input_axis_threshold_get(gp_axislv, _player_index).mini)
                    ||  (abs(input_gamepad_value(_g, gp_axislh)) > input_axis_threshold_get(gp_axislh, _player_index).mini)
                    ||  (abs(input_gamepad_value(_g, gp_axislv)) > input_axis_threshold_get(gp_axislv, _player_index).mini)
                    ||  (abs(input_gamepad_value(_g, gp_axisrh)) > input_axis_threshold_get(gp_axisrh, _player_index).mini)
                    ||  (abs(input_gamepad_value(_g, gp_axisrv)) > input_axis_threshold_get(gp_axisrv, _player_index).mini))
                    {
                        _active = true;
                    }
                }
                
                //Check extended
                if (INPUT_SDL2_ALLOW_EXTENDED)
                {
                    if (input_gamepad_check(_g, gp_guide)
                    ||  input_gamepad_check(_g, gp_misc1)
                    ||  input_gamepad_check(_g, gp_touchpad)
                    ||  input_gamepad_check(_g, gp_paddle1)
                    ||  input_gamepad_check(_g, gp_paddle2)
                    ||  input_gamepad_check(_g, gp_paddle3)
                    ||  input_gamepad_check(_g, gp_paddle4))
                    {
                        _active = true;
                    }
                }
                
                if (_active)
                {
                    if (_player.gamepad == _g)
                    {
                        _player.last_input_time = current_time;
                    }
                    else
                    {
                        if (__INPUT_DEBUG) __input_trace("Hotswapping player ", _player_index, " to gamepad ", _g);
                    }
                    
                    return { source : INPUT_SOURCE.GAMEPAD, gamepad : _g };
                }
            }
            
            ++_g;
        }
    }
    
    if (global.__input_keyboard_default_defined
    &&  input_source_is_available(INPUT_SOURCE.KEYBOARD_AND_MOUSE)
    &&  keyboard_check(vk_anykey)
    &&  !__input_key_is_ignored(__input_keyboard_key())) //Ensure that this key isn't one we're trying to ignore
    {
        if (__INPUT_DEBUG) __input_trace("Hotswapping player ", _player_index, " to keyboard+mouse (via keyboard input)");
        return { source : INPUT_SOURCE.KEYBOARD_AND_MOUSE, gamepad : undefined };
    }
    
    if (global.__input_mouse_default_defined
    &&  input_source_is_available(INPUT_SOURCE.KEYBOARD_AND_MOUSE)
    && ( (INPUT_HOTSWAP_ON_MOUSE_MOVEMENT && global.__input_mouse_moved) || input_mouse_check(mb_any) || mouse_wheel_up() || mouse_wheel_down()))
    {
        if (__INPUT_DEBUG) __input_trace("Hotswapping player ", _player_index, " to keyboard+mouse (via mouse input)");
        return { source : INPUT_SOURCE.KEYBOARD_AND_MOUSE, gamepad : undefined };
    }
    
    return { source: INPUT_SOURCE.NONE, gamepad : INPUT_NO_GAMEPAD };
}
