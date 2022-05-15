/// @param [coordSpace]
/// @param [playerIndex=0]

enum INPUT_COORD_SPACE
{
    ROOM,
    GUI,
    DISPLAY,
}

function input_cursor_coord_space_get(_coord_space, _player_index)
{
    __INPUT_VERIFY_PLAYER_INDEX
    
    global.__input_players[_player_index].__cursor.__coord_space = _coord_space;
}