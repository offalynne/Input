/// @param [sourceFilter]
/// @param [playerIndex=0]



enum INPUT_BINDING_SCAN_EVENT
{
    SUCCESS_THIS_FRAME          = -1,  //input_binding_scan_tick() has been called twice this frame for this player, and the first execution succeeded
    ERROR_THIS_FRAME            = -2,  //input_binding_scan_tick() has been called twice this frame for this player, and the first execution failed due to an error
    SOURCE_INVALID              = -10, //Player source is not rebindable
    SOURCE_CHANGED              = -11, //Player source changed
    //GAMEPAD_CHANGED             = -12, //Gamepad index changed - No longer used 2022-05-03
    //GAMEPAD_INVALID             = -13, //Player gamepad is invalid - No longer used 2022-05-03
    //BINDING_DOESNT_MATCH_SOURCE = -14, //The new binding doesn't match the source that was targetted for rebinding - No longer used 2022-05-03
    PLAYER_IS_GHOST             = -15, //Player has been set as a ghost
    SCAN_TIMEOUT                = -20, //Scanning for a binding timed out - either the player didn't enter a new binding or a stuck key prevented the system from working
    LOST_FOCUS                  = -21, //The game lost focus
}



function input_binding_scan_tick(_source_filter = undefined, _player_index = 0)
{
    __INPUT_VERIFY_PLAYER_INDEX
    
    if (_source_filter == undefined)
    {
        //If no valid source data is provided, use whatever sources the player currently has assigned to them
        _source_filter = global.__input_players[_player_index].__source_array;
    }
    else if (!is_array(_source_filter))
    {
        //If we've been given a basic piece of data, wrap it in an array
        _source_filter = [_source_filter];
    }
    
    with(global.__input_players[_player_index])
    {
        __rebind_this_frame = true;
        
        if (__rebind_state == -2)
        {
            return INPUT_BINDING_SCAN_EVENT.SUCCESS_THIS_FRAME;
        }
        else if (__rebind_state == -1)
        {
            return INPUT_BINDING_SCAN_EVENT.ERROR_THIS_FRAME;
        }
        else if (__rebind_state == 0)
        {
            __rebind_state      = 1;
            __rebind_error      = undefined;
            __rebind_start_time = current_time;
            
            __input_trace("Binding scan started for player ", _player_index);
        }
        else
        {
            #region Error checking
            
            if (__rebind_error != undefined)
            {
                var _error = __rebind_error;
                __rebind_state = -1;
                __rebind_error = undefined;
                return _error;
            }
            
            if (!window_has_focus() || os_is_paused())
            {
                __input_trace("Binding scan failed: Game lost focus");
                __rebind_state = -1;
                return INPUT_BINDING_SCAN_EVENT.LOST_FOCUS;
            }
            
            if (array_length(_source_filter) <= 0)
            {
                __input_trace("Binding scan failed: Source array for player ", _player_index, " is empty (the player has no source assigned)");
                __rebind_state = -1;
                return INPUT_BINDING_SCAN_EVENT.SOURCE_INVALID;
            }
            
            if (__ghost)
            {
                __input_trace("Binding scan failed: Player ", _player_index, " is a ghost");
                __rebind_state = -1;
                return INPUT_BINDING_SCAN_EVENT.PLAYER_IS_GHOST;
            }
            
            if (current_time - __rebind_start_time > INPUT_BINDING_SCAN_TIMEOUT)
            {
                __input_trace("Binding scan failed: Timed out");
                __rebind_state = -1;
                return INPUT_BINDING_SCAN_EVENT.SCAN_TIMEOUT;
            }
            
            #endregion
            
            if (__rebind_state == 1) //Waiting for the player to release all buttons
            {
                if (!__sources_any_input())
                {
                    __input_trace("Now scanning for a new binding from player ", _player_index);
                    __rebind_state = 2;
                }
            }
            else if (__rebind_state == 2) //Now grab the first button pressed
            {
                var _new_binding    = undefined;
                var _binding_source = undefined;
                
                var _i = 0;
                repeat(array_length(_source_filter))
                {
                    if (instanceof(_source_filter[_i]) != "__input_class_source")
                    {
                        __input_error("Value in filter array is not a source (index ", _i, ", ", _source_filter[_i], ")");
                    }
                    
                    var _source_binding = _source_filter[_i].__scan_for_binding();
                    if (_source_binding != undefined)
                    {
                        var _new_binding    = _source_binding;
                        var _binding_source = _source_filter[_i];
                    }
                    
                    ++_i;
                }
                
                if (input_value_is_binding(_new_binding))
                {
                    __input_trace("Binding found for player ", _player_index, ": \"", _new_binding, "\"");
                    __rebind_state = -2;
                    return _new_binding;
                }
            }
        }
    }
    
    return undefined;
}
