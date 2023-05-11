/// @desc    Returns whether the given player is currently scanning for bindings
/// @param   [playerIndex=0]

function input_binding_scan_in_progress(_player_index = 0)
{
    __INPUT_GLOBAL_STATIC_LOCAL  //Set static _global
    __INPUT_VERIFY_PLAYER_INDEX
    
    with(_global.__players[_player_index])
    {
        return (__rebind_state > 0);
    }
}