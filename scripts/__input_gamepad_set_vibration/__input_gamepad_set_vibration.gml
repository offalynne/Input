/// This function should be called in the scope of a gamepad class

function __input_gamepad_set_vibration()
{
    __vibration_support = __global.__vibration_allowed && (xinput || !__INPUT_ON_WINDOWS);        
    if (__vibration_support)
    {
        if (os_type == os_ps5)
        {
            ps5_gamepad_set_vibration_mode(index, ps5_gamepad_vibration_mode_compatible);
        }            
        else
        {
            if (__input_string_contains(raw_type, "JoyCon", "SwitchHandheld"))
            {
                __vibration_scale = INPUT_VIBRATION_JOYCON_STRENGTH;
            }
            else
            {
                __vibration_scale = 1;
            }
        }
        
        gamepad_set_vibration(index, 0, 0);
    }
}
