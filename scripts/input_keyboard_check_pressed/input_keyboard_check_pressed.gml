//param binding
function input_keyboard_check_pressed(_binding)
{
    if (!__INPUT_KEYBOARD_SUPPORT) return 0;
    return keyboard_check_pressed(_binding);
}
