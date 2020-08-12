function input_async_system_event()
{
    var _any_changed = false;
    
    if (async_load[? "event_type"] == "gamepad discovered")
    {
        //Create a new gamepad handler to manage remapping
        var _gamepad = async_load[? "pad_index"];
        global.__input_gamepads[@ _gamepad] = new __input_class_gamepad(_gamepad);
        
        //TODO - Read SDL bindings
        with(global.__input_gamepads[@ _gamepad])
        {
            if ((vendor == "4c05") && (product == "cc09")) //PS4 controller
            {
                set_mapping(gp_face1     ,  1, "button");
                set_mapping(gp_face2     ,  2, "button");
                set_mapping(gp_face3     ,  0, "button");
                set_mapping(gp_face4     ,  3, "button");
                set_mapping(gp_shoulderl ,  4, "button");
                set_mapping(gp_shoulderr ,  5, "button");
				//6 = Trigger L
				//7 = Trigger R
                set_mapping(gp_select    ,  8, "button");
                set_mapping(gp_start     ,  9, "button");
                set_mapping(gp_stickl    , 10, "button");
                set_mapping(gp_stickr    , 11, "button");
                //12 = Guide
                //13 = Trackpad Click
                set_mapping(gp_axislh    , 0, "axis");
                set_mapping(gp_axislv    , 1, "axis");
                set_mapping(gp_axisrh    , 2, "axis");
                set_mapping(gp_shoulderlb, 3, "axis").limit_range = true;
                set_mapping(gp_shoulderrb, 4, "axis").limit_range = true;
                set_mapping(gp_axisrv    , 5, "axis");
            }
        }
    }
    else if (async_load[? "event_type"] == "gamepad lost")
    {
        //Remove our gamepad handler
        var _gamepad = async_load[? "pad_index"];
        global.__input_gamepads[@ _gamepad] = undefined;
        
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