/// @desc    Returns the y-coordinate of the player's cursor
/// @param   [playerIndex=0]

function input_cursor_y(_player_index = 0)
{
    __INPUT_VERIFY_PLAYER_INDEX
    
    return global.__input_players[_player_index].__cursor.__y;
}