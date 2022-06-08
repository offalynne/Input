/// @desc    Returns the current mouse coordinate space

function input_mouse_coord_space_get()
{
    __input_initialize();
    
    return global.__input_pointer_coord_space;
}