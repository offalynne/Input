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
            if (_new_source != undefined)
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
        if (_active_gamepad_index > -1)
        {
            if (_global.__gamepad_connections_native[_active_gamepad_index])
            {
                var _gamepad = _global.__gamepads[_active_gamepad_index];
                if (is_struct(_gamepad) && (_gamepad.__get_any_pressed() || __input_hotswap_axis_delta(_gamepad)))
                {
                    _player.__last_input_time = _global.__current_time;
                    return INPUT_GAMEPAD[_active_gamepad_index];
                }
            }
        }
        
        //Next available gamepad
        if not (_global.__frame - _global.__window_focus_frame < __INPUT_GAMEPADS_FOCUS_TIMEOUT) //Prevent resting axes from triggering source swap
        {
            //Search last-to-first on platforms with low-index virtual controllers (Steam Input, ViGEm)
            static _sort_order = (!INPUT_ON_WEB && (__INPUT_ON_MACOS || (!_global.__using_steamworks && __INPUT_ON_WINDOWS) || (_global.__using_steamworks && __INPUT_ON_LINUX))? -1 : 1);
            
            var _gamepad_count = array_length(INPUT_GAMEPAD);
            var _gamepad_index = 0;
            if (_sort_order == -1)
            {
                _gamepad_index = _gamepad_count - 1;
            }

            repeat(_gamepad_count)
            {
                if ((_gamepad_index != _active_gamepad_index) && _global.__gamepad_connections_native[_gamepad_index])
                {  
                    var _gamepad = _global.__gamepads[_gamepad_index];
                    if (is_struct(_gamepad)
                    && (_gamepad.__disconnection_frame == undefined))
                    {
                        if (_gamepad.__get_any_pressed())
                        {
                            if (!__INPUT_SILENT) __input_trace("Hotswapping on gamepad ", INPUT_GAMEPAD[_gamepad_index], " \"", _global.__gamepads[_gamepad_index].__description, "\" button press");
                            _player.__last_input_time = _global.__current_time;
                            return INPUT_GAMEPAD[_gamepad_index];
                        }
                        
                        if (__input_hotswap_axis_delta(_gamepad))
                        {
                            if (!__INPUT_SILENT) __input_trace("Hotswapping on gamepad ", INPUT_GAMEPAD[_gamepad_index], " \"", _global.__gamepads[_gamepad_index].__description, "\" axis press");
                            _player.__last_input_time = _global.__current_time;
                            return INPUT_GAMEPAD[_gamepad_index];                            
                        }
                    }
                }

                _gamepad_index += _sort_order;
            }
        }
    }
    
    if (_global.__keyboard_allowed && _global.__any_keyboard_binding_defined)
    {
        var _key = __input_keyboard_key();
        if ((_key > 0) && !__input_key_is_ignored(_key))
        {
            if (input_source_is_available(INPUT_KEYBOARD))
            {
                if (!__INPUT_SILENT) __input_trace("Hotswapping on keyboard press");
                return INPUT_KEYBOARD;
            }
        }
    }
    
    if (_global.__touch_allowed)
    {
        if (device_mouse_check_button_pressed(_global.__pointer_index, mb_left))
        {
            if (input_source_is_available(INPUT_TOUCH))
            {
                if (!__INPUT_SILENT) __input_trace("Hotswapping on touch");
                return INPUT_TOUCH;
            }
        }
    }
    else if (_global.__mouse_allowed)
    {
        var _mouse_available = undefined;        
        if (INPUT_HOTSWAP_ON_MOUSE_BUTTON)
        {        
            var _mouse_button = device_mouse_check_button_pressed(_global.__pointer_index, mb_any);
            if (_mouse_button || (mouse_wheel_up() || mouse_wheel_down()))
            {
                _mouse_available = input_source_is_available(INPUT_MOUSE);                
                if (_mouse_available)
                {
                    if (!__INPUT_SILENT) __input_trace(_mouse_button? "Hotswapping on mouse button press" : "Hotswapping on mouse wheel");
                    return INPUT_MOUSE;
                }
            }
        }
            
        if (INPUT_HOTSWAP_ON_MOUSE_MOVEMENT && _global.__pointer_moved)
        {
            if (_mouse_available == undefined)
            {
                _mouse_available = input_source_is_available(INPUT_MOUSE);
            }
            
            if (_mouse_available == true)
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
    if (((abs(_gamepad.__get_value(gp_shoulderlb)) > _player.__axis_threshold_get(gp_shoulderlb).__mini) && (abs(_gamepad.__get_delta(gp_shoulderlb)) > __INPUT_DELTA_HOTSWAP_THRESHOLD))
    ||  ((abs(_gamepad.__get_value(gp_shoulderrb)) > _player.__axis_threshold_get(gp_shoulderrb).__mini) && (abs(_gamepad.__get_delta(gp_shoulderrb)) > __INPUT_DELTA_HOTSWAP_THRESHOLD))
    ||  ((abs(_gamepad.__get_value(gp_axislv    )) > _player.__axis_threshold_get(gp_axislv    ).__mini) && (abs(_gamepad.__get_delta(gp_axislv    )) > __INPUT_DELTA_HOTSWAP_THRESHOLD))
    ||  ((abs(_gamepad.__get_value(gp_axislh    )) > _player.__axis_threshold_get(gp_axislh    ).__mini) && (abs(_gamepad.__get_delta(gp_axislh    )) > __INPUT_DELTA_HOTSWAP_THRESHOLD))
    ||  ((abs(_gamepad.__get_value(gp_axislv    )) > _player.__axis_threshold_get(gp_axislv    ).__mini) && (abs(_gamepad.__get_delta(gp_axislv    )) > __INPUT_DELTA_HOTSWAP_THRESHOLD))
    ||  ((abs(_gamepad.__get_value(gp_axisrh    )) > _player.__axis_threshold_get(gp_axisrh    ).__mini) && (abs(_gamepad.__get_delta(gp_axisrh    )) > __INPUT_DELTA_HOTSWAP_THRESHOLD))
    ||  ((abs(_gamepad.__get_value(gp_axisrv    )) > _player.__axis_threshold_get(gp_axisrv    ).__mini) && (abs(_gamepad.__get_delta(gp_axisrv    )) > __INPUT_DELTA_HOTSWAP_THRESHOLD)))
    {
        return true;
    }

    return false;
}

