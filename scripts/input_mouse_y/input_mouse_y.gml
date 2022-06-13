/// @desc    Returns the current y-coordinate of the active pointer device

function input_mouse_y()
{
    return global.__input_pointer_y[global.__input_pointer_coord_space];
}