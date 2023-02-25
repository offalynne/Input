/// @desc    Returns the current mouse coordinate space

function input_mouse_coord_space_get()
{
    __INPUT_GLOBAL_STATIC_LOCAL
    
    return _global.__pointer_coord_space;
}