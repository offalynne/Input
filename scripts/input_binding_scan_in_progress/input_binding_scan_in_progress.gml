/// @desc    Returns whether the given player is currently scanning for bindings
/// @param   [playerIndex=0]

function input_binding_scan_in_progress(_player_index = 0)
{
    static _global = __input_state();
    __INPUT_VERIFY_PLAYER_INDEX
    
    with(global.__input_players[_player_index])
    {
        return (__rebind_state > 0);
    }
}