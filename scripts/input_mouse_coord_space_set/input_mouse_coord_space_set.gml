/// @desc    Sets the coordinate space for the mouse to operate in
///          The coordinate space should be a member of the INPUT_COORD_SPACE enum:
///              .ROOM      Room coordinates; should be the same as mouse_x and mouse_y. This is the default value
///              .GUI       GUI coordinates
///              .DISPLAY   Raw device-space coordinates
/// @param   coordSpace

function input_mouse_coord_space_set(_coord_space)
{
    __input_initialize();
    
    global.__input_pointer_coord_space = _coord_space;
}