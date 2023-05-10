if input_mouse_check_pressed(mb_left)       input_mouse_capture_set(true);
if input_keyboard_check_pressed(vk_escape)  input_mouse_capture_set(false);
if input_keyboard_check_pressed(vk_space)   input_mouse_enabled_set(!input_mouse_enabled_get());
if input_keyboard_check_pressed(ord("I"))   input_cursor_inverted_set(!input_cursor_inverted_get());