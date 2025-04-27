//Feather disable all

if (InputPlayerUsingGamepad())
{
    var _device = InputPlayerGetDevice();
    
    if (InputDeviceGetGamepadValue(_device, gp_face1))
    {
        show_debug_message("Gamepad color = red");
        InputColorSet(c_red);
    }
    
    if (InputDeviceGetGamepadValue(_device, gp_face2))
    {
        show_debug_message("Gamepad color = yellow");
        InputColorSet(c_yellow);
    }
    
    if (InputDeviceGetGamepadValue(_device, gp_face3))
    {
        show_debug_message("Gamepad color = lime");
        InputColorSet(c_lime);
    }
    
    if (InputDeviceGetGamepadValue(_device, gp_face4))
    {
        show_debug_message("Gamepad color = blue");
        InputColorSet(c_blue);
    }
    
    if (InputDeviceGetGamepadValue(_device, gp_start))
    {
        show_debug_message("Restting gamepad color");
        InputColorReset();
    }
    
    if (InputDeviceGetGamepadValue(_device, gp_shoulderl))
    {
        show_debug_message("Testing left vibration");
        InputVibrateConstant(1, -1, 100);
    }
    
    if (InputDeviceGetGamepadValue(_device, gp_shoulderr))
    {
        show_debug_message("Testing right vibration");
        InputVibrateConstant(1, 1, 100);
    }
    
    if (InputDeviceGetGamepadValue(_device, gp_padu))
    {
        InputTriggerEffectOff(gp_shoulderlb);
    }
    
    if (InputDeviceGetGamepadValue(_device, gp_padl))
    {
        InputTriggerEffectWeapon(gp_shoulderlb, 0.2, 0.3, 1);
    }
    
    if (InputDeviceGetGamepadValue(_device, gp_padd))
    {
        InputTriggerEffectOff(gp_shoulderrb);
    }
    
    if (InputDeviceGetGamepadValue(_device, gp_padr))
    {
        InputTriggerEffectWeapon(gp_shoulderrb, 0.2, 0.3, 1);
    }
}