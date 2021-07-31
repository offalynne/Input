function __input_keyboard_key()
{
    if (os_type != os_android) return keyboard_key;

    //Android UTF8
    if (keyboard_check(ord(keyboard_lastchar))) return ord(keyboard_lastchar);

    //Android control
    if (keyboard_check(vk_left     )) return vk_left;
    if (keyboard_check(vk_up       )) return vk_up;
    if (keyboard_check(vk_down     )) return vk_down;
    if (keyboard_check(vk_right    )) return vk_right;
    if (keyboard_check(vk_backspace)) return vk_backspace;

    return 0;
}