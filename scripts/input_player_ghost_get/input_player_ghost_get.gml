/// @desc    Returns whether the player is a ghost
/// @param   [playerIndex=0]

function input_player_ghost_get(_player_index = 0)
{
    static _global = __input_state();
    __INPUT_VERIFY_PLAYER_INDEX
    
    return global.__input_players[_player_index].__ghost;
}
