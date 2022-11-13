function __input_gamepad_stop_trigger_effects(_gamepad_index)
{
    if (_gamepad_index == all)
    {
        var _i = 0;
        repeat(array_length(global.__input_gamepads))
        {
            __input_gamepad_stop_trigger_effects(_i);
            ++_i;
        }
        
        return;
    }
    
    if (_gamepad_index < 0) return;
    
    with (global.__input_gamepads[_gamepad_index])
    {
        __trigger_effect_apply(gp_shoulderlb, new __input_class_trigger_effect_off());
        __trigger_effect_apply(gp_shoulderrb, new __input_class_trigger_effect_off());
    }
}