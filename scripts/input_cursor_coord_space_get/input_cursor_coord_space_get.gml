/// @param [playerIndex=0]

function input_cursor_coord_space_get(_player_index)
{
    __INPUT_VERIFY_PLAYER_INDEX
    
    return global.__input_players[_player_index].__cursor.__coord_space;
}