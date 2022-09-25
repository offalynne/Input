input_tick();

if (input_keyboard_check_pressed(vk_escape) || input_gamepad_check_pressed(input_player_get_gamepad(), gp_start))
{
    input_binding_scan_abort();
}

if (!input_binding_scan_in_progress())
{
    //Ignore A + B + C + (A) + (B)
    if (input_keyboard_check_pressed(ord("I")) || input_gamepad_check_released(input_player_get_gamepad(), gp_padl))
    {
        rebinding_source = input_source_get_array();
        
        input_binding_scan_set_params(["A", "B", "C", gp_face1, gp_face2], undefined);
        input_binding_scan_start(function(_new_binding)
        {
            input_binding_set_safe("up", _new_binding);
        },
        undefined,
        rebinding_source);
    }
    
    //Allow A + B + C + (X) + (Y)
    if (input_keyboard_check_pressed(ord("A")) || input_gamepad_check_released(input_player_get_gamepad(), gp_padu))
    {
        rebinding_source = input_source_get_array();
        
        input_binding_scan_set_params(undefined, ["A", "B", "C", gp_face3, gp_face4]);
        input_binding_scan_start(function(_new_binding)
        {
            input_binding_set_safe("up", _new_binding);
        },
        undefined,
        rebinding_source);
    }
    
    //Test both ignore and allow arrays being set at the same time
    //Since ignore > allow, this means only C + gp_face4 is valid
    if (input_keyboard_check_pressed(ord("M")) || input_gamepad_check_released(input_player_get_gamepad(), gp_padr))
    {
        rebinding_source = input_source_get_array();
        
        input_binding_scan_set_params(["A", "B", gp_face3], ["A", "B", "C", gp_face3, gp_face4]);
        input_binding_scan_start(function(_new_binding)
        {
            input_binding_set_safe("up", _new_binding);
        },
        undefined,
        rebinding_source);
    }
}