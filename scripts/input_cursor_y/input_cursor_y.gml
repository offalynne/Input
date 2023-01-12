/// @desc    Returns the y-coordinate of the player's cursor
/// @param   [playerIndex=0]
/// @param   [coordSpace]

function input_cursor_y(_player_index = 0, _outputSystem = global.__input_pointer_coord_space)
{
    __INPUT_VERIFY_PLAYER_INDEX
    
    return __input_transform_coordinate(global.__input_players[_player_index].__cursor.__x,
                                        global.__input_players[_player_index].__cursor.__y,
                                        global.__input_pointer_coord_space,
                                        _outputSystem).y;
}