/// @param binding
function input_mouse_check_released(_binding)
{
    return (device_mouse_check_button_released(0, _binding));
}