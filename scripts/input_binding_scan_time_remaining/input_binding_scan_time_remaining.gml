// Feather disable all
/// @desc    Returns the amount of time left on the rebinding operation, in milliseconds
/// @param   [playerIndex=0]

function input_binding_scan_time_remaining(_player_index = 0)
{
    __INPUT_GLOBAL_STATIC_LOCAL  //Set static _global
    __INPUT_VERIFY_PLAYER_INDEX
    
    with(_global.__players[_player_index])
    {
        if (__rebind_state > 0)
        {
            return clamp(INPUT_BINDING_SCAN_TIMEOUT - (__global.__current_time - __rebind_start_time), 0, INPUT_BINDING_SCAN_TIMEOUT);
        }
        else
        {
            return 0;
        }
    }
}
