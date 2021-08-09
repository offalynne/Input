//param binding
function input_keyboard_check_released(_binding)
{
    if (!__INPUT_KEYBOARD_SUPPORT) return 0;
    return keyboard_check_released(_binding);
}
