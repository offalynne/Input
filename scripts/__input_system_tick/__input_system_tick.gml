function __input_system_tick()
{
    global.__input_frame++;
    global.__input_previous_current_time = global.__input_current_time;
    global.__input_current_time = current_time;
    global.__input_cleared = false;

    #region Touch
    
    if (__INPUT_TOUCH_SUPPORT && INPUT_TOUCH_POINTER_ALLOWED)
    {
        if (__INPUT_ON_PS)
        {
            //Use first touch (of 2) on active PlayStation gamepad
            var _gamepad = input_player_get_gamepad();
            if (_gamepad >= 0 && _gamepad < 4)
            {
                global.__input_pointer_index = _gamepad * 2;
                global.__input_pointer_pressed  = gamepad_button_check_pressed(_gamepad, gp_select);
                global.__input_pointer_released = gamepad_button_check_released(_gamepad, gp_select);
            }
        }
        else
        {
            var _touch_index = undefined;
            var _touch_press_index = global.__input_pointer_pressed_index;
    
            //Track contact duration per index
            var _i = 0;
            repeat(INPUT_MAX_TOUCHPOINTS)
            {
                if (!device_mouse_check_button(_i, mb_left))
                {
                    global.__input_pointer_durations[_i] = 0;
                }
                else
                {
                    //Get recent active touch
                    global.__input_pointer_durations[_i] += delta_time;
                    if ((_touch_index == undefined) || (global.__input_pointer_durations[_i] < global.__input_pointer_durations[_touch_index]))
                    {
                        _touch_index = _i;
                    }
                }
    
                _i++;
            }
        
            //Set active pointer index
            if (_touch_index == undefined) _touch_index = 0;
            global.__input_pointer_pressed = device_mouse_check_button_pressed(_touch_index, mb_left);
            global.__input_pointer_released = ((_touch_press_index != undefined) && device_mouse_check_button_released(_touch_press_index, mb_left));

            //Touch edge testing
            var _w = display_get_gui_width();
            var _h = display_get_gui_height();
            if (INPUT_TOUCH_EDGE_DEADZONE > 0)
            {
                //Release
                if (global.__input_pointer_released)
                {
                    var _tx = device_mouse_x_to_gui(_touch_press_index);
                    var _ty = device_mouse_y_to_gui(_touch_press_index);
    
                    if ((_tx < INPUT_TOUCH_EDGE_DEADZONE) || (_tx > (_w - INPUT_TOUCH_EDGE_DEADZONE))
                    ||  (_ty < INPUT_TOUCH_EDGE_DEADZONE) || (_ty > (_h - INPUT_TOUCH_EDGE_DEADZONE)))
                    {
                        global.__input_pointer_released = false;
                    }
                }
        
                //Press
                if (global.__input_pointer_pressed)
                {
                    var _tx = device_mouse_x_to_gui(_touch_index);
                    var _ty = device_mouse_y_to_gui(_touch_index);

                    if ((_tx < INPUT_TOUCH_EDGE_DEADZONE) || (_tx > (_w - INPUT_TOUCH_EDGE_DEADZONE))
                    ||  (_ty < INPUT_TOUCH_EDGE_DEADZONE) || (_ty > (_h - INPUT_TOUCH_EDGE_DEADZONE)))
                    {
                        global.__input_pointer_pressed = false;
                    }
                }
            }
    
            //Update state
            global.__input_pointer_index = _touch_index;
            if (global.__input_pointer_pressed)  global.__input_pointer_pressed_index = _touch_index;
            if (global.__input_pointer_released) global.__input_pointer_pressed_index = undefined;
        }
    }
    
    #endregion
    
    
    
    #region Window focus
    
    if (__INPUT_ON_DESKTOP && !__INPUT_ON_WEB)
    {
        if (os_is_paused())
        {
            //Lost focus
            global.__input_window_focus = false;
            
            //Linux app continues to recieve input some number of frames after focus loss
            //Clear IO on focus loss to prevent false positive of subsequent focus regain
            io_clear();
            
            __input_gamepad_stop_trigger_effects(all);
        }
        else
        {
            if (global.__input_window_focus)
            {
                if (global.__input_window_focus_block_mouse)
                {
                    //Unblock so we can test for a held mouse button
                    global.__input_window_focus_block_mouse = false;
                
                    //Sustain mouse block while a button remains held
                    if (__input_mouse_button() != mb_none) global.__input_window_focus_block_mouse = true;
                }
                
                if (global.__input_window_focus_gamepad_timeout > 0)
                {                    
                    --global.__input_window_focus_gamepad_timeout;
                }
            }
            else if ((keyboard_key != vk_nokey) 
                 ||  (mouse_button != mb_none)
                 ||  ((os_type == os_windows) && window_has_focus())
                 ||  ((os_type == os_macosx) && global.__input_pointer_moved))
            {
                //Regained focus
                global.__input_window_focus = true;
                
                //Timeout gamepad
                global.__input_window_focus_gamepad_timeout = 2;
                
                //Block mouse button input
                if (!INPUT_ALLOW_OUT_OF_FOCUS) global.__input_window_focus_block_mouse = true;
                    
                //Retrigger mouse capture timer to avoid the mouse jumping all over the place when we refocus the window
                if (global.__input_mouse_capture) global.__input_mouse_capture_frame = global.__input_frame;
                
                __input_player_apply_trigger_effects(all);
            }
        }
    }
    
    #endregion
    
    
    
    #region Mouse
    
    var _moved = false;    
    var _m = 0;
    repeat(INPUT_COORD_SPACE.__SIZE)
    {
        global.__input_pointer_dx[@ _m] = 0;
        global.__input_pointer_dy[@ _m] = 0;
        ++_m;
    }
    
    __input_release_multimonitor_cursor();
    
    if (global.__input_mouse_capture)
    {
        if (global.__input_window_focus)
        {
            if (global.__input_frame - global.__input_mouse_capture_frame > 10)
            {
                var _m = 0;
                repeat(INPUT_COORD_SPACE.__SIZE)
                {
                    switch(_m)
                    {
                        case INPUT_COORD_SPACE.ROOM:
                            if (view_enabled && view_visible[0])
                            {
                                var _camera = view_camera[0];
                                var _old_x = camera_get_view_width(_camera)/2;
                                var _old_y = camera_get_view_height(_camera)/2;
                            }
                            else
                            {
                                var _old_x = room_width/2;
                                var _old_y = room_height/2;
                            }
                            
                            var _pointer_x = device_mouse_x(global.__input_pointer_index);
                            var _pointer_y = device_mouse_y(global.__input_pointer_index);
                        break;
                        
                        case INPUT_COORD_SPACE.GUI:
                            var _old_x     = display_get_gui_width()/2;
                            var _old_y     = display_get_gui_height()/2;
                            var _pointer_x = device_mouse_x_to_gui(global.__input_pointer_index);
                            var _pointer_y = device_mouse_y_to_gui(global.__input_pointer_index);
                        break;
                        
                        case INPUT_COORD_SPACE.DEVICE:
                            var _old_x = window_get_width()/2;
                            var _old_y = window_get_height()/2;
                            
                            if (os_type == os_windows)
                            {
                                _pointer_x = display_mouse_get_x() - window_get_x();
                                _pointer_y = display_mouse_get_y() - window_get_y();  
                            }
                            else
                            {
                                _pointer_x = device_mouse_raw_x(global.__input_pointer_index);
                                _pointer_y = device_mouse_raw_y(global.__input_pointer_index);
                            }
                        break;
                    }
                    
                    var _dx = (_pointer_x - _old_x)*global.__input_mouse_capture_sensitivity;
                    var _dy = (_pointer_y - _old_y)*global.__input_mouse_capture_sensitivity;
                    
                    //Only detect movement in the display coordinate space so that moving a room's view, or moving the window, doesn't trigger movement
                    if ((_m == INPUT_COORD_SPACE.DEVICE) && (_dx*_dx + _dy*_dy > INPUT_MOUSE_MOVE_DEADZONE*INPUT_MOUSE_MOVE_DEADZONE)) _moved = true;
                    
                    global.__input_pointer_dx[@ _m] = _dx;
                    global.__input_pointer_dy[@ _m] = _dy;
                    
                    global.__input_pointer_x[@ _m] += _dx;
                    global.__input_pointer_y[@ _m] += _dy;
                    
                    ++_m;
                }
            }
            
            //Recenter mouse cursor
            window_mouse_set(window_get_width()/2, window_get_height()/2);
        }
    }
    else if (global.__input_window_focus || INPUT_ALLOW_OUT_OF_FOCUS || (os_type == os_macosx))
    {
        var _m = 0;
        repeat(INPUT_COORD_SPACE.__SIZE)
        {
            var _old_x = global.__input_pointer_x[_m];
            var _old_y = global.__input_pointer_y[_m];
            var _pointer_x = _old_x;
            var _pointer_y = _old_y;
            
            switch(_m)
            {
                case INPUT_COORD_SPACE.ROOM:
                    _pointer_x = device_mouse_x(global.__input_pointer_index);
                    _pointer_y = device_mouse_y(global.__input_pointer_index);
                break;
                
                case INPUT_COORD_SPACE.GUI:
                    _pointer_x = device_mouse_x_to_gui(global.__input_pointer_index);
                    _pointer_y = device_mouse_y_to_gui(global.__input_pointer_index);
                break;
                
                case INPUT_COORD_SPACE.DEVICE:
                    if (os_type == os_windows)
                    {
                        _pointer_x = display_mouse_get_x() - window_get_x();
                        _pointer_y = display_mouse_get_y() - window_get_y();  
                    }
                    else
                    {
                        _pointer_x = device_mouse_raw_x(global.__input_pointer_index);
                        _pointer_y = device_mouse_raw_y(global.__input_pointer_index);
                    }
                break;
            }
            
            //Only detect movement in the display coordinate space so that moving a room's view, or moving the window, doesn't trigger movement
            if ((_m == INPUT_COORD_SPACE.DEVICE) && (point_distance(_old_x, _old_y, _pointer_x, _pointer_y) > INPUT_MOUSE_MOVE_DEADZONE)) _moved = true;
            
            global.__input_pointer_dx[@ _m] = _pointer_x - _old_x;
            global.__input_pointer_dy[@ _m] = _pointer_y - _old_y;
            
            global.__input_pointer_x[@ _m] = _pointer_x;
            global.__input_pointer_y[@ _m] = _pointer_y;
            
            ++_m;
        }
    }
    
    global.__input_pointer_moved = _moved;
    
    global.__input_tap_click = false;    
    if (os_type == os_windows)
    {
        //Track clicks from touchpad and touchscreen taps (system-setting dependent)
        global.__input_tap_presses  += device_mouse_check_button_pressed( 0, mb_left);
        global.__input_tap_releases += device_mouse_check_button_released(0, mb_left);

        if (global.__input_tap_releases >= global.__input_tap_presses)
        {
            //Resolve press/release desync (where press failed to register on same frame as release)
            global.__input_tap_click    = (global.__input_tap_releases > global.__input_tap_presses);
            global.__input_tap_presses  = 0;
            global.__input_tap_releases = 0;
        }
    }
    
    #endregion
    
    
    
    #region Keyboard
    
    //Unstick
    if (global.__input_keyboard_allowed && keyboard_check(vk_anykey))
    {
        var _platform = os_type;
        if (__INPUT_ON_WEB && __INPUT_ON_APPLE) _platform = "apple_web";

        switch (_platform)
        {
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
                if (keyboard_check_released(vk_lmeta))
                {
                    keyboard_key_release(vk_rmeta);
                }
                else if (keyboard_check_released(vk_rmeta) && keyboard_check(vk_lmeta))
                {
                    keyboard_key_release(vk_lmeta);
                }
            break;
        }
    }
    
    #endregion
    
    
    
    #region Gamepads
    
    var _steam_handles_changed = false;
    if (global.__input_using_steamworks)
    {
        steam_input_run_frame();
        _steam_handles_changed = __input_steam_handles_changed();        
        global.__input_steam_handles = steam_input_get_connected_controllers();
    }
    
    if (global.__input_frame > __INPUT_GAMEPADS_TICK_PREDELAY)
    {
        //Expand dynamic device count
        var _device_change = max(0, gamepad_get_device_count() - array_length(global.__input_gamepads));
        repeat(_device_change) array_push(global.__input_gamepads, undefined);
        
        var _device_change = max(0, gamepad_get_device_count() - array_length(INPUT_GAMEPAD));
        repeat(_device_change)
        {
            array_push(INPUT_GAMEPAD, new __input_class_source(__INPUT_SOURCE.GAMEPAD, array_length(INPUT_GAMEPAD)));
            
            if ((global.__input_source_mode == INPUT_SOURCE_MODE.MIXED) || (global.__input_source_mode == INPUT_SOURCE_MODE.MULTIDEVICE))
            {
                global.__input_players[0].__source_add(INPUT_GAMEPAD[array_length(INPUT_GAMEPAD)-1]);
            }
        }
        
        var _g = 0;
        repeat(array_length(global.__input_gamepads))
        {
            var _gamepad = global.__input_gamepads[_g];
            if (is_struct(_gamepad))
            {
                if (gamepad_is_connected(_g))
                {
                    if ((os_type == os_switch) && (_gamepad.description != gamepad_get_description(_g)))
                    {
                        //When Switch L+R assignment is used to pair two gamepads we won't see a normal disconnection/reconnection
                        //Instead we have to check for changes in the description to see if state has changed
                        _gamepad.discover();
                    }
                    else
                    {
                        if (_steam_handles_changed) 
                        {
                            _gamepad.virtual_set();
                        }
                        
                        _gamepad.tick();
                    }
                }
                else
                {
                    //Remove our gamepad handler
                    __input_trace("Gamepad ", _g, " disconnected");
                    
                    gamepad_set_vibration(global.__input_gamepads[@ _g].index, 0, 0);
                    global.__input_gamepads[@ _g] = undefined;
                    
                    if ((global.__input_source_mode != INPUT_SOURCE_MODE.MIXED) && (global.__input_source_mode != INPUT_SOURCE_MODE.MULTIDEVICE))
                    {
                        //Also report gamepad changes for any active players
                        var _p = 0;
                        repeat(INPUT_MAX_PLAYERS)
                        {
                            with(global.__input_players[_p])
                            {
                                if (__source_contains(INPUT_GAMEPAD[_g]))
                                {
                                    __input_trace("Player ", _p, " gamepad disconnected");
                                    __source_remove(INPUT_GAMEPAD[_g]);
                                }
                            }
                            
                            ++_p;
                        }
                    }
                }
            }
            else
            {
                if (gamepad_is_connected(_g))
                {
                    __input_trace("Gamepad ", _g, " connected");
                    __input_trace("New gamepad = \"", gamepad_get_description(_g), "\", GUID=\"", gamepad_get_guid(_g), "\", buttons = ", gamepad_button_count(_g), ", axes = ", gamepad_axis_count(_g), ", hats = ", gamepad_hat_count(_g));
                    
                    global.__input_gamepads[@ _g] = new __input_class_gamepad(_g);
                }
            }
            
            ++_g;
        }
    }
    
    #endregion
    
    
    
    #region Players
    
    var _p = 0;
    repeat(INPUT_MAX_PLAYERS)
    {
        global.__input_players[_p].tick();
        ++_p;
    }
    
    #endregion
    
    
    
    #region Virtual Buttons
    
    //Reorder virtual buttons if necessary, from highest priority to lowest
    if (global.__input_virtual_order_dirty)
    {
        //Clean up any destroyed virtual buttons
        var _i = 0;
        repeat(array_length(global.__input_virtual_array))
        {
            if (global.__input_virtual_array[_i].__destroyed)
            {
                array_delete(global.__input_virtual_array, _i, 1);
            }
            else
            {
                ++_i;
            }
        }
        
        global.__input_virtual_order_dirty = false;
        array_sort(global.__input_virtual_array, function(_a, _b)
        {
            return _a.__priority - _b.__priority;
        });
    }
    
    if (is_struct(global.__input_touch_player))
    {
        //Detect any new touch points and find the top-most button to handle it
        var _i = 0;
        repeat(INPUT_MAX_TOUCHPOINTS)
        {
            if (device_mouse_check_button_pressed(_i, mb_left))
            {
                var _j = 0;
                repeat(array_length(global.__input_virtual_array))
                {
                    if (global.__input_virtual_array[_j].__capture_touchpoint(_i)) break;
                    ++_j;
                }
            }
            
            ++_i;
        }
        
        //Update any virtual buttons that are currently being interacted with
        var _i = 0;
        repeat(array_length(global.__input_virtual_array))
        {
            global.__input_virtual_array[_i].__tick();
            ++_i;
        }
    }
    
    #endregion
    
    
    
    #region Players status struct
    
    var _any_players_changed = false;
    
    var _connection_array    = global.__input_players_status.new_connections;
    var _disconnection_array = global.__input_players_status.new_disconnections;
    var _status_array        = global.__input_players_status.players;
    
    array_resize(_connection_array,    0);
    array_resize(_disconnection_array, 0);
    
    var _p = 0;
    repeat(INPUT_MAX_PLAYERS)
    {
        var _old_status = _status_array[_p];
        
        if (global.__input_players[_p].__connected)
        {
            if ((_old_status == INPUT_STATUS.NEWLY_DISCONNECTED) || (_old_status == INPUT_STATUS.DISCONNECTED))
            {
                _any_players_changed = true;
                _status_array[@ _p] = INPUT_STATUS.NEWLY_CONNECTED;
                array_push(global.__input_players_status.new_connections, _p);
            }
            else
            {
                _status_array[@ _p] = INPUT_STATUS.CONNECTED;
            }
        }
        else
        {
            if ((_old_status == INPUT_STATUS.NEWLY_CONNECTED) || (_old_status == INPUT_STATUS.CONNECTED))
            {
                _any_players_changed = true;
                _status_array[@ _p] = INPUT_STATUS.NEWLY_DISCONNECTED;
                array_push(global.__input_players_status.new_disconnections, _p);
            }
            else
            {
                _status_array[@ _p] = INPUT_STATUS.DISCONNECTED;
            }
        }
        
        ++_p;
    }
    
    global.__input_players_status.any_changed = _any_players_changed;
    
    #endregion
    
    
    
    #region Gamepads status struct
    
    var _any_gamepads_changed = false;
    
    var _connection_array    = global.__input_gamepads_status.new_connections;
    var _disconnection_array = global.__input_gamepads_status.new_disconnections;
    var _status_array        = global.__input_gamepads_status.gamepads;
    
    array_resize(_connection_array,    0);
    array_resize(_disconnection_array, 0);
    
    var _device_count = gamepad_get_device_count();
    if (array_length(_status_array) != _device_count)
    {
        //Resize the gamepad status array if the total device count has changed
        //This should be rare but we need to cover it anyway
        //array_resize() fills new array elements with zeroes but leaves old array values untouched
        //Since INPUT_STATUS.DISCONNECTED === 0 this means new gamepads initialize as disconnected
        array_resize(_status_array, _device_count);
    }
    
    var _g = 0;
    repeat(_device_count)
    {
        var _old_status = _status_array[_g];
        
        if (input_gamepad_is_connected(_g))
        {
            if ((_old_status == INPUT_STATUS.NEWLY_DISCONNECTED) || (_old_status == INPUT_STATUS.DISCONNECTED))
            {
                _any_gamepads_changed = true;
                _status_array[@ _g] = INPUT_STATUS.NEWLY_CONNECTED;
                array_push(_connection_array, _g);
            }
            else
            {
                _status_array[@ _g] = INPUT_STATUS.CONNECTED;
            }
        }
        else
        {
            if ((_old_status == INPUT_STATUS.NEWLY_CONNECTED) || (_old_status == INPUT_STATUS.CONNECTED))
            {
                _any_gamepads_changed = true;
                _status_array[@ _g] = INPUT_STATUS.NEWLY_DISCONNECTED;
                array_push(_disconnection_array, _g);
            }
            else
            {
                _status_array[@ _g] = INPUT_STATUS.DISCONNECTED;
            }
        }
        
        ++_g;
    }
    
    global.__input_gamepads_status.any_changed = _any_gamepads_changed;
    
    #endregion
    
    
    
    switch(global.__input_source_mode)
    {
        case INPUT_SOURCE_MODE.FIXED:       /* Do nothing! */                      break;
        case INPUT_SOURCE_MODE.JOIN:        __input_multiplayer_assignment_tick(); break;
        case INPUT_SOURCE_MODE.HOTSWAP:     __input_hotswap_tick();                break;
        case INPUT_SOURCE_MODE.MIXED:                                              break;
        case INPUT_SOURCE_MODE.MULTIDEVICE:                                        break;
    }
}
