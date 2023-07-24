/// @param [setAutoProfile=true]

function __input_hotswap_tick()
{
    __INPUT_GLOBAL_STATIC_LOCAL  //Set static _global
    
    with(_global.__players[0])
    {
        if (__ghost)
        {
            if (!__INPUT_SILENT) __input_trace("Warning! Cannot hotswap because player 0 is a ghost");
            return false;
        }
        
        if (!__active) return false;
        
        if (_global.__window_focus || INPUT_ALLOW_OUT_OF_FOCUS) //Application input is allowed
        && ((__last_input_time < 0) || (_global.__current_time - __last_input_time > INPUT_HOTSWAP_DELAY)) //And enough time has passed since the last input
        && ((__rebind_state <= 0) || !is_array(__rebind_source_filter) || (array_length(__rebind_source_filter) <= 0)) //And we're not rebinding, or the rebinding source filter is empty
        {
            var _new_source = __input_hotswap_tick_input();
            if ((_new_source != undefined) && !__source_contains(_new_source))
            {
                input_source_set(_new_source, 0, INPUT_HOTSWAP_AUTO_PROFILE);
                
                if (is_method(_global.__hotswap_callback))
                {
                    _global.__hotswap_callback();
                }
                else if (is_numeric(_global.__hotswap_callback) && script_exists(_global.__hotswap_callback))
                {
                    script_execute(_global.__hotswap_callback);
                }
                else if (_global.__hotswap_callback != undefined)
                {
                    __input_error("Hotswap callback set to an illegal value (typeof=", typeof(_global.__hotswap_callback), ")");
                }
            }
        }
    }
}

