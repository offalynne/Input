/// @desc    Returns whether any of the player’s sources are connected and available for use
/// @param   [playerIndex=0]
/// @param   [includeGhost=true]

function input_player_connected(_player_index = 0, _include_ghost = true)
{
    __INPUT_GLOBAL_STATIC_LOCAL  //Set static _global
    __INPUT_VERIFY_PLAYER_INDEX
    
    with(_global.__players[_player_index])
    {
        return (__connected && (_include_ghost || !__ghost));
    }
}