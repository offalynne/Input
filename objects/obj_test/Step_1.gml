input_tick();
input_hotswap_tick();

var _size = gamepad_get_device_count();
var _delta = (!__INPUT_ON_DESKTOP && input_mouse_check_pressed(mb_left)) + input_keyboard_check_pressed(vk_down) - input_keyboard_check_pressed(vk_up);
test_index = (test_index + _delta + _size) mod max(1, _size);