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

//Whether to use the right hand sensor for motion data when using detached dual Joy-Cons as a pair
//When <false>, the left hand Joy-Con sensor will be used for motion data instead 
#macro INPUT_SWITCH_JOYCON_MOTION_RIGHT_HAND true

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

//The default haptic trigger effect strength. This value can be changed later by using input_trigger_effect_set_strength()
#macro INPUT_TRIGGER_EFFECT_DEFAULT_STRENGTH  1.0

//Default gamepad gyroscope axis for screenspace X and Y
#macro INPUT_GYRO_DEFAULT_AXIS_X  INPUT_GYRO.AXIS_YAW
#macro INPUT_GYRO_DEFAULT_AXIS_Y  INPUT_GYRO.AXIS_PITCH

//Default gamepad gyroscope sensitivity
//At a value of 1.0, turning a controller 180 degrees covers screenspace. At 2.0, 90 degrees covers screenspace
//Negative values result in an inverted axis
#macro INPUT_GYRO_DEFAULT_SENSITIVITY_X   2.0
#macro INPUT_GYRO_DEFAULT_SENSITIVITY_Y  -2.0
