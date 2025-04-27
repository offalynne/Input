//Feather disable all

if (InputPlayerUsingGamepad())
{
    var _device = InputPlayerGetDevice();
    
    if (gamepad_button_check_pressed(_device, gp_padd))
    {
        InputTriggerEffectOff(gp_shoulderlb);
    }
    
    if (gamepad_button_check_pressed(_device, gp_padr))
    {
        InputTriggerEffectWeapon(gp_shoulderlb, 0.2, 0.3, 1);
    }
    
    if (gamepad_button_check_pressed(_device, gp_padl))
    {
        InputTriggerEffectFeedback(gp_shoulderlb, 0.3, 0.5);
    }
    
    if (gamepad_button_check_pressed(_device, gp_padu))
    {
        InputTriggerEffectVibration(gp_shoulderlb, 0.3, 0.5, 0.125);
    }
    
    if (gamepad_button_check_pressed(_device, gp_face1))
    {
        InputTriggerEffectOff(gp_shoulderrb);
    }
    
    if (gamepad_button_check_pressed(_device, gp_face2))
    {
        InputTriggerEffectWeapon(gp_shoulderrb, 0.7, 0.8, 1);
    }
    
    if (gamepad_button_check_pressed(_device, gp_face3))
    {
        InputTriggerEffectFeedback(gp_shoulderrb, 0.7, 1);
    }
    
    if (gamepad_button_check_pressed(_device, gp_face4))
    {
        InputTriggerEffectVibration(gp_shoulderrb, 0.75, 1, 0.66);
    }
    
    if (gamepad_button_check_pressed(_device, gp_shoulderl))
    {
       InputTriggerEffectSetPause(false);
    }
    
    if (gamepad_button_check_pressed(_device, gp_shoulderr))
    {
       InputTriggerEffectSetPause(true);
    }
}