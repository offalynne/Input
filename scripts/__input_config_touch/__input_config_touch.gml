//Maximum number of touch screen points to query
//This applies to touch screen devices only (excludes PlayStation)
//Many devices have fewer touchpoints than the default value (11)
#macro INPUT_MAX_TOUCHPOINTS  11

//Margin in pixels around the screen edge where gaining or losing a touch point will not register "pressed" or "released"
//Prevents false positives when dragging on to or off of the edge of a touchscreen.
#macro INPUT_TOUCH_EDGE_DEADZONE  35

//How many frames of history to record for button that have the feature turned on
#macro INPUT_TOUCH_HISTORY_FRAMES  10

//Default threshold values for 2D virtual buttons (thumbsticks)
//These values are measured in pixels in GUI-space
#macro INPUT_VIRTUAL_BUTTON_MIN_THRESHOLD   50
#macro INPUT_VIRTUAL_BUTTON_MAX_THRESHOLD  100

//Default virtual (onscreen) keyboard settings for mobile
#macro INPUT_VIRTUAL_KEYBOARD_AUTOCAPITALIZATION_TYPE  kbv_autocapitalize_sentences
#macro INPUT_VIRTUAL_KEYBOARD_PREDICTIVE_TEXT_ENABLED  false
