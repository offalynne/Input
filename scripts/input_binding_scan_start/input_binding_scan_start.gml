// Feather disable all
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
///              .SOURCE_FILTER_EMPTY    Source filter array is empty
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
    SOURCE_FILTER_EMPTY         = -15, //Source filter array is empty
    PLAYER_IS_GHOST             = -15, //Player has been set as a ghost
    PLAYER_DISCONNECTED         = -16, //Player disconnected
    PLAYER_IS_INACTIVE          = -17, //Player has been set to inactive
    SCAN_TIMEOUT                = -20, //Scanning for a binding timed out - either the player didn't enter a new binding or a stuck key prevented the system from working
    LOST_FOCUS                  = -21, //The game lost focus
    ABORTED                     = -30, //Binding scan was aborted before completion using input_binding_scan_abort()
}

function input_binding_scan_start(_success_method, _failure_method = undefined, _player_index = 0)
{
    __INPUT_GLOBAL_STATIC_LOCAL  //Set static _global
    __INPUT_VERIFY_PLAYER_INDEX
    
    if (!is_numeric(_player_index) && !is_undefined(_player_index))
    {
        __input_error("Usage of input_binding_scan_start() has changed. Please refer to documentation for details");
    }
    
    if not (is_method(_success_method) || (is_numeric(_success_method) && script_exists(_success_method)))
    {
        __input_error("Binding scan success callback set to an illegal value (typeof=", typeof(_success_method), ")");
    }
    
    if not (is_method(_failure_method) || (is_numeric(_failure_method) && script_exists(_failure_method)) || (_failure_method == undefined))
    {
        __input_error("Binding scan failure callback set to an illegal value (typeof=", typeof(_failure_method), ")");
    }
    
    with(_global.__players[_player_index])
    {
        __rebind_state            = 1;
        __rebind_start_time       = _global.__current_time;
        __rebind_success_callback = _success_method;
        __rebind_failure_callback = _failure_method;
        
        __input_trace("Binding scan started for player ", _player_index);
    }
}
