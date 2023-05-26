var _size = gamepad_get_device_count();
var _delta = (input_keyboard_check_pressed(vk_down) - input_keyboard_check_pressed(vk_up));

var _first_gamepad = 0;
if (__INPUT_ON_IOS && !INPUT_ON_WEB)
{
    _first_gamepad = 1;
}
else if (!gamepad_is_connected(_first_gamepad) && __INPUT_ON_WINDOWS)
{
    _first_gamepad = 4;
}

_delta += device_mouse_check_button_pressed(0, mb_left);
_delta += input_gamepad_check(_first_gamepad, gp_shoulderr) && input_gamepad_check_pressed(_first_gamepad, gp_face1);

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
