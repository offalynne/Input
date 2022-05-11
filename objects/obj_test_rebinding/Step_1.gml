if (input_keyboard_check_pressed(vk_escape) || input_gamepad_check_pressed(input_player_get_gamepad(), gp_start)) rebinding = false;

if (rebinding)
{
    var _binding = input_binding_scan_tick(rebinding_profile);
    if (_binding != undefined)
    {
        input_binding_set_safe("up", _binding);
        rebinding = false;
    }
}
else
{
    if (input_keyboard_check_pressed(ord("1")) || input_gamepad_check_pressed(input_player_get_gamepad(), gp_face1))
    {
        rebinding = true;
        rebinding_profile = input_profile_get();
    }
    
    if (input_keyboard_check_pressed(ord("2")) || input_gamepad_check_pressed(input_player_get_gamepad(), gp_face2))
    {
        rebinding = true;
        rebinding_profile = INPUT_AUTO_PROFILE_FOR_KEYBOARD;
    }
    
    if (input_keyboard_check_pressed(ord("3")) || input_gamepad_check_pressed(input_player_get_gamepad(), gp_face3))
    {
        rebinding = true;
        rebinding_profile = INPUT_AUTO_PROFILE_FOR_GAMEPAD;
    }
    
    if (input_keyboard_check_pressed(ord("R")))
    {
        rebinding = false;
        input_binding_remove("up", rebinding_profile);
    }
}