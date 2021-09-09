/// @param binding
function input_mouse_check_released(_binding)
{
    //Disallow mouse input on touch platforms (unless explicitly enabled)
    if ((__INPUT_TOUCH_SUPPORT && !INPUT_TOUCH_MOUSE_ALLOWED) || (os_type == os_xboxone) || (os_type == os_xboxseriesxs))
    {
        return false;
    }
    
    return (device_mouse_check_button_released(0, _binding));
}