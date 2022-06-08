/// @desc    Sets the coordinate space for the player's cursor when using mouse input.
///          The coordinate space should be a member of the INPUT_COORD_SPACE enum:
///              .ROOM      Room coordinates; should be the same as mouse_x and mouse_y. This is the default value
///              .GUI       GUI coordinates
///              .DISPLAY   Raw device-space coordinates
/// @param   coordSpace
/// @param   [playerIndex=0]

enum INPUT_COORD_SPACE
{
    ROOM,
    GUI,
    DISPLAY,
    __SIZE
}

function input_cursor_coord_space_set(_coord_space, _player_index = 0)
{
    if (_player_index == all)
    {
        var _p = 0;
        repeat(INPUT_MAX_PLAYERS)
        {
            input_cursor_coord_space_set(_coord_space, _p);
            ++_p;
        }
        
        return;
    }
    
    __INPUT_VERIFY_PLAYER_INDEX
    
    global.__input_players[_player_index].__cursor.__coord_space = _coord_space;
}