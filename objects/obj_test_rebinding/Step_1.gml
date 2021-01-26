input_tick();
input_hotswap_tick();

if (keyboard_check_pressed(ord("1")) || input_gamepad_check_pressed(input_player_gamepad_get(), gp_face1))
{
    rebinding = true;
    rebinding_source = undefined;
}

if (keyboard_check_pressed(ord("2")) || input_gamepad_check_pressed(input_player_gamepad_get(), gp_face2))
{
    rebinding = true;
    rebinding_source = INPUT_SOURCE.KEYBOARD_AND_MOUSE;
}

if (keyboard_check_pressed(ord("3")) || input_gamepad_check_pressed(input_player_gamepad_get(), gp_face3))
{
    rebinding = true;
    rebinding_source = INPUT_SOURCE.GAMEPAD;
}

if (rebinding)
{
    var _binding = input_binding_scan_tick(0, rebinding_source);
    if (_binding != undefined)
    {
        input_binding_set_safe(VERB.UP, _binding);
        rebinding = false;
    }
}