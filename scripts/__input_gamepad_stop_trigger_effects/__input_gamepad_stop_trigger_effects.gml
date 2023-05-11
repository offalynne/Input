function __input_gamepad_stop_trigger_effects(_gamepad_index)
{
    __INPUT_GLOBAL_STATIC_LOCAL  //Set static _global
    
    if (_gamepad_index == all)
    {
        var _i = 0;
        repeat(array_length(_global.__gamepads))
        {
            __input_gamepad_stop_trigger_effects(_i);
            ++_i;
        }
        
        return;
    }
    
    if (_gamepad_index < 0) return;
    
    with (_global.__gamepads[_gamepad_index])
    {
        __trigger_effect_apply(gp_shoulderlb, new __input_class_trigger_effect_off());
        __trigger_effect_apply(gp_shoulderrb, new __input_class_trigger_effect_off());
    }
}