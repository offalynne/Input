/// @param x
/// @param y
/// @param [playerIndex=0]

function input_cursor_set(_x, _y, _player_index = 0)
{
    __INPUT_VERIFY_PLAYER_INDEX
    
    return global.__input_players[_player_index].__cursor.__set(_x, _y);
}