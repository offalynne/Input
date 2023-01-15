/// @desc    Sets the coordinate space for the player's cursor when using mouse input.
///          The coordinate space should be a member of the INPUT_COORD_SPACE enum:
///              .ROOM      Room coordinates; should be the same as mouse_x and mouse_y. This is the default value
///              .GUI       GUI coordinates
///              .DEVICE    Raw device-space coordinates
/// @param   coordSpace
/// @param   [playerIndex=0]

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
    
    with(global.__input_players[_player_index].__cursor)
    {
        if (__coord_space != _coord_space)
        {
            __x = global.__input_pointer_x[_coord_space];
            __y = global.__input_pointer_y[_coord_space];
            
            __prev_x = __x - global.__input_pointer_dx[_coord_space];
            __prev_y = __y - global.__input_pointer_dy[_coord_space];
            
            __coord_space = _coord_space;
        }
    }
}