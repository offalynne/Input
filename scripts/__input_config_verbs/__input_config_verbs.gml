//This script contains the default profiles, and hence the default bindings and verbs, for your game
//
//  Please edit this macro to meet the needs of your game!
//
//The struct return by this script contains the names of each default profile.
//Default profiles then contain the names of verbs. Each verb should be given a binding that is
//appropriate for the profile. You can create bindings by calling InputBinding() and then specifying
//a constant to target from the mb_*, gp_*, or vk_* pools. You may specify a keyboard letter by using
//the character as a string.

return {
    
    keyboard_and_mouse:
    {
        up:    [InputBinding(vk_up),    InputBinding("W")],
        down:  [InputBinding(vk_down),  InputBinding("S")],
        left:  [InputBinding(vk_left),  InputBinding("A")],
        right: [InputBinding(vk_right), InputBinding("D")],
        
        accept:  InputBinding(vk_space),
        cancel:  InputBinding(vk_backspace),
        action:  InputBinding(vk_enter),
        special: InputBinding(vk_shift),
        
        //No aiming verbs since we use the mouse for that (see below for aiming verb examples)
        shoot: InputBinding(mb_left),
        
        pause: InputBinding(vk_escape),
    },
    
    gamepad:
    {
        up:    [InputBinding(-gp_axislv), InputBinding(gp_padu)],
        down:  [InputBinding( gp_axislv), InputBinding(gp_padd)],
        left:  [InputBinding(-gp_axislh), InputBinding(gp_padl)],
        right: [InputBinding( gp_axislh), InputBinding(gp_padr)],
        
        accept:  InputBinding(gp_face1),
        cancel:  InputBinding(gp_face2),
        action:  InputBinding(gp_face3),
        special: InputBinding(gp_face4),
        
        aim_up:    InputBinding(-gp_axisrv),
        aim_down:  InputBinding( gp_axisrv),
        aim_left:  InputBinding(-gp_axisrh),
        aim_right: InputBinding( gp_axisrh),
        shoot:     [InputBinding(gp_shoulderlb), InputBinding(gp_shoulderrb)],
        
        pause: InputBinding(gp_start),
    },
    
    touch:
    {
        up:    InputBinding(),
        down:  InputBinding(),
        left:  InputBinding(),
        right: InputBinding(),
        
        accept:  InputBinding(),
        cancel:  InputBinding(),
        action:  InputBinding(),
        special: InputBinding(),
        
        pause: InputBinding(),
    }
    
};