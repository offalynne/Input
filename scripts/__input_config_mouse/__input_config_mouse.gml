//Whether to allow mouse input to be returned by input_binding_scan_start()
#macro INPUT_MOUSE_ALLOW_SCANNING  true

//Size of the deadzone for detecting mouse movement, measured in pixels
//Higher values increase how far the mouse must travel before reporting the mouse as being used
#macro INPUT_MOUSE_MOVE_DEADZONE  2

//Whether the mouse source can be used to interact with virtual buttons
//Virtual buttons are intended for use with touchscreens only, but it can be useful to have
//mouse interaction for debugging without having to compile for device
#macro INPUT_MOUSE_ALLOW_VIRTUAL_BUTTONS  true