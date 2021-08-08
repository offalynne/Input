input_tick();
input_hotswap_tick();

var _size = gamepad_get_device_count();
var _delta = (!__INPUT_ON_DESKTOP && mouse_check_button_pressed(mb_left)) + keyboard_check_pressed(vk_down) - keyboard_check_pressed(vk_up);
test_index = (test_index + _delta + _size) mod max(1, _size);