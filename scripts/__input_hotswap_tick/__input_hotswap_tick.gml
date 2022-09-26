/// @param [setAutoProfile=true]

function __input_hotswap_tick()
{
    with(global.__input_players[0])
    {
        if (__ghost)
        {
            __input_trace("Warning! Cannot hotswap because player 0 is a ghost");
            return false;
        }
        
        if ((__last_input_time < 0) || (global.__input_current_time - __last_input_time > INPUT_HOTSWAP_DELAY))
        {
            var _new_source = __input_hotswap_tick_input();
            if ((_new_source != undefined) && !__source_contains(_new_source))
            {
                input_source_set(_new_source, 0, INPUT_HOTSWAP_AUTO_PROFILE);
                
                if (is_method(INPUT_HOTSWAP_CALLBACK))
                {
                    INPUT_HOTSWAP_CALLBACK();
                }
                else if (is_numeric(INPUT_HOTSWAP_CALLBACK) && script_exists(INPUT_HOTSWAP_CALLBACK))
                {
                    script_execute(INPUT_HOTSWAP_CALLBACK);
                }
                else if (INPUT_HOTSWAP_CALLBACK != undefined)
                {
                    __input_error("INPUT_HOTSWAP_CALLBACK set to an illegal value (typeof=", typeof(INPUT_HOTSWAP_CALLBACK), ")");
                }
            }
        }
    }
}

