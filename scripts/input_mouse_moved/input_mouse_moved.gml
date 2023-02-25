/// @desc    Returns whether the mouse has moved between frames

function input_mouse_moved()
{
    __INPUT_GLOBAL_STATIC_LOCAL
    return _global.__pointer_moved;
}