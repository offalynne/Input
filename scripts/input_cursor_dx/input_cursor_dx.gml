/// @desc    Returns the change in the x-coordinate of the player's cursor (the difference between the current x-coordinate and that in the previous step)
///          The coordinate space should be a member of the INPUT_COORD_SPACE enum:
///              .ROOM      Room coordinates; should be the same as mouse_x and mouse_y. This is the default value
///              .GUI       GUI coordinates
///              .DEVICE    Raw device-space coordinates
/// 
/// @param   [playerIndex=0]
/// @param   [coordSpace]     Coordinate space to use. If not specified, the coordinate space set by input_cursor_coord_space_set() is used

function input_cursor_dx(_player_index = 0, _outputSystem = undefined)
{
    return input_cursor_x(_player_index, _outputSystem) - input_cursor_previous_x(_player_index, _outputSystem);
}