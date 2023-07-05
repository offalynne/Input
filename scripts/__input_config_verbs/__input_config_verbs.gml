//This script contains the default profiles, and hence the default bindings and verbs, for your game
//
//  Please edit this macro to meet the needs of your game!
//
//The struct return by this script contains the names of each default profile.
//Default profiles then contain the names of verbs. Each verb should be given a binding that is
//appropriate for the profile. You can create bindings by specifying a constant to target from the
//native GameMaker mb_*, gp_*, or vk_* pools. You may specify a keyboard letter by using the character
//as a string.

return {
    
    keyboard_and_mouse:
    {
        up:    [vk_up,    "W"],
        down:  [vk_down,  "S"],
        left:  [vk_left,  "A"],
        right: [vk_right, "D"],
        
        accept:  vk_space,
        cancel:  vk_backspace,
        action:  vk_enter,
        special: vk_shift,
        
        //No aiming verbs since we use the mouse for that (see below for aiming verb examples)
        shoot: mb_left,
        
        pause: vk_escape,
    },
    
    gamepad:
    {
        up:    [-gp_axislv, gp_padu],
        down:  [ gp_axislv, gp_padd],
        left:  [-gp_axislh, gp_padl],
        right: [ gp_axislh, gp_padr],
        
        accept:  gp_face1,
        cancel:  gp_face2,
        action:  gp_face3,
        special: gp_face4,
        
        aim_up:    -gp_axisrv,
        aim_down:   gp_axisrv,
        aim_left:  -gp_axisrh,
        aim_right:  gp_axisrh,
        shoot:     [gp_shoulderlb, gp_shoulderrb],
        
        pause: gp_start,
    },
    
    touch:
    {
        up:    undefined,
        down:  undefined,
        left:  undefined,
        right: undefined,
        
        accept:  undefined,
        cancel:  undefined,
        action:  undefined,
        special: undefined,
        
        pause: undefined,
    }
    
};