function __input_class_trigger_effect_off() constructor
{
    __mode_name = "off";
    __mode      = INPUT_TRIGGER_EFFECT.TYPE_OFF;
    __params    = {};

    static __steam_get_state = function(_gamepad, _trigger)
    {
        return INPUT_TRIGGER_STATE.EFFECT_OFF;
    };

    static __apply_ps5 = function(_gamepad, _trigger)
    {
        return ps5_gamepad_set_trigger_effect_off(_gamepad, _trigger);
    };
}