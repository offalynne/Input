if (input_keyboard_check_pressed(vk_escape) || input_gamepad_check_pressed(input_player_get_gamepad(), gp_start))
{
    input_binding_scan_abort();
}

if (!input_binding_scan_in_progress())
{
    if (input_keyboard_check_pressed(ord("1")) || input_gamepad_check_pressed(input_player_get_gamepad(), gp_face1))
    {
        rebinding_source = input_source_get_array();
        
        input_binding_scan_start(function(_new_binding)
        {
            input_binding_set_safe("up", _new_binding);
        },
        undefined,
        rebinding_source);
    }
    
    if (input_keyboard_check_pressed(ord("2")) || input_gamepad_check_pressed(input_player_get_gamepad(), gp_face2))
    {
        rebinding_source = INPUT_KEYBOARD;
        
        input_binding_scan_start(function(_new_binding)
        {
            input_binding_set_safe("up", _new_binding);
        },
        undefined,
        rebinding_source);
    }
    
    if (input_keyboard_check_pressed(ord("3")) || input_gamepad_check_pressed(input_player_get_gamepad(), gp_face3))
    {
        rebinding_source = INPUT_GAMEPAD;
        
        input_binding_scan_start(function(_new_binding)
        {
            input_binding_set_safe("up", _new_binding);
        },
        undefined,
        rebinding_source);
    }
    
    if (input_keyboard_check_pressed(ord("R")))
    {
        input_binding_remove("up", rebinding_source);
    }
}