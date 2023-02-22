//Maximum number of alternate bindings per verb per profile
#macro INPUT_MAX_ALTERNATE_BINDINGS  2

//Whether to tolerate incorrect number of alternate bindings when importing
//This should typically be left as <false> to detect errors and such
//
//Set to <true> if you've changed the number of alternate bindings between builds and don't want
//to see error messages. Please note that we don't recommend this - you should instead reset player
//bindings in this situation - but the option is there if you need it
#macro INPUT_FLEXIBLE_ALTERNATE_BINDING_IMPORT  false

//Default time before input_check_repeat() returns <true>
//(Whether this is in frames or milliseconds is controlled by INPUT_TIMER_MILLISECONDS)
#macro INPUT_REPEAT_DEFAULT_DELAY  10

//Default time between a verb being activated and the first time input_check_repeat() returns <true>
//(Whether this is in frames or milliseconds is controlled by INPUT_TIMER_MILLISECONDS)
#macro INPUT_REPEAT_DEFAULT_PREDELAY  30

//Time before input_check_long() returns <true>
//(Whether this is in frames or milliseconds is controlled by INPUT_TIMER_MILLISECONDS)
#macro INPUT_LONG_DELAY  10

//Delay between key presses for it to register as a double press
//(Whether this is in frames or milliseconds is controlled by INPUT_TIMER_MILLISECONDS)
#macro INPUT_DOUBLE_DELAY  12

//Number of frames over which a thumbstick must move, from the minimum to maximum thresholds, to trigger a quick tap
//Lower values require the player to move a thumbstick faster to trigger a quick tap
// N.B. This value is always in frames, regardless of what INPUT_TIMER_MILLISECONDS is set to
#macro INPUT_QUICK_BUFFER  3

//Default time limit between the first and last key press for chord activation
//(Whether this is in frames or milliseconds is controlled by INPUT_TIMER_MILLISECONDS)
#macro INPUT_CHORD_DEFAULT_TIME  4

//Whether to clamp 2D input to a maximum distance of 1 unit
//This affects input_x(), input_y(), input_xy(), input_direction(), and input_distance()
#macro INPUT_2D_CLAMP  true

//The amount of bias for 2D checkers to prefer straight lines along the x- and y-axes
//This makes it easier for the player to input exactly horizontal and exactly vertical movement
//Value should be from 0 to 1. Higher values make the biasing behaviour stronger
#macro INPUT_2D_XY_AXIS_BIAS  0.0

//Whether the axis bias (see above) should be 8-directional
//If set to <false>, 2D checkers will only lock to north/east/south/west directions
#macro INPUT_2D_XY_AXIS_BIAS_DIAGONALS  false