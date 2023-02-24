function __input_multiplayer_assignment_tick()
{
    if ((global.__input_multiplayer_leave_verb != undefined) && !variable_struct_exists(global.__input_basic_verb_dict, global.__input_multiplayer_leave_verb))
    {
        __input_error("Multiplayer leave verb \"", global.__input_multiplayer_leave_verb, "\" doesn't exist\n(You should call input_multiplayer_params_set() to set the leave verb)");
    }
    
    var _abort = false;
    
    if (global.__input_multiplayer_drop_down)
    {
        //Drop players down into empty spaces
        do
        {
            var _fail = false;
            var _p = INPUT_MAX_PLAYERS-1;
            repeat(INPUT_MAX_PLAYERS-1)
            {
                if (input_player_connected(_p) && !input_player_connected(_p-1))
                {
                    __input_trace("Assignment: Moving player ", _p, " (connected) to ", _p-1, " (disconnected)");
                    input_player_swap(_p, _p-1);
                    _fail = true;
                }
                
                --_p;
            }
        }
        until (!_fail);
    }
    
    //Disconnect all extraneous players
    var _p = global.__input_multiplayer_max;
    repeat(INPUT_MAX_PLAYERS - global.__input_multiplayer_max)
    {
        input_source_clear(_p);
        ++_p;
    }
    
    //Scan for input for the lowest index slot
    var _p = 0;
    repeat(global.__input_multiplayer_max)
    {
        if (!input_player_connected(_p))
        {
            var _new_source = input_source_detect_new();
            if (_new_source != undefined)
            {
                with(global.__input_players[_p])
                {
                    __source_add(_new_source);
                    __profile_set_auto();
                    tick();
                }
                
                if ((global.__input_multiplayer_leave_verb != undefined)
                &&  input_check_pressed(global.__input_multiplayer_leave_verb)
                &&  (input_player_connected_count() < global.__input_multiplayer_min)
                &&  (global.__input_multiplayer_min > 1)
                &&  (global.__input_multiplayer_abort_callback != undefined))
                {
                    __input_trace("Assignment: Player ", _p, " aborted source assignment");
                    _abort = true;
                }
                else
                {
                    __input_trace("Assignment: Player ", _p, " joined");
                }
                
                //Make sure we don't leak input
                input_verb_consume(all, _p);
            }
        }
        
        ++_p;
    }
    
    //Allow players to leave the game
    var _p = 0;
    repeat(global.__input_multiplayer_max)
    {
        if ((global.__input_multiplayer_leave_verb != undefined) && input_check_pressed(global.__input_multiplayer_leave_verb, _p))
        {
            __input_trace("Assignment: Player ", _p, " left");
            input_source_clear(_p);
        }
        
        ++_p;
    }
    
    if (_abort && (global.__input_multiplayer_abort_callback != undefined))
    {
        __input_trace("Assignment: Restoring source mode ", global.__input_previous_source_mode);
        input_source_mode_set(global.__input_previous_source_mode);
        global.__input_previous_source_mode = global.__input_source_mode;
        
        if (is_method(global.__input_multiplayer_abort_callback))
        {
            global.__input_multiplayer_abort_callback();
        }
        else if (is_numeric(global.__input_multiplayer_abort_callback) && script_exists(global.__input_multiplayer_abort_callback))
        {
            script_execute(global.__input_multiplayer_abort_callback);
        }
        else
        {
            __input_error("Multiplayer abort callback set to an illegal value (typeof=", typeof(global.__input_multiplayer_abort_callback), ")");
        }
    }
    
    return _abort;
}
