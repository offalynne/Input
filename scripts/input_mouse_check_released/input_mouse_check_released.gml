/// @param binding
function input_mouse_check_released(_binding)
{
    if (global.__input_mouse_blocked) 
    {
        return false;
    }
    
    return (device_mouse_check_button_released(0, _binding));
}