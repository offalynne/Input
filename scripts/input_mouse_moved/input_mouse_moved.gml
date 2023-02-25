/// @desc    Returns whether the mouse has moved between frames

function input_mouse_moved()
{
    __INPUT_GLOBAL_STATIC_LOCAL
    return global.__input_pointer_moved;
}