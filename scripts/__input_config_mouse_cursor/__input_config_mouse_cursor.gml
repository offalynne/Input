//Whether to allow mouse input to be returned by input_binding_scan_start()
#macro INPUT_MOUSE_ALLOW_SCANNING  true

//Size of the deadzone for detecting mouse movement, measured in pixels
//Higher values increase how far the mouse must travel before reporting the mouse as being used
#macro INPUT_MOUSE_MOVE_DEADZONE  2

//Verbs that control motion of Input's device-agnostic cursor
//This is primarily used for gamepad input but can also be used for keyboard input too
#macro INPUT_CURSOR_VERB_UP     "aim_up"
#macro INPUT_CURSOR_VERB_DOWN   "aim_down"
#macro INPUT_CURSOR_VERB_LEFT   "aim_left"
#macro INPUT_CURSOR_VERB_RIGHT  "aim_right"

//The default speed for cursors when the game boots up
//This can be changed with input_cursor_speed_set()
#macro INPUT_CURSOR_START_SPEED  5

//Cursor movement exponent. This is applied when using keyboard and gamepad controls
#macro INPUT_CURSOR_EXPONENT  1