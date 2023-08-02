// Feather disable all
/// @desc    Returns the current x-coordinate of the active pointer device
///          The coordinate space should be a member of the INPUT_COORD_SPACE enum:
///              .ROOM      Room coordinates; should be the same as mouse_x and mouse_y. This is the default value
///              .GUI       GUI coordinates
///              .DEVICE    Raw device-space coordinates
/// 
/// @param [coordSpace]  Coordinate space to use. If not specified, the coordinate space set by input_mouse_coord_space_set() is used

function input_mouse_x(_coord_space = undefined)
{
    __INPUT_GLOBAL_STATIC_LOCAL  //Set static _global
    return _global.__pointer_x[_coord_space ?? _global.__pointer_coord_space];
}
