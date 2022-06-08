/// @desc  Sets the coordinate space for the mouse to operate in
/// @param coordSpace

function input_mouse_coord_space_set(_coord_space)
{
    __input_initialize();
    
    global.__input_pointer_coord_space = _coord_space;
}