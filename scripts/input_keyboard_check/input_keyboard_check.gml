//param binding
function input_keyboard_check(_binding)
{
    if (!__INPUT_KEYBOARD_SUPPORT) return 0;
    return keyboard_check(_binding);
}
