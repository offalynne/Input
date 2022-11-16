/// @desc    Returns the previous x-coordinate of the player's cursor (in x-coordinate in the previous step)
/// @param   [playerIndex=0]

function input_cursor_previous_x(_player_index = 0)
{
    __INPUT_VERIFY_PLAYER_INDEX
    
    return global.__input_players[_player_index].__cursor.__prev_x;
}