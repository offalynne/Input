/// @desc    Returns the current mouse coordinate space

function input_mouse_coord_space_get()
{
    static _global = __input_state();
    
    return global.__input_pointer_coord_space;
}