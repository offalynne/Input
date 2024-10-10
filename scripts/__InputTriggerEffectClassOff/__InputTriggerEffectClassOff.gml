// Feather disable all

function __InputTriggerEffectClassOff() constructor
{
    static __modeName = "off";
    static __mode     = __INPUT_TRIGGER_EFFECT.__TYPE_OFF;
    
    __params = {};
    
    static __ApplyPS5 = function(_gamepad, _trigger, _strength)
    {
        return ps5_gamepad_set_trigger_effect_off(_gamepad, _trigger);
    };
    
    static __SteamGetState = function(_gamepad, _trigger)
    {
        return INPUT_TRIGGER_STATE.EFFECT_OFF;
    };
}
