/// @desc    Returns the previous y-coordinate of the player's cursor (in y-coordinate in the previous step)
/// @param   [playerIndex=0]

function input_cursor_previous_y(_player_index = 0)
{
    __INPUT_VERIFY_PLAYER_INDEX
    
    return global.__input_players[_player_index].__cursor.__prev_y;
}