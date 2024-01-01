// Feather disable all
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
        
        if (_global.__game_input_allowed //Application input is allowed
        && ((__last_input_time < 0) || (_global.__current_time - __last_input_time > INPUT_HOTSWAP_DELAY)) //And enough time has passed since the last input
        && ((__rebind_state <= 0) || !is_array(__rebind_source_filter) || (array_length(__rebind_source_filter) <= 0))) //And we're not rebinding, or the rebinding source filter is empty
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
    
    if (_global.__any_gamepad_binding_defined)
    {
        //In-use gamepad
        var _player = _global.__players[0];
        var _active_gamepad_index = _player.__source_get_gamepad();
        if (gamepad_is_connected(_active_gamepad_index))
        {
            var _gamepad = _global.__gamepads[_active_gamepad_index];
            if (is_struct(_gamepad) && (_gamepad.__get_any_pressed() || __input_hotswap_axis_delta(_gamepad)))
            {
                _player.__last_input_time = _global.__current_time;
                return INPUT_GAMEPAD[_active_gamepad_index];
            }
        }
        
        var _gamepad_count = array_length(INPUT_GAMEPAD);
        if not (_global.__frame - _global.__window_focus_frame < __INPUT_GAMEPADS_FOCUS_TIMEOUT) //Prevent resting axes from triggering source swap
        {
            //Search last-to-first on platforms with low-index virtual controllers (Steam Input, ViGEm)
            var _gamepad_index = 0;
            static _sort_order = (!INPUT_ON_WEB && (__INPUT_ON_MACOS || (!_global.__using_steamworks && __INPUT_ON_WINDOWS) || (_global.__using_steamworks && __INPUT_ON_LINUX))? -1 : 1);
            if (_sort_order == -1) _gamepad_index = _gamepad_count - 1;

            repeat(_gamepad_count)
            {
                if ((_gamepad_index != _active_gamepad_index) && gamepad_is_connected(_gamepad_index))
                {
                    //Gamepad not in-use but potentially available          
                    var _gamepad = _global.__gamepads[_gamepad_index];
                    if (is_struct(_gamepad)
                    && (_gamepad.__disconnection_frame == undefined))
                    {
                        if (_gamepad.__get_any_pressed())
                        {
                            if (!__INPUT_SILENT) __input_trace("Hotswapping on gamepad ", INPUT_GAMEPAD[_gamepad_index], " \"", _global.__gamepads[_gamepad_index].description, "\" button press");
                            _player.__last_input_time = _global.__current_time;
                            return INPUT_GAMEPAD[_gamepad_index];
                        }
                        
                        if (__input_hotswap_axis_delta(_gamepad))
                        {
                            if (!__INPUT_SILENT) __input_trace("Hotswapping on gamepad ", INPUT_GAMEPAD[_gamepad_index], " \"", _global.__gamepads[_gamepad_index].description, "\" axis press");
                            _player.__last_input_time = _global.__current_time;
                            return INPUT_GAMEPAD[_gamepad_index];
                            
                        }
                    }
                }

                _gamepad_index += _sort_order;
            }
        }
    }
    
    if (_global.__keyboard_allowed && _global.__any_keyboard_binding_defined
    &&  input_source_is_available(INPUT_KEYBOARD)
    &&  keyboard_check_pressed(vk_anykey)
    &&  (__input_keyboard_key() > 0) //Ensure that the key is in the recognized range
    &&  !__input_key_is_ignored(__input_keyboard_key())) //Ensure that this key isn't one we're trying to ignore
    {
        if (!__INPUT_SILENT) __input_trace("Hotswapping on keyboard press");
        return INPUT_KEYBOARD;
    }
    
    if (_global.__touch_allowed)
    {
        if (input_source_is_available(INPUT_TOUCH) && device_mouse_check_button(_global.__pointer_index, mb_left))
        {
            if (!__INPUT_SILENT) __input_trace("Hotswapping on touch");
            return INPUT_TOUCH;
        }
    }
    else
    {
        if (_global.__mouse_allowed && input_source_is_available(INPUT_MOUSE))
        {
            if (INPUT_HOTSWAP_ON_MOUSE_BUTTON)
            {
                if (input_mouse_check_pressed(mb_any))
                {
                    if (!__INPUT_SILENT) __input_trace("Hotswapping on mouse button press");
                    return INPUT_MOUSE;
                }
                
                if (mouse_wheel_up() || mouse_wheel_down())
                {
                    if (!__INPUT_SILENT) __input_trace("Hotswapping on mouse wheel");
                    return INPUT_MOUSE;
                }
            }
            
            if (INPUT_HOTSWAP_ON_MOUSE_MOVEMENT && _global.__pointer_moved)
            {
                if (!__INPUT_SILENT) __input_trace("Hotswapping on mouse pointer movement");
                return INPUT_MOUSE;
            }
        }
    }
    
    return undefined;
}

/// @param gamepad
function __input_hotswap_axis_delta(_gamepad)
{
    __INPUT_GLOBAL_STATIC_LOCAL  //Set static _global
    
    var _player = _global.__players[0];
    if (((abs(_gamepad.get_value(gp_shoulderlb)) > _player.__axis_threshold_get(gp_shoulderlb).mini) && (abs(_gamepad.get_delta(gp_shoulderlb)) > __INPUT_DELTA_HOTSWAP_THRESHOLD))
    ||  ((abs(_gamepad.get_value(gp_shoulderrb)) > _player.__axis_threshold_get(gp_shoulderrb).mini) && (abs(_gamepad.get_delta(gp_shoulderrb)) > __INPUT_DELTA_HOTSWAP_THRESHOLD))
    ||  ((abs(_gamepad.get_value(gp_axislv    )) > _player.__axis_threshold_get(gp_axislv    ).mini) && (abs(_gamepad.get_delta(gp_axislv    )) > __INPUT_DELTA_HOTSWAP_THRESHOLD))
    ||  ((abs(_gamepad.get_value(gp_axislh    )) > _player.__axis_threshold_get(gp_axislh    ).mini) && (abs(_gamepad.get_delta(gp_axislh    )) > __INPUT_DELTA_HOTSWAP_THRESHOLD))
    ||  ((abs(_gamepad.get_value(gp_axislv    )) > _player.__axis_threshold_get(gp_axislv    ).mini) && (abs(_gamepad.get_delta(gp_axislv    )) > __INPUT_DELTA_HOTSWAP_THRESHOLD))
    ||  ((abs(_gamepad.get_value(gp_axisrh    )) > _player.__axis_threshold_get(gp_axisrh    ).mini) && (abs(_gamepad.get_delta(gp_axisrh    )) > __INPUT_DELTA_HOTSWAP_THRESHOLD))
    ||  ((abs(_gamepad.get_value(gp_axisrv    )) > _player.__axis_threshold_get(gp_axisrv    ).mini) && (abs(_gamepad.get_delta(gp_axisrv    )) > __INPUT_DELTA_HOTSWAP_THRESHOLD)))
    {
        return true;
    }

    return false;
}

