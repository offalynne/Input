//DualSense haptic trigger effect states
enum INPUT_TRIGGER_STATE
{
    EFFECT_OFF               = ps5_gamepad_trigger_effect_state_off,
    EFFECT_FEEDBACK_STANDBY  = ps5_gamepad_trigger_effect_state_feedback_standby,
    EFFECT_FEEDBACK_ACTIVE   = ps5_gamepad_trigger_effect_state_feedback_active,
    EFFECT_WEAPON_STANDBY    = ps5_gamepad_trigger_effect_state_weapon_standby,
    EFFECT_WEAPON_PULLING    = ps5_gamepad_trigger_effect_state_weapon_pulling,
    EFFECT_WEAPON_FIRED      = ps5_gamepad_trigger_effect_state_weapon_fired,
    EFFECT_VIBRATION_STANDBY = ps5_gamepad_trigger_effect_state_vibration_standby,
    EFFECT_VIBRATION_ACTIVE  = ps5_gamepad_trigger_effect_state_vibration_active,
    EFFECT_INTERCEPTED       = ps5_gamepad_trigger_effect_state_intercepted,
}