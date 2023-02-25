/// @desc    Resets the player device color
/// @param   [playerIndex=0]

function input_color_reset(_player_index = 0)
{
    __INPUT_GLOBAL_STATIC_LOCAL  //Set static _global
    __INPUT_VERIFY_PLAYER_INDEX
    
    _global.__players[_player_index].__color_set(undefined);
}
