// Feather disable all
function __input_class_trigger_effect_feedback(_position, _strength) constructor
{
    static __mode_name = "feedback";
    static __mode      = __INPUT_TRIGGER_EFFECT.__TYPE_FEEDBACK;
    
    __params = {
        position: clamp(_position*10, 0, 9),
        strength: clamp(_strength*8, 0, 8)
    };

    static __steam_get_state = function(_gamepad, _trigger)
    {
        if (input_gamepad_value(_gamepad, _trigger) >= __params.position/10)
        {
            return INPUT_TRIGGER_STATE.EFFECT_FEEDBACK_ACTIVE;
        }
    
        return INPUT_TRIGGER_STATE.EFFECT_FEEDBACK_STANDBY;
    };

    static __apply_ps5 = function(_gamepad, _trigger, _strength)
    {
        return ps5_gamepad_set_trigger_effect_feedback(_gamepad, _trigger, __params.position, __params.strength * _strength);
    };
}
