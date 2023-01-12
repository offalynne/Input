/// @desc    Returns the previous x-coordinate of the player's cursor (the x-coordinate in the previous step)
/// @param   [playerIndex=0]
/// @param   [coordSpace]

function input_cursor_previous_x(_player_index = 0, _outputSystem = global.__input_pointer_coord_space)
{
    __INPUT_VERIFY_PLAYER_INDEX
    
    return __input_transform_coordinate(global.__input_players[_player_index].__cursor.__prev_x,
                                        global.__input_players[_player_index].__cursor.__prev_y,
                                        global.__input_pointer_coord_space,
                                        _outputSystem).x;
}