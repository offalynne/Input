var _size = gamepad_get_device_count();
var _delta = (input_keyboard_check_pressed(vk_down) - input_keyboard_check_pressed(vk_up));
var _first_gamepad = ((__INPUT_ON_APPLE && __INPUT_ON_MOBILE && !__INPUT_ON_WEB)? 1 : 0);

if (__INPUT_ON_CONSOLE || __INPUT_TOUCH_SUPPORT)
    _delta += (input_mouse_check_pressed(mb_left) 
             || (gamepad_is_connected(_first_gamepad) && input_gamepad_check_pressed(_first_gamepad, gp_face1) && input_gamepad_check(_first_gamepad, gp_shoulderr))
             || ((os_type == os_windows) && gamepad_is_connected(4) && input_gamepad_check_pressed(4, gp_face1) && input_gamepad_check(4, gp_shoulderr)));

test_index = (test_index + _delta + _size) mod max(1, _size);

var _test_colors = [c_blue, c_red, c_fuchsia, c_lime];
var _gamepad = input_player_get_gamepad();
if (gamepad_is_connected(_gamepad))
{
    var _i = 0;
    repeat(4)
    {
        if (input_gamepad_check_pressed(_gamepad, gp_face1 + _i))
        {
            input_color_set(_test_colors[_i]);
        }
        ++_i;
    }
    
    if (input_gamepad_check_pressed(_gamepad, gp_start))
    {
        input_color_reset();
    }
}
