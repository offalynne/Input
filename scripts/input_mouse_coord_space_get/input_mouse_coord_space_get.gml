/// @desc    Returns the current mouse coordinate space

function input_mouse_coord_space_get()
{
    __INPUT_GLOBAL_STATIC
    
    return global.__input_pointer_coord_space;
}