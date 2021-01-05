function input_async_system_event()
{
    var _any_changed = false;
    
    if (async_load[? "event_type"] == "gamepad discovered")
    {
        //Create a new gamepad handler to manage remapping
        var _gamepad = async_load[? "pad_index"];
        __input_trace("Found gamepad ", _gamepad, " (conn) \"", gamepad_get_description(_gamepad), "\" GUID=", gamepad_get_guid(_gamepad), ". Gamepads array length = ", array_length(global.__input_gamepads));
        
        //FIXME - Workaround for Stadia controller bug maybe? 2020-01-05
        global.__input_gamepads[_gamepad] = new __input_class_gamepad(_gamepad);
    }
    else if (async_load[? "event_type"] == "gamepad lost")
    {
        //Remove our gamepad handler
        var _gamepad = async_load[? "pad_index"];
        __input_trace("Found gamepad ", _gamepad, " (d/c). Gamepads array length = ", array_length(global.__input_gamepads));
        
        //FIXME - Workaround for Stadia controller bug maybe? 2020-01-05
        global.__input_gamepads[_gamepad] = undefined;
        
        //Also report gamepad changes for any active players
        var _i = 0;
        repeat(INPUT_MAX_PLAYERS)
        {
            with(global.__input_players[_i])
            {
                if ((gamepad == _gamepad) && (source == INPUT_SOURCE.GAMEPAD))
                {
                    __input_trace("Player ", _i, " gamepad disconnected");
                    
                    source = INPUT_SOURCE.NONE;
                    _any_changed = true;
                }
            }
            
            ++_i;
        }
    }
    
    return _any_changed;
}