/// @desc    Sets the player device color
/// @param   color
/// @param   [playerIndex=0]

function input_color_set(_color, _player_index = 0)
{
    __input_initialize();
    __INPUT_VERIFY_PLAYER_INDEX
    
    global.__input_players[_player_index].__color_set(_color);
}
