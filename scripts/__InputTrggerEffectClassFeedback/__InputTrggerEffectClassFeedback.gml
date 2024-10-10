// Feather disable all

function __InputTrggerEffectClassFeedback(_position, _strength) constructor
{
    static __modeName = "feedback";
    static __mode     = __INPUT_TRIGGER_EFFECT.__TYPE_FEEDBACK;
    
    __params = {};
    __params[$ __INPUT_TRIGGER_EFFECT_KEY_POSITION] = clamp(_position*10, 0, 9);
    __params[$ __INPUT_TRIGGER_EFFECT_KEY_STRENGTH] = clamp(_strength*8, 0, 8);
    
    static __ApplyPS5 = function(_gamepad, _trigger, _strength)
    {
        return ps5_gamepad_set_trigger_effect_feedback(_gamepad, _trigger,
                                                       __params[$ __INPUT_TRIGGER_EFFECT_KEY_POSITION],
                                                       __params[$ __INPUT_TRIGGER_EFFECT_KEY_STRENGTH]*_strength);
    }
    
    static __SteamGetState = function(_gamepad, _trigger)
    {
        if (InputDeviceGetGamepadValue(_gamepad, _trigger) >= __params[$ __INPUT_TRIGGER_EFFECT_KEY_POSITION]/10)
        {
            return INPUT_TRIGGER_STATE.EFFECT_FEEDBACK_ACTIVE;
        }
    
        return INPUT_TRIGGER_STATE.EFFECT_FEEDBACK_STANDBY;
    }
}