function input_tick()
{
    var _any_changed = false;
    
    global.__input_frame++;
    
    #region Mouse
    
    var _mouse_x = 0;
    var _mouse_y = 0;
    
    switch(INPUT_MOUSE_MODE)
    {
        case 0:
            _mouse_x = device_mouse_x(0);
            _mouse_y = device_mouse_y(0);
        break;
        
        case 1:
            _mouse_x = device_mouse_x_to_gui(0);
            _mouse_y = device_mouse_y_to_gui(0);
        break;
        
        case 2:
            _mouse_x = device_mouse_raw_x(0);
            _mouse_y = device_mouse_raw_y(0);
        break;
        
        default:
            __input_error("Invalid mouse mode (", INPUT_MOUSE_MODE, ")");
        break;
    }
    
    global.__input_mouse_moved = (point_distance(_mouse_x, _mouse_y, global.__input_mouse_x, global.__input_mouse_y) > INPUT_MOUSE_MOVE_DEADZONE);
    global.__input_mouse_x = _mouse_x;
    global.__input_mouse_y = _mouse_y;
    
    //Windows mouse extensions
    global.__input_tap_click = false;
    if (os_type == os_windows)
    {
        //Track clicks from touchpad and touchscreen taps (system-setting dependent)
        //N.B. Fix *not* needed in UWP
        global.__input_tap_presses  += device_mouse_check_button_pressed( 0, mb_left);
        global.__input_tap_releases += device_mouse_check_button_released(0, mb_left);
    
        //Resolve press/release desync (where press failed to register on same frame as release)
        if (global.__input_tap_releases >= global.__input_tap_presses)
        {
            global.__input_tap_click    = (global.__input_tap_releases > global.__input_tap_presses);
            global.__input_tap_presses  = 0;
            global.__input_tap_releases = 0;
        }
    }
    
    #endregion
    
    #region Update keyboard

    if (__INPUT_KEYBOARD_SUPPORT)
    {
        //Compare keyboard string contents to prior state
        var _prev = global.__input_prev_keyboard_string;
        if ((keyboard_string == "")                    //Empty
        || (keyboard_string == _prev)                  //Unchanged
        || (string_pos(keyboard_string, _prev) == 1))  //Substring
        {
            global.__input_this_keyboard_string = "";
        }
        else
        {
            //Find previous keyboard string contents in the current state
            var _pos = string_pos(global.__input_prev_keyboard_string, keyboard_string);
            if (_pos == 0)
            {
                //Keyboard string contents are wholly additive
                global.__input_this_keyboard_string = keyboard_string;
            }
            else if (_pos == 1)
            {
                //Keyboard string contents are partially additive
                global.__input_this_keyboard_string = string_copy(keyboard_string, string_length(_prev) + 1, string_length(keyboard_string));
            }
        }
        
        //Update internal strings
        global.__input_prev_keyboard_string = keyboard_string;
        if (global.__input_this_keyboard_string != "")
        {
            global.__input_keyboard_string += global.__input_this_keyboard_string;
        }
        else if keyboard_check_pressed(vk_backspace)
        {
            global.__input_keyboard_string = string_delete(global.__input_keyboard_string, string_length(global.__input_keyboard_string), 1);
        }
        
        //Handle key sticking
        if (keyboard_check(vk_anykey))
        {
            var _platform = os_type
            if (__INPUT_ON_WEB && __INPUT_ON_APPLE) _platform = "apple_browser";
                
            switch (_platform)
            {
                case os_windows:
                case os_uwp:
                    //Unstick Alt Space
                    if (keyboard_check(vk_alt) && keyboard_check_pressed(vk_space))
                    {
                        keyboard_key_release(vk_alt);
                        keyboard_key_release(vk_space);
                        keyboard_key_release(vk_lalt);
                        keyboard_key_release(vk_ralt);
                    }
                break;
                
                case "apple_browser":
                    //Meta release sticks every key pressed during hold
                    //This is "the nuclear option", but the problem is severe and io_clear does not fix it
                    if (keyboard_check_released(92) || keyboard_check_released(93))
                    {
                        //Release all
                        var _i = 8;
                        repeat(247)
                        {
                            keyboard_key_release(_i);
                            _i++;
                        }
                    }
                break;
                
                case os_macosx:
                    //Unstick control key double-up
                    if (keyboard_check_released(vk_control))
                    {
                        keyboard_key_release(vk_lcontrol);
                        keyboard_key_release(vk_rcontrol);
                    }
            
                    if (keyboard_check_released(vk_shift))
                    {
                        keyboard_key_release(vk_lshift);
                        keyboard_key_release(vk_rshift);
                    }
            
                    if (keyboard_check_released(vk_alt))
                    {
                        keyboard_key_release(vk_lalt);
                        keyboard_key_release(vk_ralt);
                    }
            
                    //Unstick Meta
                    //Weird, but seems to be the best way to unstick without spoiling normal operation
                    if (keyboard_check_released(vk_meta1))
                    {
                        keyboard_key_release(vk_meta2);
                    }
                    else if (keyboard_check_released(vk_meta2) && keyboard_check(vk_meta1))
                    {
                        keyboard_key_release(vk_meta1);
                    }
                break;
            }
        }
    }
    
    #endregion
    
    #region Update gamepads
    
    //Expand dynamic device count
    var _device_change = max(0, gamepad_get_device_count() - array_length(global.__input_gamepads))
    repeat(_device_change) array_push(global.__input_gamepads, undefined);
    
    var _g = 0;
    repeat(array_length(global.__input_gamepads))
    {
        var _gamepad = global.__input_gamepads[_g];
        if (is_struct(_gamepad))
        {
            if (gamepad_is_connected(_g))
            {
                if (os_type == os_switch)
                {
                    //When L+R assignment is used to pair two gamepads we won't see a normal disconnection/reconnection
                    //Instead we have to check for changes in the description to see if state has changed
                    if (_gamepad.description != gamepad_get_description(_g))
                    {
                        _gamepad.discover();
                    }
                    else
                    {
                        _gamepad.tick();
                    }
                }
                else
                {
                    _gamepad.tick();
                }
            }
            else
            {
                //Remove our gamepad handler
                __input_trace("Gamepad ", _g, " disconnected");
                
                global.__input_gamepads[@ _g] = undefined;
                
                //Also report gamepad changes for any active players
                var _p = 0;
                repeat(INPUT_MAX_PLAYERS)
                {
                    with(global.__input_players[_p])
                    {
                        if ((gamepad == _gamepad) && (source == INPUT_SOURCE.GAMEPAD))
                        {
                            __input_trace("Player ", _p, " gamepad disconnected");
                            
                            source = INPUT_SOURCE.NONE;
                            _any_changed = true;
                        }
                    }
                    
                    ++_p;
                }
            }
        }
        else
        {
            if (gamepad_is_connected(_g))
            {
                __input_trace("Gamepad ", _g, " connected");
                __input_trace("New gamepad = \"", gamepad_get_description(_g), "\", GUID=\"", gamepad_get_guid(_g), "\"");
                
                global.__input_gamepads[@ _g] = new __input_class_gamepad(_g);
            }
        }
        
        ++_g;
    }
    
    #endregion
    
    var _p = 0;
    repeat(INPUT_MAX_PLAYERS)
    {
        global.__input_players[_p].tick();
        ++_p;
    }
    
    return _any_changed;
}
