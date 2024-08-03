// Feather disable all
function __input_class_trigger_effect_vibration(_position, _amplitude, _frequency) constructor
{
    static __mode_name = "vibration";
    static __mode      = __INPUT_TRIGGER_EFFECT.__TYPE_VIBRATION;
    
    __params = {};
    __params[$ __INPUT_STEAMWORKS_KEY_POSITION ] = clamp(_position*10, 0, 9);
    __params[$ __INPUT_STEAMWORKS_KEY_AMPLITUDE] = clamp(_amplitude*8, 0, 8);
    __params[$ __INPUT_STEAMWORKS_KEY_FREQUENCY] = clamp(_frequency*255, 0, 255);
    
    static __apply_ps5 = function(_gamepad, _trigger, _strength)
    {
        return ps5_gamepad_set_trigger_effect_vibration(_gamepad, _trigger, __params[$ __INPUT_STEAMWORKS_KEY_POSITION], __params[$ __INPUT_STEAMWORKS_KEY_AMPLITUDE] * _strength, __params[$ __INPUT_STEAMWORKS_KEY_FREQUENCY]);
    };

    static __steam_get_state = function(_gamepad, _trigger)
    {
        if (input_gamepad_value(_gamepad, _trigger) >= __params[$ __INPUT_STEAMWORKS_KEY_POSITION]/10)
        {
            return INPUT_TRIGGER_STATE.EFFECT_VIBRATION_ACTIVE;
        }

        return INPUT_TRIGGER_STATE.EFFECT_VIBRATION_STANDBY;
    };
}
