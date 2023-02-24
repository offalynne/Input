/// @desc    Starts a binding scan, allowing the player to create new bindings based on what
///          keyboard/mouse/gamepad input they have provided.
///          
///          The success callback is executed when Input received input from the player. The
///          function is executed with a single parameter: the binding that was created by the
///          player. This can then be set to a particular verb.
///          
///          The failure callback, if one is provided, is executed when binding fails for some
///          reason. It is executed with one parameter, the error coded. This corresponds to
///          a member of the INPUT_BINDING_SCAN_EVENT enum:
///              .SOURCE_INVALID         Player’s source is invalid, usually because they have no sources assigned or their gamepad has been disconnected
///              .SOURCE_CHANGED         The player’s source (or sources) have been modified
///              .PLAYER_IS_GHOST        Player is a ghost and cannot receive hardware input
///              .PLAYER_DISCONNECTED    The player disconnected
///              .SCAN_TIMEOUT           Either the player didn’t enter a new binding or a stuck key prevented the system from working. The timeout period is defined by INPUT_BINDING_SCAN_TIMEOUT
///              .LOST_FOCUS             The application lost focus
///              .ABORTED                Binding scan was aborted early due to input_binding_scan_abort() being called
///          
///          A source filter, an array of sources, can be provided to selectively listen for
///          input. This is useful when you wish to scan for input from a specific device.
///          Input from any device NOT listed in the source filter array will be ignored. By
///          default, all sources assigned to the player are accepted.
///          
/// @param   successCallback
/// @param   [failureCallback]
/// @param   [sourceFilter]
/// @param   [playerIndex=0]

enum INPUT_BINDING_SCAN_EVENT
{
    //SUCCESS_THIS_FRAME          = -1,  //input_binding_scan_tick() has been called twice this frame for this player, and the first execution succeeded - No longer used 2022-05-15
    //ERROR_THIS_FRAME            = -2,  //input_binding_scan_tick() has been called twice this frame for this player, and the first execution failed due to an error - No longer used 2022-05-15
    SOURCE_INVALID              = -10, //Player source is not rebindable
    SOURCE_CHANGED              = -11, //Player source changed
    //GAMEPAD_CHANGED             = -12, //Gamepad index changed - No longer used 2022-05-03
    //GAMEPAD_INVALID             = -13, //Player gamepad is invalid - No longer used 2022-05-03
    //BINDING_DOESNT_MATCH_SOURCE = -14, //The new binding doesn't match the source that was targetted for rebinding - No longer used 2022-05-03
    PLAYER_IS_GHOST             = -15, //Player has been set as a ghost
    PLAYER_DISCONNECTED         = -16, //Player disconnected
    SCAN_TIMEOUT                = -20, //Scanning for a binding timed out - either the player didn't enter a new binding or a stuck key prevented the system from working
    LOST_FOCUS                  = -21, //The game lost focus
    ABORTED                     = -30, //Binding scan was aborted before completion using input_binding_scan_abort()
}

function input_binding_scan_start(_success_method, _failure_method = undefined, _source_filter = undefined, _player_index = 0)
{
    __input_initialize();
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
    
    if not (is_method(_success_method) || (is_numeric(_success_method) && script_exists(_success_method)))
    {
        __input_error("Binding scan success callback set to an illegal value (typeof=", typeof(_success_method), ")");
    }
    
    if not (is_method(_failure_method) || (is_numeric(_failure_method) && script_exists(_failure_method)) || (_failure_method == undefined))
    {
        __input_error("Binding scan failure callback set to an illegal value (typeof=", typeof(_failure_method), ")");
    }
    
    with(global.__input_players[_player_index])
    {
        __rebind_state            = 1;
        __rebind_start_time       = global.__input_current_time;
        __rebind_success_callback = _success_method;
        __rebind_failure_callback = _failure_method;
        __rebind_source_filter    = _source_filter;
        
        __input_trace("Binding scan started for player ", _player_index);
    }
}