/// @param playerIndex
function __input_hotswap_tick_input()
{
    //Check gamepad input before keyboard input to correctly handle Android duplicating button presses with keyboard presses
    if (global.__input_any_gamepad_binding_defined)
    {
        var _gamepad_count = array_length(INPUT_GAMEPAD);
        var _g = 0;
        
        #region In-use gamepad
        
        repeat(_gamepad_count)
        {
            if (gamepad_is_connected(_g) && input_source_using(INPUT_GAMEPAD[_g]))
            {                    
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
                    break;
                }
                    
                //Check axes
                if (INPUT_HOTSWAP_ON_GAMEPAD_AXIS)
                {
                    if ((abs(input_gamepad_value(_g, gp_shoulderlb)) > input_axis_threshold_get(gp_shoulderlb, 0).mini)
                    ||  (abs(input_gamepad_value(_g, gp_shoulderrb)) > input_axis_threshold_get(gp_shoulderrb, 0).mini)
                    ||  (abs(input_gamepad_value(_g, gp_axislv    )) > input_axis_threshold_get(gp_axislv, 0).mini)
                    ||  (abs(input_gamepad_value(_g, gp_axislh    )) > input_axis_threshold_get(gp_axislh, 0).mini)
                    ||  (abs(input_gamepad_value(_g, gp_axislv    )) > input_axis_threshold_get(gp_axislv, 0).mini)
                    ||  (abs(input_gamepad_value(_g, gp_axisrh    )) > input_axis_threshold_get(gp_axisrh, 0).mini)
                    ||  (abs(input_gamepad_value(_g, gp_axisrv    )) > input_axis_threshold_get(gp_axisrv, 0).mini))
                    {
                        break;
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
                        break;
                    }
                }
            }
            
            ++_g;
        }
        
        #endregion
        
        if (_g < _gamepad_count)
        {
            //Maintain in-use gamepad
            global.__input_players[0].__last_input_time = global.__input_current_time;
            return INPUT_GAMEPAD[_g];
        }
        else
        {
            //Test available gamepads
            var _sort_order = 1;
            _g = 0;
        
            if (!__INPUT_ON_WEB && ((os_type == os_windows) || (os_type == os_macosx)))
            {
                //Search last-to-first on platforms with low-index virtual controllers (Steam Input, ViGEm)
                //We want real devices to take priority over virtual ones where possible to avoid thrashing
                _sort_order = -1;
                _g = _gamepad_count - 1;
            }

            #region Gamepad not in-use but potentially available
                        
            repeat(_gamepad_count)
            {
                if (gamepad_is_connected(_g) && input_source_is_available(INPUT_GAMEPAD[_g]))
                { 
                    //Check buttons
                    if (input_gamepad_check_pressed(_g, gp_face1)
                    ||  input_gamepad_check_pressed(_g, gp_face2)
                    ||  input_gamepad_check_pressed(_g, gp_face3)
                    ||  input_gamepad_check_pressed(_g, gp_face4)
                    ||  input_gamepad_check_pressed(_g, gp_shoulderl)
                    ||  input_gamepad_check_pressed(_g, gp_shoulderr)
                    ||  input_gamepad_check_pressed(_g, gp_start)
                    ||  input_gamepad_check_pressed(_g, gp_select)
                    ||  input_gamepad_check_pressed(_g, gp_stickl)
                    ||  input_gamepad_check_pressed(_g, gp_stickr)
                    ||  (input_gamepad_check_pressed(_g, gp_padu) && (input_gamepad_delta(_g, gp_padu) != 0))
                    ||  (input_gamepad_check_pressed(_g, gp_padd) && (input_gamepad_delta(_g, gp_padd) != 0))
                    ||  (input_gamepad_check_pressed(_g, gp_padl) && (input_gamepad_delta(_g, gp_padl) != 0))
                    ||  (input_gamepad_check_pressed(_g, gp_padr) && (input_gamepad_delta(_g, gp_padr) != 0))
                    ||  (!input_gamepad_is_axis(_g, gp_shoulderlb) && input_gamepad_check_pressed(_g, gp_shoulderlb))
                    ||  (!input_gamepad_is_axis(_g, gp_shoulderrb) && input_gamepad_check_pressed(_g, gp_shoulderrb)))
                    {
                            if (INPUT_DEBUG_SOURCES) __input_trace("Hotswapping player 0 to ", INPUT_GAMEPAD[_g]);
                            return INPUT_GAMEPAD[_g];
                    }
                    
                    //Check axes
                    if  (INPUT_HOTSWAP_ON_GAMEPAD_AXIS)
                    {
                        if (((abs(input_gamepad_value(_g, gp_shoulderlb)) > input_axis_threshold_get(gp_shoulderlb).mini) && (abs(input_gamepad_delta(_g, gp_shoulderlb)) > __INPUT_DELTA_HOTSWAP_THRESHOLD))
                        ||  ((abs(input_gamepad_value(_g, gp_shoulderrb)) > input_axis_threshold_get(gp_shoulderrb).mini) && (abs(input_gamepad_delta(_g, gp_shoulderrb)) > __INPUT_DELTA_HOTSWAP_THRESHOLD))
                        ||  ((abs(input_gamepad_value(_g, gp_axislv    )) > input_axis_threshold_get(gp_axislv    ).mini) && (abs(input_gamepad_delta(_g, gp_axislv    )) > __INPUT_DELTA_HOTSWAP_THRESHOLD))
                        ||  ((abs(input_gamepad_value(_g, gp_axislh    )) > input_axis_threshold_get(gp_axislh    ).mini) && (abs(input_gamepad_delta(_g, gp_axislh    )) > __INPUT_DELTA_HOTSWAP_THRESHOLD))
                        ||  ((abs(input_gamepad_value(_g, gp_axislv    )) > input_axis_threshold_get(gp_axislv    ).mini) && (abs(input_gamepad_delta(_g, gp_axislv    )) > __INPUT_DELTA_HOTSWAP_THRESHOLD))
                        ||  ((abs(input_gamepad_value(_g, gp_axisrh    )) > input_axis_threshold_get(gp_axisrh    ).mini) && (abs(input_gamepad_delta(_g, gp_axisrh    )) > __INPUT_DELTA_HOTSWAP_THRESHOLD))
                        ||  ((abs(input_gamepad_value(_g, gp_axisrv    )) > input_axis_threshold_get(gp_axisrv    ).mini) && (abs(input_gamepad_delta(_g, gp_axisrv    )) > __INPUT_DELTA_HOTSWAP_THRESHOLD)))
                        {
                            if (INPUT_DEBUG_SOURCES) __input_trace("Hotswapping player 0 to ", INPUT_GAMEPAD[_g]);
                            return INPUT_GAMEPAD[_g];
                        }
                    }
                    
                    //Check extended
                    if (INPUT_SDL2_ALLOW_EXTENDED)
                    {
                        if (input_gamepad_check_pressed(_g, gp_guide)
                        ||  input_gamepad_check_pressed(_g, gp_misc1)
                        ||  input_gamepad_check_pressed(_g, gp_touchpad)
                        ||  input_gamepad_check_pressed(_g, gp_paddle1)
                        ||  input_gamepad_check_pressed(_g, gp_paddle2)
                        ||  input_gamepad_check_pressed(_g, gp_paddle3)
                        ||  input_gamepad_check_pressed(_g, gp_paddle4))
                        {
                            if (INPUT_DEBUG_SOURCES) __input_trace("Hotswapping player 0 to ", INPUT_GAMEPAD[_g]);
                            return INPUT_GAMEPAD[_g];
                        }
                    }
                }
            
                _g += _sort_order;
            }
                
            #endregion
        }
    }
    
    if (global.__input_any_keyboard_binding_defined
    &&  input_source_is_available(INPUT_KEYBOARD)
    &&  keyboard_check(vk_anykey)
    &&  !__input_key_is_ignored(__input_keyboard_key())) //Ensure that this key isn't one we're trying to ignore
    {
        if (INPUT_DEBUG_SOURCES) __input_trace("Hotswapping player 0 to ", INPUT_KEYBOARD);
        return INPUT_KEYBOARD;
    }
    
    if (input_source_is_available(INPUT_MOUSE)
    && ((INPUT_HOTSWAP_ON_MOUSE_MOVEMENT && global.__input_pointer_moved)
      || INPUT_HOTSWAP_ON_MOUSE_BUTTON && (input_mouse_check(mb_any) || mouse_wheel_up() || mouse_wheel_down())))
    {
        if (INPUT_DEBUG_SOURCES) __input_trace("Hotswapping player 0 to ", INPUT_MOUSE);
        return INPUT_MOUSE;
    }
    
    return undefined;
}
