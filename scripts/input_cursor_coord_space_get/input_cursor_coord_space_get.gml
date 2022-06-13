/// @desc    Returns the coordinate space for the player's cursor when using mouse input
/// @param   [playerIndex=0]

function input_cursor_coord_space_get(_player_index = 0)
{
    __INPUT_VERIFY_PLAYER_INDEX
    
    return global.__input_players[_player_index].__cursor.__coord_space;
}