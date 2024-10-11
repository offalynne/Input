# Config Macros

&nbsp;

The following macros can be found in the `__InputConfig` script. You should adjust these macros according to your needs. When updating Input, you will usually need to back up any macros that you've changed and then restore those values after updating the library.

&nbsp;

## `INPUT_MAX_PLAYERS`

*Typical value: `1`*

The maximum number of players that the library will permit. Setting this number higher will incur a slight performance penalty.

&nbsp;

## `INPUT_2D_XY_AXIS_BIAS`

*Typical value: `0.0`*

The amount of bias for 2D checkers to prefer straight lines along the x- and y-axes. This makes it easier for the player to input exactly horizontal and exactly vertical movement. Values should be from 0 to 1. Higher values make the biasing behaviour stronger.

&nbsp;

## `INPUT_2D_XY_AXIS_BIAS_DIAGONALS`

*Typical value: `false`*

Whether the axis bias (see above) should be 8-directional. If set to `false`, 2D checkers will only lock to north/east/south/west directions.

&nbsp;

## `INPUT_REPEAT_DEFAULT_DELAY`

*Typical value: `9`*

Default values for `InputRepeat()`. Please see that function for documentation on behaviour.

&nbsp;

## `INPUT_REPEAT_DEFAULT_PREDELAY`

*Typical value: `25`*

Default values for `InputRepeat()`. Please see that function for documentation on behaviour.

&nbsp;

## `INPUT_LONG_DEFALT_DELAY`

*Typical value: `10`*

Default values for the "long" checker functions. Please see that function for documentation on behaviour.

&nbsp;

## `INPUT_OPPOSING_DEFAULT_MOST_RECENT`

*Typical value: `true`*

Default values for the "opposing" checker functions. Please see that function for documentation on behaviour.

&nbsp;

## `INPUT_MOUSE_MOVE_DEADZONE`

*Typical value: `2`*

The distance the mouse must move before it is reported as active via `InputMouseMoved()`. This value should be set as high as pos

&nbsp;

## `INPUT_GAMEPAD_THUMBSTICK_MIN_THRESHOLD`

*Typical value: `0.25`*

Minimum threshold for directional (thumbstick) axes. This value is used for detecting gamepad input when hotswapping so make sure you set it above 0.

&nbsp;

## `INPUT_GAMEPAD_THUMBSTICK_MAX_THRESHOLD`

*Typical value: `0.8`*

Maximum threshold for directional (thumbstick) axes.

&nbsp;

## `INPUT_GAMEPAD_TRIGGER_MIN_THRESHOLD`

*Typical value: `0.05`*

Default minimum threshold for non-directional (trigger) axes. This value is used for detecting gamepad input when hotswapping so make sure you set it above 0.

&nbsp;

## `INPUT_GAMEPAD_TRIGGER_MAX_THRESHOLD`

*Typical value: `0.9`*

Default maximum threshold for non-directional (trigger) axes.

&nbsp;

## `INPUT_VIRTUAL_BUTTON_HISTORY_FRAMES`

*Typical value: `10`*

How many frames of history to record for virtual buttons that have the feature turned on.

&nbsp;

## `INPUT_MOUSE_CAN_USE_VIRTUAL_BUTTONS`

*Typical value: `false`*

Whether players with the `INPUT_KBM` device can use virtual buttons. This is helpful when testing virtual buttons on your development mac

&nbsp;

## `INPUT_ALLOW_TOUCH_ON_DESKTOP`

*Typical value: `false`*

Whether INPUT_TOUCH will be considered connected (and therefore available) on desktop platforms. The library will never hotswap to INPUT_TOUCH on desktop and will prefer INPUT_KBM so to use INPUT_TOUCH you will need to 

&nbsp;

## `INPUT_MAX_TOUCHPOINTS`

*Typical value: `4`*

The maximum number of touchpoints to track when using the INPUT_TOUCH device.

&nbsp;

## `INPUT_TOUCH_EDGE_DEADZONE`

*Typical value: `35`*

Margin in pixels around the screen edge where gaining or losing a touch point will not register "pressed" or "released". Prevents false positives when dragging on to or off of the edge of a touchscreen.

&nbsp;

## `INPUT_VIRTUAL_BUTTON_MIN_THRESHOLD`

*Typical value: `50`*

Default threshold values for 2D virtual buttons (thumbsticks). These values are measured in pixels in GUI-space.

&nbsp;

## `INPUT_VIRTUAL_BUTTON_MAX_THRESHOLD`

*Typical value: `100`*

Default threshold values for 2D virtual buttons (thumbsticks). These values are measured in pixels in GUI-space.

&nbsp;

## `INPUT_REBIND_TIMEOUT`

*Typical value: `5000`*

How long to wait before automatically cancelling rebinding, measured in milliseconds. An automatic timeout is important to ensure that players don't softlock their game if a device that is being rebound becomes unresponsive.

&nbsp;

## `INPUT_GAMEPAD_THUMBSTICK_REPORTS_ACTIVE`

*Typical value: `false`*

Whether various noisy, error-prone inputs will report a device as active and trigger a hotswap. Because these inputs are unreliable, it is recommended that they are set to `false`. However, if you feel that damages your game's UX then set them to `true`.

&nbsp;

## `INPUT_MOUSE_BUTTON_REPORTS_ACTIVE`

*Typical value: `false`*

Whether various noisy, error-prone inputs will report a device as active and trigger a hotswap. Because these inputs are unreliable, it is recommended that they are set to `false`. However, if you feel that damages your game's UX then set them to `true`.

&nbsp;

## `INPUT_MOUSE_MOVEMENT_REPORTS_ACTIVE`

*Typical value: `false`*

Whether various noisy, error-prone inputs will report a device as active and trigger a hotswap. Because these inputs are unreliable, it is recommended that they are set to `false`. However, if you feel that damages your game's UX then set them to `true`.

&nbsp;

## `INPUT_COLLECT_MODE`

*Typical value: `0`*

Controls how the library collects player input. If `INPUT_UPDATE_AFTER_COLLECT` is set to `true` (which it is by default) then this macro also controls how the library updates itself overall.

0. The library will create a persistent and invisible controller instance at the start of the game and will collect player input in the Begin Step event. This means verbs, gamepads etc. are updated as soon as possible in a frame. This doesn't necessarily mean verb state is updated as the very first task but it'll be close. Unfortunately, this method requires that a persistent instance has to be created and destroying or deactivating this instance will lead to the library emitting an error message.

1. Use a GameMaker time source to collect player input. This means verbs, gamepads etc. are updated somewhere between the Begin Step and Step events. This is the most reliable way of updating input but it does mean that library state in Begin Step event is a frame behind the Step event.

2. The library will not automatically collect player input. Instead, you must call `InputManualCollect()` yourself. This gives you maximum flexibility in how player input is collected at the cost of having to manage that yourself.

&nbsp;

## `INPUT_UPDATE_AFTER_COLLECT`

*Typical value: `true`*

Whether to update library state immediately after collecting player input. This is set to `true` by default. If this macro is set to `false` then you should call `InputManualUpdate()` at some point after InputManualCollect() to update the library state. This macro is intended for use with fixed timestep or lockstep implementations. In those situations, you should collect player input within the main GameMaker update loop (see `INPUT_COLLECT_MODE` above). When you want to evaluate a tick of a fixed timestep or lockstep loop then call `InputManualUpdate()` once and then you may call library functions within your custom update loop as normal.