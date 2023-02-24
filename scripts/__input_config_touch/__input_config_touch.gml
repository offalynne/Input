//If touch input (mobile + Switch) should be treated as mouse input
#macro INPUT_TOUCH_IS_MOUSE  false

//Maximum number of touch screen points to query
//This applies to touch screen devices only (excludes PlayStation)
//Many devices have fewer touchpoints than the default value (11)
#macro INPUT_MAX_TOUCHPOINTS  11

//Margin in pixels around the screen edge where gaining or losing a touch point will not register "pressed" or "released"
//Prevents false positives when dragging on to or off of the edge of a touchscreen.
#macro INPUT_TOUCH_EDGE_DEADZONE  35

//Whether to allow touch input (real, or simulated by physical mouse) to set mouse bindings on touch-enabled platforms
#macro INPUT_TOUCH_POINTER_ALLOWED  true

//How many frames of history to record for button that have the feature turned on
#macro INPUT_TOUCH_HISTORY_FRAMES  10

//Default threshold values for 2D virtual buttons (thumbsticks)
//These values are measured in pixels in GUI-space
#macro INPUT_VIRTUAL_BUTTON_MIN_THRESHOLD   50
#macro INPUT_VIRTUAL_BUTTON_MAX_THRESHOLD  100