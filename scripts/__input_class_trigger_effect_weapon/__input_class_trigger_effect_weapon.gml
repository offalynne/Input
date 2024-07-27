// Feather disable all
function __input_class_trigger_effect_weapon(_trigger, _start, _end, _strength) constructor
{
    static __mode_name = "weapon";
    static __mode      = __INPUT_TRIGGER_EFFECT.__TYPE_WEAPON;
    
    __params = {};
    __params[$ __INPUT_STEAMWORKS_KEY_START_POSITION] = clamp(_start*10, 2, 7);
    __params[$ __INPUT_STEAMWORKS_KEY_END_POSITION  ] = clamp(_end*10, max(_end*10, _start*10), 8);
    __params[$ __INPUT_STEAMWORKS_KEY_STRENGTH      ] = clamp(_strength*8, 0, 8);
    
    static __apply_ps5 = function(_gamepad, _trigger, _strength)
    {
        return ps5_gamepad_set_trigger_effect_weapon(_gamepad, _trigger, __params[$ __INPUT_STEAMWORKS_KEY_START_POSITION], __params[$ __INPUT_STEAMWORKS_KEY_END_POSITION], __params[$ __INPUT_STEAMWORKS_KEY_STRENGTH] * _strength);
    };

    static __steam_get_state = function(_gamepad, _trigger)
    {
        var _trigger_value = input_gamepad_value(_gamepad, _trigger);
        if (_trigger_value > min(9.9, __params[$ __INPUT_STEAMWORKS_KEY_END_POSITION] + 2)/10)
        {
            return INPUT_TRIGGER_STATE.EFFECT_WEAPON_FIRED;
        }
        else if (_trigger_value >= __params[$ __INPUT_STEAMWORKS_KEY_START_POSITION]/10)
        {
            return INPUT_TRIGGER_STATE.EFFECT_WEAPON_PULLING;
        }

        return INPUT_TRIGGER_STATE.EFFECT_WEAPON_STANDBY;
    };
}
