/// @desc    Returns how far the mouse has moved on the y-axis between frames
/// @returns {Real}

function input_mouse_dy()
{
    return global.__input_pointer_dy[global.__input_pointer_coord_space];
}