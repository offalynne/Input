function input_async_system_event()
{
    var _any_changed = false;
    
    if (async_load[? "event_type"] == "gamepad lost")
    {
        var _i = 0;
        repeat(INPUT_MAX_PLAYERS)
        {
            with(global.__input_players[_i])
            {
                if (gamepad == async_load[? "pad_index"] && (source == INPUT_SOURCE.GAMEPAD))
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