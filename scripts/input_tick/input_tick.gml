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

    //Track Window focus loss and regain (blur is false when focus is true or undefined)
    global.__input_blur_previous = global.__input_blur;
    global.__input_blur = (window_has_focus() == false);    
    
    //Handle mouse button blocking on window focus change
    if (__INPUT_POINTER_SUPPORT && !global.__input_blur)
    {
        if (global.__input_blur_previous)
        {
            //Block mouse buttons on focus regain
            global.__input_mouse_blocked = true;
        }
        else
        {
            //Reevaluate mouse block if focus is sustained
            if (global.__input_mouse_blocked 
            && (!__INPUT_TOUCH_SUPPORT || INPUT_TOUCH_POINTER_ALLOWED))
            {
                var _retain_block = false;
                var _i = 1;
                repeat(5)
                {
                    if (device_mouse_check_button(0, _i))
                    {
                        _retain_block = true;
                        break;
                    }
                    
                    ++_i;
                }
                
                global.__input_mouse_blocked = _retain_block;
            }
        }
    }
    
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
    
    #region Keyboard

    //Text entry
    if (__INPUT_KEYBOARD_SUPPORT || os_type == os_ios) 
    {
        if (!input_string_async_is_active())
        {
            var _string = keyboard_string;

            //Revert overflow
            if ((_string == "") && (string_length(global.__input_keyboard_prev_string) > 1))
            {
                _string = "";
            }
        
            input_string_set(_string);
        }
    }
    
    //Unstick
    if (__INPUT_KEYBOARD_SUPPORT && keyboard_check(vk_anykey))
    {
        var _platform = os_type;
        if (__INPUT_ON_WEB && __INPUT_ON_APPLE) _platform = "apple_web";

        switch (_platform)
        {
            case os_uwp:
                if ((INPUT_IGNORE_RESERVED_KEYS_LEVEL > 0) 
                && keyboard_check(vk_alt) && !keyboard_check_pressed(vk_alt))
                {
                    //Unstick Alt Tab
                    keyboard_key_release(vk_alt);
                }
            //UWP also uses Windows case
            case os_windows:
                if (keyboard_check(vk_alt) && keyboard_check_pressed(vk_space))
                {
                    //Unstick Alt Space
                    keyboard_key_release(vk_alt);
                    keyboard_key_release(vk_space);
                    keyboard_key_release(vk_lalt);
                    keyboard_key_release(vk_ralt);
                }
            break;            
            case "apple_web": //This case applies on iOS, tvOS, and MacOS
                if (keyboard_check_released(92) || keyboard_check_released(93))
                {
                    //Meta release sticks every key pressed during hold
                    //This is "the nuclear option", but the problem is severe
                    var _i = 8;
                    var _len = 255 - _i;
                    repeat(_len)
                    {
                        keyboard_key_release(_i);
                        ++_i;
                    }
                }
            break;                
            case os_macosx:
                //Unstick doubled-up control keys
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
