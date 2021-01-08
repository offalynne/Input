function input_tick()
{
    var _any_changed = false;
    
    global.__input_frame++;
    
    global.__input_mouse_moved = (point_distance(display_mouse_get_x(), display_mouse_get_y(), global.__input_mouse_x, global.__input_mouse_y) > INPUT_MOUSE_MOVE_DEADZONE);
    global.__input_mouse_x = display_mouse_get_x();
    global.__input_mouse_y = display_mouse_get_y();
    
    var _g = 0;
    repeat(array_length(global.__input_gamepads))
    {
        var _gamepad = global.__input_gamepads[_g];
        if (is_struct(_gamepad))
        {
            if (gamepad_is_connected(_g))
            {
                _gamepad.tick();
            }
            else
            {
                //Remove our gamepad handler
                __input_trace("Gamepad ", _g, " disconnected");
                
                //FIXME - Workaround for Stadia controller bug maybe? 2020-01-05
                global.__input_gamepads[_g] = undefined;
                
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
                
                //FIXME - Workaround for Stadia controller bug maybe? 2020-01-05
                global.__input_gamepads[_g] = new __input_class_gamepad(_g);
            }
        }
        
        ++_g;
    }
    
    var _p = 0;
    repeat(INPUT_MAX_PLAYERS)
    {
        global.__input_players[_p].tick();
        ++_p;
    }
    
    return _any_changed;
}