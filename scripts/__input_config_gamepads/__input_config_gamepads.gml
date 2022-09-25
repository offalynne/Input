//Default minimum threshold for directional (thumbstick) axes. This value is used for detecting gamepad input in input_source_hotswap_tick() so make sure you set it above 0.0
#macro INPUT_DEFAULT_AXIS_MIN_THRESHOLD  0.3

//Default maximum threshold for directional (thumbstick) axes
#macro INPUT_DEFAULT_AXIS_MAX_THRESHOLD  0.95

//Default minimum threshold for non-directional (trigger) axes. This value is used for detecting gamepad input in input_source_hotswap_tick() so make sure you set it above 0.0
#macro INPUT_DEFAULT_TRIGGER_MIN_THRESHOLD  0.02

//Default maximum threshold for non-directional (trigger) axes
#macro INPUT_DEFAULT_TRIGGER_MAX_THRESHOLD  1.0

//Whether the game uses the horizontal holdtype for single Joy-Cons. Set this to <false> for vertical holdtype
//Input treats these two modes as mutually exclusive (come talk to us if you need to be able to swap at runtime)
#macro INPUT_SWITCH_HORIZONTAL_HOLDTYPE  true

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
//Please note that this is only applied specifically when playing on a Switch console
#macro INPUT_VIBRATION_SWITCH_OS_STRENGTH  0.4