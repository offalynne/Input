/// @param button

function input_binding_joycon_button(_button)
{
	__input_initialize();
	
    if ((_button >= gp_guide) && (_button <= gp_paddle4)) __input_error("Extended gamepad binding not permitted for joycons");
    
    if (global.__input_swap_ab)
    {
        if (_button == gp_face1)
        {
            _button = gp_face2;
            __input_trace("Binding swapped from A to B");
        }
        else if (_button == gp_face2)
        {
            _button = gp_face1;
            __input_trace("Binding swapped from B to A");
        }
    }
    
    return (new __input_class_binding()).__set_gamepad_button(_button, true);
}
