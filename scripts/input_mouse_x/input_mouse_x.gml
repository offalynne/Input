/// @desc    Returns the current x-coordinate of the active pointer device
/// @returns {Real}

function input_mouse_x()
{
    return global.__input_pointer_x[global.__input_pointer_coord_space];
}