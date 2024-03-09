// Feather disable all
function __input_class_trigger_effect_vibration(_position, _amplitude, _frequency) constructor
{
    static __mode_name = "vibration";
    static __mode      = __INPUT_TRIGGER_EFFECT.__TYPE_VIBRATION;
    
    __params = {
        position:  clamp(_position*10, 0, 9),
        amplitude: clamp(_amplitude*8, 0, 8),
        frequency: clamp(_frequency*255, 0, 255)
    };
    
    static __apply_ps5 = function(_gamepad, _trigger, _strength)
    {
        return ps5_gamepad_set_trigger_effect_vibration(_gamepad, _trigger, __params.position, __params.amplitude * _strength, __params.frequency);
    };

    static __steam_get_state = function(_gamepad, _trigger)
    {
        if (input_gamepad_value(_gamepad, _trigger) >= __params.position/10)
        {
            return INPUT_TRIGGER_STATE.EFFECT_VIBRATION_ACTIVE;
        }

        return INPUT_TRIGGER_STATE.EFFECT_VIBRATION_STANDBY;
    };
}
