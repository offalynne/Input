function __input_class_trigger_effect_weapon(_trigger, _start, _end, _strength) constructor
{
    static __mode_name = "weapon";
    static __mode      = __INPUT_TRIGGER_EFFECT.__TYPE_WEAPON;
    __params    = {
        start_position: clamp(_start*10, 2, 7),
        end_position:   clamp(_end*10, max(_end*10, _start*10), 8),
        strength:       clamp(_strength*8, 0, 8),
    };
    
    static __apply_ps5 = function(_gamepad, _trigger, _strength)
    {
        return ps5_gamepad_set_trigger_effect_weapon(_gamepad, _trigger, __params.start_position, __params.end_position, __params.strength * _strength);
    };

    static __steam_get_state = function(_gamepad, _trigger)
    {
        var _trigger_value = input_gamepad_value(_gamepad, _trigger);
        if (_trigger_value > min(9.9, __params.end_position + 2)/10)
        {
            return INPUT_TRIGGER_STATE.EFFECT_WEAPON_FIRED;
        }
        else if (_trigger_value >= __params.start_position/10)
        {
            return INPUT_TRIGGER_STATE.EFFECT_WEAPON_PULLING;
        }

        return INPUT_TRIGGER_STATE.EFFECT_WEAPON_STANDBY;
    };
}