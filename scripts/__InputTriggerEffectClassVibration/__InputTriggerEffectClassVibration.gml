// Feather disable all

function __InputTriggerEffectClassVibration(_position, _amplitude, _frequency) constructor
{
    static __modeName = "vibration";
    static __mode     = __INPUT_TRIGGER_EFFECT.__TYPE_VIBRATION;
    
    __params = {};
    __params[$ __INPUT_TRIGGER_EFFECT_KEY_POSITION ] = clamp(_position*10, 0, 9);
    __params[$ __INPUT_TRIGGER_EFFECT_KEY_AMPLITUDE] = clamp(_amplitude*8, 0, 8);
    __params[$ __INPUT_TRIGGER_EFFECT_KEY_FREQUENCY] = clamp(_frequency*255, 0, 255);
    
    static __ApplyPS5 = function(_gamepad, _trigger, _strength)
    {
        return ps5_gamepad_set_trigger_effect_vibration(_gamepad, _trigger,
                                                        __params[$ __INPUT_TRIGGER_EFFECT_KEY_POSITION],
                                                        __params[$ __INPUT_TRIGGER_EFFECT_KEY_AMPLITUDE]*_strength,
                                                        __params[$ __INPUT_TRIGGER_EFFECT_KEY_FREQUENCY]);
    };

    static __SteamGetState = function(_gamepad, _trigger)
    {
        if (InputDeviceGetGamepadValue(_gamepad, _trigger) >= __params[$ __INPUT_TRIGGER_EFFECT_KEY_POSITION]/10)
        {
            return INPUT_TRIGGER_STATE.EFFECT_VIBRATION_ACTIVE;
        }

        return INPUT_TRIGGER_STATE.EFFECT_VIBRATION_STANDBY;
    };
}