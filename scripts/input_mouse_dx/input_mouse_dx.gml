/// @desc    Returns how far the mouse has moved on the x-axis between frames
/// @returns {Real}

function input_mouse_dx()
{
    return global.__input_pointer_dx[global.__input_pointer_coord_space];
}