/// @param playerIndex
function __input_hotswap_tick_input()
{
    __INPUT_GLOBAL_STATIC_LOCAL  //Set static _global
    
    //Check gamepad input before keyboard input to correctly handle Android duplicating button presses with keyboard presses
    if (_global.__any_gamepad_binding_defined)
    {
        #region In-use gamepad

        var _player = _global.__players[0];
        var _active_gamepad_index = _player.__source_get_gamepad();
        if (gamepad_is_connected(_active_gamepad_index) && is_struct(_global.__gamepads[_active_gamepad_index]))
        {
            with (_global.__gamepads[_active_gamepad_index])
            {
                //Check buttons
                if (get_pressed(gp_face1)
                ||  get_pressed(gp_face2)
                ||  get_pressed(gp_face3)
                ||  get_pressed(gp_face4)
                ||  get_pressed(gp_padu)
                ||  get_pressed(gp_padd)
                ||  get_pressed(gp_padl)
                ||  get_pressed(gp_padr)
                ||  get_pressed(gp_shoulderl)
                ||  get_pressed(gp_shoulderr)
                ||  get_pressed(gp_start)
                ||  get_pressed(gp_select)
                ||  get_pressed(gp_stickl)
                ||  get_pressed(gp_stickr)
                ||  (!is_axis(gp_shoulderlb) && get_pressed(gp_shoulderlb))
                ||  (!is_axis(gp_shoulderrb) && get_pressed(gp_shoulderrb)))
                {
                    _player.__last_input_time = _global.__current_time;
                    return INPUT_GAMEPAD[_active_gamepad_index];
                }

                if (custom_mapping)
                {
                    //Check axes
                    if (INPUT_HOTSWAP_ON_GAMEPAD_AXIS
                    && (((abs(get_value(gp_shoulderlb)) > _player.__axis_threshold_get(gp_shoulderlb).mini) && (abs(get_delta(gp_shoulderlb)) > __INPUT_DELTA_HOTSWAP_THRESHOLD))
                     || ((abs(get_value(gp_shoulderrb)) > _player.__axis_threshold_get(gp_shoulderrb).mini) && (abs(get_delta(gp_shoulderrb)) > __INPUT_DELTA_HOTSWAP_THRESHOLD))
                     || ((abs(get_value(gp_axislv    )) > _player.__axis_threshold_get(gp_axislv    ).mini) && (abs(get_delta(gp_axislv    )) > __INPUT_DELTA_HOTSWAP_THRESHOLD))
                     || ((abs(get_value(gp_axislh    )) > _player.__axis_threshold_get(gp_axislh    ).mini) && (abs(get_delta(gp_axislh    )) > __INPUT_DELTA_HOTSWAP_THRESHOLD))
                     || ((abs(get_value(gp_axislv    )) > _player.__axis_threshold_get(gp_axislv    ).mini) && (abs(get_delta(gp_axislv    )) > __INPUT_DELTA_HOTSWAP_THRESHOLD))
                     || ((abs(get_value(gp_axisrh    )) > _player.__axis_threshold_get(gp_axisrh    ).mini) && (abs(get_delta(gp_axisrh    )) > __INPUT_DELTA_HOTSWAP_THRESHOLD))
                     || ((abs(get_value(gp_axisrv    )) > _player.__axis_threshold_get(gp_axisrv    ).mini) && (abs(get_delta(gp_axisrv    )) > __INPUT_DELTA_HOTSWAP_THRESHOLD))))
                    {
                        _player.__last_input_time = _global.__current_time;
                        return INPUT_GAMEPAD[_active_gamepad_index];
                    }
                            
                    //Check extended
                    if (INPUT_SDL2_ALLOW_EXTENDED
                    && (get_pressed(gp_guide)
                     || get_pressed(gp_misc1)
                     || get_pressed(gp_touchpad)
                     || get_pressed(gp_paddle1)
                     || get_pressed(gp_paddle2)
                     || get_pressed(gp_paddle3)
                     || get_pressed(gp_paddle4)))
                    {
                        _player.__last_input_time = _global.__current_time;
                        return INPUT_GAMEPAD[_active_gamepad_index];
                    }
                }
            }
        }
        
        #endregion
        
        var _gamepad_count = array_length(INPUT_GAMEPAD);
        if not (_global.__frame - _global.__window_focus_frame < 2) //Prevent resting axes from triggering source swap
        {
            //Search last-to-first on platforms with low-index virtual controllers (Steam Input, ViGEm)
            var _gamepad_index = 0;
            static _sort_order = (!INPUT_ON_WEB && (__INPUT_ON_MACOS || (!_global.__using_steamworks && __INPUT_ON_WINDOWS) || (_global.__using_steamworks && __INPUT_ON_LINUX))? -1 : 1);
            if (_sort_order == -1) _gamepad_index = _gamepad_count - 1;

            #region Gamepad not in-use but potentially available
                        
            repeat(_gamepad_count)
            {
                var _gamepad = _global.__gamepads[_gamepad_index];
                if ((_gamepad_index != _active_gamepad_index) && gamepad_is_connected(_gamepad_index) && is_struct(_gamepad))
                {
                    with (_gamepad)
                    {
                        //Check buttons
                        if (get_pressed(gp_face1)
                        ||  get_pressed(gp_face2)
                        ||  get_pressed(gp_face3)
                        ||  get_pressed(gp_face4)
                        ||  get_pressed(gp_padu)
                        ||  get_pressed(gp_padd)
                        ||  get_pressed(gp_padl)
                        ||  get_pressed(gp_padr)
                        ||  get_pressed(gp_shoulderl)
                        ||  get_pressed(gp_shoulderr)
                        ||  get_pressed(gp_start)
                        ||  get_pressed(gp_select)
                        ||  get_pressed(gp_stickl)
                        ||  get_pressed(gp_stickr)
                        ||  (!is_axis(gp_shoulderlb) && get_pressed(gp_shoulderlb))
                        ||  (!is_axis(gp_shoulderrb) && get_pressed(gp_shoulderrb)))
                        {
                            if (__INPUT_DEBUG_SOURCES) __input_trace("Hotswapping player 0 to ", INPUT_GAMEPAD[_gamepad_index]);
                            return INPUT_GAMEPAD[_gamepad_index];
                        }

                        if (custom_mapping)
                        {
                            //Check axes
                            if (INPUT_HOTSWAP_ON_GAMEPAD_AXIS
                            && (((abs(get_value(gp_shoulderlb)) > _player.__axis_threshold_get(gp_shoulderlb).mini) && (abs(get_delta(gp_shoulderlb)) > __INPUT_DELTA_HOTSWAP_THRESHOLD))
                             || ((abs(get_value(gp_shoulderrb)) > _player.__axis_threshold_get(gp_shoulderrb).mini) && (abs(get_delta(gp_shoulderrb)) > __INPUT_DELTA_HOTSWAP_THRESHOLD))
                             || ((abs(get_value(gp_axislv    )) > _player.__axis_threshold_get(gp_axislv    ).mini) && (abs(get_delta(gp_axislv    )) > __INPUT_DELTA_HOTSWAP_THRESHOLD))
                             || ((abs(get_value(gp_axislh    )) > _player.__axis_threshold_get(gp_axislh    ).mini) && (abs(get_delta(gp_axislh    )) > __INPUT_DELTA_HOTSWAP_THRESHOLD))
                             || ((abs(get_value(gp_axislv    )) > _player.__axis_threshold_get(gp_axislv    ).mini) && (abs(get_delta(gp_axislv    )) > __INPUT_DELTA_HOTSWAP_THRESHOLD))
                             || ((abs(get_value(gp_axisrh    )) > _player.__axis_threshold_get(gp_axisrh    ).mini) && (abs(get_delta(gp_axisrh    )) > __INPUT_DELTA_HOTSWAP_THRESHOLD))
                             || ((abs(get_value(gp_axisrv    )) > _player.__axis_threshold_get(gp_axisrv    ).mini) && (abs(get_delta(gp_axisrv    )) > __INPUT_DELTA_HOTSWAP_THRESHOLD))))
                            {
                                if (__INPUT_DEBUG_SOURCES) __input_trace("Hotswapping player 0 to ", INPUT_GAMEPAD[_gamepad_index]);
                                return INPUT_GAMEPAD[_gamepad_index];
                            }
                        
                            //Check extended
                            if (INPUT_SDL2_ALLOW_EXTENDED
                            && (get_pressed(gp_guide)
                             || get_pressed(gp_misc1)
                             || get_pressed(gp_touchpad)
                             || get_pressed(gp_paddle1)
                             || get_pressed(gp_paddle2)
                             || get_pressed(gp_paddle3)
                             || get_pressed(gp_paddle4)))
                            {
                                if (__INPUT_DEBUG_SOURCES) __input_trace("Hotswapping player 0 to ", INPUT_GAMEPAD[_gamepad_index]);
                                return INPUT_GAMEPAD[_gamepad_index];
                            }
                        }
                    }
                }

                _gamepad_index += _sort_order;
            }
                
            #endregion
        }
    }
    
    if (_global.__keyboard_allowed && _global.__any_keyboard_binding_defined
    &&  input_source_is_available(INPUT_KEYBOARD)
    &&  keyboard_check_pressed(vk_anykey)
    &&  !__input_key_is_ignored(__input_keyboard_key())) //Ensure that this key isn't one we're trying to ignore
    {
        if (__INPUT_DEBUG_SOURCES) __input_trace("Hotswapping player 0 to ", INPUT_KEYBOARD);
        return INPUT_KEYBOARD;
    }
    
    if (_global.__touch_allowed)
    {
        if (input_source_is_available(INPUT_TOUCH) && device_mouse_check_button(_global.__pointer_index, mb_left))
        {
            if (__INPUT_DEBUG_SOURCES) __input_trace("Hotswapping player 0 to ", INPUT_TOUCH);
            return INPUT_TOUCH;
        }
    }
    else
    {
        if (_global.__mouse_allowed && input_source_is_available(INPUT_MOUSE)
        && ((INPUT_HOTSWAP_ON_MOUSE_MOVEMENT && _global.__pointer_moved)
          || INPUT_HOTSWAP_ON_MOUSE_BUTTON && (input_mouse_check_pressed(mb_any) || mouse_wheel_up() || mouse_wheel_down())))
        {
            if (__INPUT_DEBUG_SOURCES) __input_trace("Hotswapping player 0 to ", INPUT_MOUSE);
            return INPUT_MOUSE;
        }
    }
    
    return undefined;
}
