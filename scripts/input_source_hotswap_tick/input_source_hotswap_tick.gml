/// @param [playerIndex=0]
/// @param [setAutoProfile=true]

function input_source_hotswap_tick(_player_index = 0, _auto_profile = true)
{
    with(global.__input_players[_player_index])
    {
        if (__ghost)
        {
            __input_trace("Warning! Cannot hotswap because player ", _player_index, " is a ghost");
            return false;
        }
        
        if ((__last_input_time < 0) || (current_time - __last_input_time > INPUT_HOTSWAP_DELAY))
        {
            var _new_source = __input_hotswap_tick_input(_player_index);
            if (_new_source != INPUT_NONE)
            {
                if (_auto_profile)
                {
                    switch(_new_source.__source)
                    {
                        case __INPUT_SOURCE.KEYBOARD: __profile_set(INPUT_AUTO_PROFILE_FOR_KEYBOARD); break;
                        case __INPUT_SOURCE.MOUSE:    __profile_set(INPUT_AUTO_PROFILE_FOR_MOUSE   ); break;
                        case __INPUT_SOURCE.GAMEPAD:  __profile_set(INPUT_AUTO_PROFILE_FOR_GAMEPAD ); break;
                    }
                }
                
                __sources_clear();
                __source_add(_new_source);
                
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
    if (global.__input_any_gamepad_binding_defined)
    {
        var _player = global.__input_players[_player_index];
        
        var _g = 0;
        repeat(gamepad_get_device_count())
        {
            if (gamepad_is_connected(_g) && ((_player.gamepad == _g) || input_source_is_available(INPUT_GAMEPAD[_g])))
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
                        _player.__last_input_time = current_time;
                    }
                    else
                    {
                        if (__INPUT_DEBUG) __input_trace("Hotswapping player ", _player_index, " to gamepad ", _g);
                    }
                    
                    return INPUT_GAMEPAD[_g];
                }
            }
            
            ++_g;
        }
    }
    
    if (global.__input_any_keyboard_binding_defined
    &&  input_source_is_available(INPUT_KEYBOARD)
    &&  keyboard_check(vk_anykey)
    &&  !__input_key_is_ignored(__input_keyboard_key())) //Ensure that this key isn't one we're trying to ignore
    {
        if (__INPUT_DEBUG) __input_trace("Hotswapping player ", _player_index, " to keyboard");
        return INPUT_KEYBOARD;
    }
    
    if (global.__input_any_mouse_binding_defined
    &&  input_source_is_available(INPUT_MOUSE)
    && ((INPUT_HOTSWAP_ON_MOUSE_MOVEMENT && global.__input_mouse_moved) || input_mouse_check(mb_any) || mouse_wheel_up() || mouse_wheel_down()))
    {
        if (__INPUT_DEBUG) __input_trace("Hotswapping player ", _player_index, " to mouse");
        return INPUT_MOUSE;
    }
    
    return INPUT_NONE;
}
