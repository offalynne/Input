//Default minimum threshold for directional (thumbstick) axes. This value is used for detecting gamepad input in input_source_hotswap_tick() so make sure you set it above 0.0
#macro INPUT_DEFAULT_AXIS_MIN_THRESHOLD  0.3

//Default maximum threshold for directional (thumbstick) axes
#macro INPUT_DEFAULT_AXIS_MAX_THRESHOLD  1.0

//Default minimum threshold for non-directional (trigger) axes. This value is used for detecting gamepad input in input_source_hotswap_tick() so make sure you set it above 0.0
#macro INPUT_DEFAULT_TRIGGER_MIN_THRESHOLD  0.02

//Default maximum threshold for non-directional (trigger) axes
#macro INPUT_DEFAULT_TRIGGER_MAX_THRESHOLD  1.0

//Whether the game uses the horizontal holdtype for single Joy-Cons. Set this to <false> for vertical holdtype
//Input treats these two modes as mutually exclusive (come talk to us if you need to be able to swap at runtime)
#macro INPUT_SWITCH_HORIZONTAL_HOLDTYPE  true