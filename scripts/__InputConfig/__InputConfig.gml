// Feather disable all

// The maximum number of players that the library will permit. Setting this number higher will
// incur a slight performance penalty.
#macro INPUT_MAX_PLAYERS  1

// Whether the library should perform extra checks to validate parameters for functions. This will
// catch small mistakes but also incurs a performance penalty. If you want maximum speed from the
// library, set this macro to `false`.
#macro INPUT_SAFETY_CHECKS  true

////////////////
//            //
//  Checkers  //
//            //
////////////////

// Default values for `InputRepeat()`. Please see that function for documentation on behaviour.
#macro INPUT_REPEAT_DEFAULT_DELAY      9
#macro INPUT_REPEAT_DEFAULT_PREDELAY  25

// Default values for the "long" checker functions. Please see that function for documentation on
// behaviour.
#macro INPUT_LONG_DEFAULT_DELAY  10

// Default values for the "opposing" checker functions. Please see that function for documentation
// on behaviour.
#macro INPUT_OPPOSING_DEFAULT_MOST_RECENT  true

///////////////////////////
//                       //
//  Analogue Thresholds  //
//                       //
///////////////////////////

// The distance the mouse must move before it is reported as active via `InputMouseMoved()`.
// This value should be set as high as possible to filter out noise.
#macro INPUT_MOUSE_MOVE_DEADZONE  2

// Minimum threshold for directional (thumbstick) axes. This value is used for detecting gamepad
// input when hotswapping so make sure you set it above 0. This value can further be overriden per
// player by using the `InputPlayerSetMinThreshold()` function.
#macro INPUT_GAMEPAD_THUMBSTICK_MIN_THRESHOLD  0.25

// Maximum threshold for directional (thumbstick) axes. This value can be overriden per player by
// using the `InputPlayerSetMaxThreshold()` function.
#macro INPUT_GAMEPAD_THUMBSTICK_MAX_THRESHOLD  0.8

// Default minimum threshold for non-directional (trigger) axes. This value is used for detecting
// gamepad input when hotswapping so make sure you set it above 0.
#macro INPUT_GAMEPAD_TRIGGER_MIN_THRESHOLD  0.05

// Default maximum threshold for non-directional (trigger) axes.
#macro INPUT_GAMEPAD_TRIGGER_MAX_THRESHOLD  0.9

/////////////////////////////////////
//                                 //
//  Touchscreen & Virtual Buttons  //
//                                 //
/////////////////////////////////////

// How many frames of history to record for virtual buttons that have the feature turned on.
#macro INPUT_VIRTUAL_BUTTON_HISTORY_FRAMES  10

// Whether players with the `INPUT_KBM` device can use virtual buttons. This is helpful when
// testing virtual buttons on your development machine.
#macro INPUT_MOUSE_CAN_USE_VIRTUAL_BUTTONS  false

// Whether `INPUT_TOUCH` will be considered connected (and therefore available) on desktop
// platforms. The library will never hotswap to `INPUT_TOUCH` on desktop and will prefer
// `INPUT_KBM` so to use `INPUT_TOUCH` you will need to.
#macro INPUT_ALLOW_TOUCH_ON_DESKTOP  false

// The maximum number of touchpoints to track when using the INPUT_TOUCH device.
#macro INPUT_MAX_TOUCHPOINTS  4

// Margin in pixels around the screen edge where gaining or losing a touch point will not register
// "pressed" or "released". Prevents false positives when dragging on to or off of the edge of a
// touchscreen.
#macro INPUT_TOUCH_EDGE_DEADZONE  35

//Default threshold values for 2D virtual buttons (thumbsticks)
//These values are measured in pixels in GUI-space
#macro INPUT_VIRTUAL_BUTTON_MIN_THRESHOLD   50
#macro INPUT_VIRTUAL_BUTTON_MAX_THRESHOLD  100

/////////////////////////
//                     //
//  Library Mechanics  //
//                     //
/////////////////////////

// How long to wait before automatically cancelling rebinding, measured in milliseconds. An
// automatic timeout is important to ensure that players don't softlock their game if a device
// that is being rebound becomes unresponsive.
#macro INPUT_REBIND_TIMEOUT  5000

// Whether various noisy, error-prone inputs will report a device as active and trigger a hotswap.
// Because these inputs are unreliable, it is recommended that they are set to `false`. However, if
// you feel that damages your game's UX then set them to `true`.
#macro INPUT_GAMEPAD_THUMBSTICK_REPORTS_ACTIVE  false
#macro INPUT_GAMEPAD_TRIGGER_REPORTS_ACTIVE     false
#macro INPUT_MOUSE_BUTTON_REPORTS_ACTIVE        false
#macro INPUT_MOUSE_MOVEMENT_REPORTS_ACTIVE      false

// Controls how the library collects player input. If `INPUT_UPDATE_AFTER_COLLECT` is set to
// `true` (which it is by default) then this macro also controls how the library updates itself
// overall.
// 
// 0 = The library will create a persistent and invisible controller instance at the start of the
//     game and will collect player input in the Begin Step event. This means verbs, gamepads etc.
//     are updated as soon as possible in a frame. This doesn't necessarily mean verb state is
//     updated as the very first task but it'll be close. Unfortunately, this method requires
//     that a persistent instance has to be created and destroying or deactivating this instance
//     will lead to the library emitting an error message.
// 
// 1 = Use a GameMaker time source to collect player input. This means verbs, gamepads etc. are
//     updated somewhere between the Begin Step and Step events. This is the most reliable way of
//     updating input but it does mean that library state in Begin Step event is a frame behind the
//     Step event.
// 
// 2 = The library will not automatically collect player input. Instead, you must call
//     `InputManualCollect()` yourself. This gives you maximum flexibility in how player input
//     is collected at the cost of having to manage that yourself.
#macro INPUT_COLLECT_MODE  0

// Whether to update library state immediately after collecting player input. This is set to `true`
// by default. If this macro is set to `false` then you should call `InputManualUpdate()` at
// some point after InputManualCollect() to update the library state. This macro is intended for
// use with fixed timestep or lockstep implementations. In those situations, you should collect
// player input within the main GameMaker update loop (see `INPUT_COLLECT_MODE` above). When you
// want to evaluate a tick of a fixed timestep or lockstep loop then call `InputManualUpdate()`
// once and then you may call library functions within your custom update loop as normal.
#macro INPUT_UPDATE_AFTER_COLLECT  true