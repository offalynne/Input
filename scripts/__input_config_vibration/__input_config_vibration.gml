//Whether vibration should be allowed at all, often useful when debugging
#macro INPUT_VIBRATION_ALLOWED  true

//Whether to enable PS4-style rumble features on PS5 platform
//Enables Input's cross-platform rumble implementation on PS5
#macro INPUT_PS5_USE_LEGACY_VIBRATION  true

//Whether to enable legacy rumble features on Switch controllers
//Enables Input's cross-platform rumble implementation on Switch
#macro INPUT_SWITCH_USE_LEGACY_VIBRATION  true

//The default vibration strength. This value can be changed later by using input_vibrate_set_strength()
#macro INPUT_VIBRATION_DEFAULT_STRENGTH  1.0

//Switch's vibration motors can be a bit, uh, intense
//This value allows you to reduce the strength of vibration relative to other platforms
//Please note that this is only applied specifically when playing on a Switch console and won't automatically be applied on other OSes
#macro INPUT_VIBRATION_SWITCH_OS_STRENGTH  0.4

//The default haptic trigger effect strength. This value can be changed later by using input_trigger_effect_set_strength()
#macro INPUT_TRIGGER_EFFECT_DEFAULT_STRENGTH  1.0