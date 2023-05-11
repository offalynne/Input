/// @desc    Returns whether any of the player’s sources are connected and available for use
/// @param   [playerIndex=0]

function input_player_connected(_player_index = 0)
{
    __INPUT_GLOBAL_STATIC_LOCAL  //Set static _global
    __INPUT_VERIFY_PLAYER_INDEX
    
    return _global.__players[_player_index].__connected;
}