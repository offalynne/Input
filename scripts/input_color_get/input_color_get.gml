/// @desc    Returns the player device color
/// @param   [playerIndex=0]

function input_color_get(_player_index = 0)
{
    __input_initialize();
    __INPUT_VERIFY_PLAYER_INDEX
    
    return global.__input_players[_player_index].__color;
}