/// @desc    Aborts the binding scan process started by input_binding_scan_start(), if one has been started
/// @param   [playerIndex=0]

function input_binding_scan_abort(_player_index = 0)
{
    __INPUT_GLOBAL_STATIC_LOCAL  //Set static _global
    
    if (_player_index == all)
    {
        var _p = 0;
        repeat(INPUT_MAX_PLAYERS)
        {
            input_binding_scan_abort(_p);
            ++_p;
        }
        
        return;
    }
    
    __INPUT_VERIFY_PLAYER_INDEX
    
    with(_global.__players[_player_index])
    {
        if (__rebind_state > 0) __binding_scan_failure(INPUT_BINDING_SCAN_EVENT.ABORTED);
    }
}