INPUT_DEFAULT_PROFILES = {
    
    keyboard: {
        up:    input_binding_key(vk_up),
        down:  input_binding_key(vk_down),
        left:  input_binding_key(vk_left),
        right: input_binding_key(vk_right),
        
        accept:  input_binding_key(vk_space),
        cancel:  [input_binding_key(vk_escape), input_binding_key(vk_backspace)],
        action:  input_binding_key(vk_enter),
        special: input_binding_key(vk_shift),
    },
    
    mouse: {},
    
    gamepad: {
        up:    [input_binding_gamepad_axis(gp_axislv, true),  input_binding_gamepad_button(gp_padu)],
        down:  [input_binding_gamepad_axis(gp_axislv, false), input_binding_gamepad_button(gp_padd)],
        left:  [input_binding_gamepad_axis(gp_axislh, true),  input_binding_gamepad_button(gp_padl)],
        right: [input_binding_gamepad_axis(gp_axislh, false), input_binding_gamepad_button(gp_padr)],
        
        accept:  input_binding_gamepad_button(gp_face1),
        cancel:  input_binding_gamepad_button(gp_face2),
        action:  input_binding_gamepad_button(gp_face3),
        special: input_binding_gamepad_button(gp_face4),
    },
    
};