function input_async_system_event()
{
    var _any_changed = false;
    
    __input_trace(json_encode(async_load));
    
    if (async_load[? "event_type"] == "gamepad discovered")
    {
        var _gamepad = async_load[? "pad_index"];
        var _mapping = undefined;
        
        gamepad_test_mapping(_gamepad, "4c05cc09000000000000504944564944,PS4 Controller,a:b1,b:b2,back:b8,dpdown:h0.4,dpleft:h0.8,dpright:h0.2,dpup:h0.1,guide:b13,leftshoulder:b4,leftstick:b10,lefttrigger:a3,leftx:a0,lefty:a1,rightshoulder:b5,rightstick:b11,righttrigger:a4,rightx:a2,righty:a5,start:b9,x:b0,y:b3");
        
        if (is_string(_mapping)) gamepad_test_mapping(_gamepad, _mapping);
    }
    else if (async_load[? "event_type"] == "gamepad lost")
    {
        var _i = 0;
        repeat(INPUT_MAX_PLAYERS)
        {
            with(global.__input_players[_i])
            {
                if ((gamepad == async_load[? "pad_index"]) && (source == INPUT_SOURCE.GAMEPAD))
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