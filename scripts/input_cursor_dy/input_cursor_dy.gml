/// @desc    Returns how far the cursor has moved on the y-axis between frames
///          The coordinate space should be a member of the INPUT_COORD_SPACE enum:
///              .ROOM      Room coordinates; should be the same as mouse_x and mouse_y. This is the default value
///              .GUI       GUI coordinates
///              .DEVICE    Raw device-space coordinates
/// 
/// @param   [playerIndex=0]
/// @param   [coordSpace]     Coordinate space to use. If not specified, the coordinate space set by input_cursor_coord_space_set() is used

function input_cursor_dy(_player_index = 0, _output_system = undefined)
{
    __INPUT_GLOBAL_STATIC_LOCAL  //Set static _global
    __INPUT_VERIFY_PLAYER_INDEX
    
    var _cursor = _global.__players[_player_index].__cursor;
    return __input_transform_coordinate(_cursor.__x - _cursor.__prev_x,
                                        _cursor.__y - _cursor.__prev_y,
                                        _cursor.__coord_space,
                                        _output_system ?? _cursor.__coord_space).y;
}