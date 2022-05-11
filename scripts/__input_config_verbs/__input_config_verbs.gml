//Default time before input_check_repeat() returns <true>
//(Whether this is in frames or milliseconds is controlled by INPUT_TIMER_MILLISECONDS above)
#macro INPUT_REPEAT_DEFAULT_DELAY  10

//Default time between a verb being activated and the first time input_check_repeat() returns <true>
//(Whether this is in frames or milliseconds is controlled by INPUT_TIMER_MILLISECONDS above)
#macro INPUT_REPEAT_DEFAULT_PREDELAY  30

//Time before input_check_long() returns <true>
//(Whether this is in frames or milliseconds is controlled by INPUT_TIMER_MILLISECONDS above)
#macro INPUT_LONG_DELAY  10

//Delay between key presses for it to register as a double press
//(Whether this is in frames or milliseconds is controlled by INPUT_TIMER_MILLISECONDS above)
#macro INPUT_DOUBLE_DELAY  12

//Default time limit between the first and last key press for chord activation
//(Whether this is in frames or milliseconds is controlled by INPUT_TIMER_MILLISECONDS above)
#macro INPUT_CHORD_DEFAULT_TIME  4

//Whether to clamp 2D input to a maximum distance of 1 unit
//This affects input_x(), input_y(), input_xy(), input_direction(), and input_distance()
#macro INPUT_2D_CLAMP  true

//Defines which verbs should collide with which other verbs when using input_binding_get_collisions()
//and input_binding_set_safe(). A verb that is not present in a group will collide with all other verbs
INPUT_VERB_GROUPS = {
    general: ["up", "down", "left", "right", "accept", "cancel", "action", "special", "pause",],
};