/// @desc    Returns whether the mouse has moved between frames

function input_mouse_moved()
{
    __INPUT_GLOBAL_STATIC_LOCAL  //Set static _global
    return (_global.__mouse_allowed && _global.__pointer_moved);
}