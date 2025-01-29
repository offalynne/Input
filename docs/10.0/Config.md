# Config

Input uses two configuration scripts to contain information that control how the library operates. The first is `__InputConfigVerbs` which contains verb and cluster definitions. These describe what the player is able to "do" in your game - move, jump, power slide and so on - and what the default keyboard key, gamepad button etc. triggers that verb. The second script is `__InputConfig` which has many macros in it that set global properties that affect how the lobrary operates.

!> You should edit `__InputConfig` and `__InputConfigVerbs` to meet the needs of your game.

&nbsp;

## `__InputConfigVerb`

`__InputConfigVerb` is split into two parts: the `INPUT_VERB` and `INPUT_CLUSTER` enums, and calls to `InputDefineVerb` and `InputDefineCluster`. You should edit `INPUT_VERB` and `INPUT_CLUSTER` to reflect the needs of your game. Input ships with a default enum layout that covers many types of game:

```gml
enum INPUT_VERB
{
    UP,
    DOWN,
    LEFT,
    RIGHT,
    ACCEPT,
    CANCEL,
    ACTION,
    SPECIAL,
    PAUSE,
}

enum INPUT_CLUSTER
{
    NAVIGATION,
}
```

These enums line up with the calls to `InputDefineVerb()` and `InputDefineCluster()` later in the script. These function calls define the default binding.

```gml
InputDefineVerb(INPUT_VERB.UP,      "up",         [vk_up,    "W"],    [-gp_axislv, gp_padu]);
InputDefineVerb(INPUT_VERB.DOWN,    "down",       [vk_down,  "S"],    [ gp_axislv, gp_padd]);
InputDefineVerb(INPUT_VERB.LEFT,    "left",       [vk_left,  "A"],    [-gp_axislh, gp_padl]);
InputDefineVerb(INPUT_VERB.RIGHT,   "right",      [vk_right, "D"],    [ gp_axislh, gp_padr]);
InputDefineVerb(INPUT_VERB.ACCEPT,  "accept",      vk_space,            gp_face1);
InputDefineVerb(INPUT_VERB.CANCEL,  "cancel",      vk_backspace,        gp_face2);
InputDefineVerb(INPUT_VERB.ACTION,  "action",      vk_enter,            gp_face3);
InputDefineVerb(INPUT_VERB.SPECIAL, "special",     vk_shift,            gp_face4);
InputDefineVerb(INPUT_VERB.PAUSE,   "pause",       vk_escape,           gp_start);

InputDefineCluster(INPUT_CLUSTER.NAVIGATION, INPUT_VERB.UP, INPUT_VERB.RIGHT, INPUT_VERB.DOWN, INPUT_VERB.LEFT);
```

Input also ships with a small piece of logic that changes the default bindings when the game is deployed on a Nintendo Switch. This is a nice affordance for the user experience to conform better with expectations on the platform (this code isn't shown above for brevity).

### `InputDefineVerb`

`InputDefineVerb(verbIndex, exportName, defaultKbmBinding, defaultGamepadBinding, [metadata={}])`

<!-- tabs:start -->

#### **Description**

**Returns:** Boolean, whether the verb is active

|Name                   |Datatype|Purpose                                                                                     |
|-----------------------|--------|--------------------------------------------------------------------------------------------|
|`verbIndex`            |integer |Verb to target                                                                              |
|`exportName`           |string  |Name to use to refer to this verb when exporting bindings                                   |
|`defaultKbmBinding`    |binding |Default binding to use when the player is using a keyboard and mouse                        |
|`defaultGamepadBinding`|binding |Default binding to use when the player is using a gamepad                                   |
|`[metadata]`           |any     |Metadata to attach to the cluster. If not specified, an empty struct is used as the metadata|

This function defines a verb within Input. You should provide two sets of bindings - one that is the default binding when the player is using a keyboard and mouse (`INPUT_DEVICE_KBM`) and another for when the player is using a gamepad. Bindings should be specified using the `gp_*` constants for gamepads and the `vk_*` and `mb_*` constants for keyboards. Additionally, you may specify keyboard letter bindings using single character strings e.g. `"A"`.

You can specify multiple bindings for a verb by using an array. In this case, bindings will fill up the "alternate" binding slots for a verb. If you give one binding for a verb then it will fill binding slot 0. Please see the Examples tab for a demonstration.

The `exportName` parameter sets the name of this verb when exporting bindings. Export names should be unique (no two verbs may share the same export name).

Metadata can be attached to a cluster by using the optional `metadata` parameter. Metadata is unique per cluster per player, that is to say that each cluster for each player will contain a unique copy of the metadata that is defined for this function. Metadata could be used to indicate within your code that a verb is non-rebindable and should not be shown on a rebinding menu etc.  Metadata should not be used to replicate features that appear elsewhere in the Input library to avoid duplicating features. Metadata can be modified per verb per player using the `InputVerb*Metadata()` functions.

!> Once you have decided on an export name for a verb **you must never change it**. Doing so will invalidate any bindings that have been saved by your players.

#### **Example**

```gml
// The "jump" verb is triggered by the spacebar or the A button on an Xbox gamepad
InputDefineVerb(INPUT_VERB.JUMP, "jump", vk_space, gp_face1);

// The "up" verb is triggered by either the up arrow key or the W key, or the left thumbstick or dpad on a gamepad.
InputDefineVerb(INPUT_VERB.UP, "up", [vk_up, "W"], [-gp_axislv, gp_padu]);
```

<!-- tabs:end -->

&nbsp;

### `InputDefineCluster`

`InputDefineCluster(clusterIndex, verbUp, verbRight, verbDown, verbLeft, [axisBiasFactor=0], [axisBiasDiagonals=false], [metadata={}])`

<!-- tabs:start -->

#### **Description**

**Returns:** Boolean, whether the verb is active

|Name                 |Datatype|Purpose                                                                                                                              |
|---------------------|--------|-------------------------------------------------------------------------------------------------------------------------------------|
|`clusterIndex`       |integer |Verb to target                                                                                                                       |
|`verbUp`             |integer |Verb to indicate up (positive y) movement                                                                                            |
|`verbRight`          |integer |Verb to indicate right (positive x) movement                                                                                         |
|`verbDown`           |integer |Verb to indicate down (negative y) movement                                                                                          |
|`verbLeft`           |integer |Verb to indicate left (negative x) movement                                                                                          |
|`[axisBiasFactor]`   |number  |Biasing factor to apply to nudge thumbstick input towards major axes. If not specified, this is set to `0.0` which applies no biasing|
|`[axisBiasDiagonals]`|boolean |Whether to bias to diagonals (`true`) or just axes (`false`). If not specified, this is set to `false`                               |
|`[metadata]`         |any     |Metadata to attach to the cluster. If not specified, an empty struct is used as the metadata                                         |

This function defines verb clusters - there are groups of verbs that combine to give an x and y axis of motion. Clusters are a way of generalising keyboard input, thumbstick input, and dpad input into one interface. Clusters can be used with functions like `InputDirection()` and `InputX()` etc.

The optional `axisBiasFactor` parameter allows you to bias the cluster along straight lines along the x and y axes. This makes it easier for the player to input exactly horizontal and exactly vertical movement. The value for this parameter should be from `0.0` to `1.0`. Higher values make the biasing behaviour stronger. The default value for `axisBiasFactor` is `0.0` which confers no axis bias whatsoever.

`axisBiasDiagonals` controls whether the axis bias should also allow diagonal inputs. It defaults to `false`: biasing will not select diagonal directioons. Setting this parameter to `true` will allow diagonal directions.

Metadata can be attached to a cluster by using the optional `metadata` parameter. Metadata is unique per cluster per player, that is to say that each cluster for each player will contain a unique copy of the metadata that is defined for this function.  Metadata should not be used to replicate features that appear elsewhere in the Input library to avoid duplicating features. Metadata can be modified per cluster per player using the `InputCluster*Metadata()` functions.

!> Be careful with this function's unusual argument order.

#### **Example**

```gml
InputDefineCluster(INPUT_CLUSTER.NAVIGATION, INPUT_VERB.UP, INPUT_VERB.RIGHT, INPUT_VERB.DOWN, INPUT_VERB.LEFT);
```

<!-- tabs:end -->

&nbsp;

### Adding New Verbs

Adding a new verb is a two step process:

1. Add the new verb to the `INPUT_VERB` enum in `__InputConfigVerbs`.

2. Call `InputDefineVerb()` in `__InputConfigVerbs` to set up a default binding for the verb.

If you want to use a verb in a cluster, you'll need to add that verb to the cluster by calling `InputDefineCluster()`. And that's it! Once you've added a verb then you'll be able to use that verb wherever you want in your game.

A few points to consider:

- Verbs can share the same binding (e.g. two verbs bound to `vk_space`) but this may cause problems when rebinding controls. Generally, we recommend trying to stick to one binding to one verb if possible.

- Once you decide on an export name (see `InputDefineVerb` function documentation above) you **should never change it**. If you change the export name then any bindings that you have saved to a file run the risk of becoming corrupted.

- Additionally, two verbs cannot share the same export name.

- There is a minor performance penalty for each verb you add to your game. If any verbs are unused, we recommend that you remove them to squeeze a little more performance out of your game.

&nbsp;

## `__InputConfig`

This script is simpler than `__InputConfigVerbs` - it is a list of macros that can be edited to adjust how the library behaves. You should adjust these macros according to your needs. When updating Input, you will usually need to back up any macros that you've changed and then restore those values after updating the library.

&nbsp;

### `INPUT_MAX_PLAYERS` {docsify-ignore}

*Typical value: `1`*

The maximum number of players that the library will permit. Setting this number higher will incur a slight performance penalty.

&nbsp;

## Checkers

### `INPUT_REPEAT_DEFAULT_DELAY` {docsify-ignore}

*Typical value: `9`*

Default values for `InputRepeat()`. Please see that function for documentation on behaviour.

&nbsp;

### `INPUT_REPEAT_DEFAULT_PREDELAY` {docsify-ignore}

*Typical value: `25`*

Default values for `InputRepeat()`. Please see that function for documentation on behaviour.

&nbsp;

### `INPUT_LONG_DEFAULT_DELAY` {docsify-ignore}

*Typical value: `10`*

Default values for the "long" checker functions. Please see that function for documentation on behaviour.

&nbsp;

### `INPUT_OPPOSING_DEFAULT_MOST_RECENT` {docsify-ignore}

*Typical value: `true`*

Default values for the "opposing" checker functions. Please see that function for documentation on behaviour.

&nbsp;

## Analogue Thresholds

### `INPUT_MOUSE_MOVE_DEADZONE` {docsify-ignore}

*Typical value: `2`*

The distance the mouse must move before it is reported as active via `InputMouseMoved()`. This value should be set as high as pos

&nbsp;

### `INPUT_GAMEPAD_THUMBSTICK_MIN_THRESHOLD` {docsify-ignore}

*Typical value: `0.25`*

Minimum threshold for directional (thumbstick) axes. This value is used for detecting gamepad input when hotswapping so make sure you set it above 0.

&nbsp;

### `INPUT_GAMEPAD_THUMBSTICK_MAX_THRESHOLD` {docsify-ignore}

*Typical value: `0.8`*

Maximum threshold for directional (thumbstick) axes.

&nbsp;

## Touchscreen & Virtual Buttons

### `INPUT_GAMEPAD_TRIGGER_MIN_THRESHOLD` {docsify-ignore}

*Typical value: `0.05`*

Default minimum threshold for non-directional (trigger) axes. This value is used for detecting gamepad input when hotswapping so make sure you set it above 0.

&nbsp;

### `INPUT_GAMEPAD_TRIGGER_MAX_THRESHOLD` {docsify-ignore}

*Typical value: `0.9`*

Default maximum threshold for non-directional (trigger) axes.

&nbsp;

### `INPUT_VIRTUAL_BUTTON_HISTORY_FRAMES` {docsify-ignore}

*Typical value: `10`*

How many frames of history to record for virtual buttons that have the feature turned on.

&nbsp;

### `INPUT_MOUSE_CAN_USE_VIRTUAL_BUTTONS` {docsify-ignore}

*Typical value: `false`*

Whether players with the `INPUT_KBM` device can use virtual buttons. This is helpful when testing virtual buttons on your development mac

&nbsp;

### `INPUT_ALLOW_TOUCH_ON_DESKTOP` {docsify-ignore}

*Typical value: `false`*

Whether `INPUT_TOUCH` will be considered connected (and therefore available) on desktop platforms. The library will never hotswap to `INPUT_TOUCH` on desktop and will prefer `INPUT_KBM` so to use `INPUT_TOUCH` you will need to.

&nbsp;

### `INPUT_MAX_TOUCHPOINTS` {docsify-ignore}

*Typical value: `4`*

The maximum number of touchpoints to track when using the INPUT_TOUCH device.

&nbsp;

### `INPUT_TOUCH_EDGE_DEADZONE` {docsify-ignore}

*Typical value: `35`*

Margin in pixels around the screen edge where gaining or losing a touch point will not register "pressed" or "released". Prevents false positives when dragging on to or off of the edge of a touchscreen.

&nbsp;

### `INPUT_VIRTUAL_BUTTON_MIN_THRESHOLD` {docsify-ignore}

*Typical value: `50`*

Default threshold values for 2D virtual buttons (thumbsticks). These values are measured in pixels in GUI-space.

&nbsp;

### `INPUT_VIRTUAL_BUTTON_MAX_THRESHOLD` {docsify-ignore}

*Typical value: `100`*

Default threshold values for 2D virtual buttons (thumbsticks). These values are measured in pixels in GUI-space.

&nbsp;

## Library Mechanics

### `INPUT_REBIND_TIMEOUT` {docsify-ignore}

*Typical value: `5000`*

How long to wait before automatically cancelling rebinding, measured in milliseconds. An automatic timeout is important to ensure that players don't softlock their game if a device that is being rebound becomes unresponsive.

&nbsp;

### `INPUT_GAMEPAD_THUMBSTICK_REPORTS_ACTIVE` {docsify-ignore}

*Typical value: `false`*

Whether various noisy, error-prone inputs will report a device as active and trigger a hotswap. Because these inputs are unreliable, it is recommended that they are set to `false`. However, if you feel that damages your game's UX then set them to `true`.

&nbsp;

### `INPUT_MOUSE_BUTTON_REPORTS_ACTIVE` {docsify-ignore}

*Typical value: `false`*

Whether various noisy, error-prone inputs will report a device as active and trigger a hotswap. Because these inputs are unreliable, it is recommended that they are set to `false`. However, if you feel that damages your game's UX then set them to `true`.

&nbsp;

### `INPUT_MOUSE_MOVEMENT_REPORTS_ACTIVE` {docsify-ignore}

*Typical value: `false`*

Whether various noisy, error-prone inputs will report a device as active and trigger a hotswap. Because these inputs are unreliable, it is recommended that they are set to `false`. However, if you feel that damages your game's UX then set them to `true`.

&nbsp;

### `INPUT_COLLECT_MODE` {docsify-ignore}

*Typical value: `0`*

Controls how the library collects player input. If `INPUT_UPDATE_AFTER_COLLECT` is set to `true` (which it is by default) then this macro also controls how the library updates itself overall.

|Value|Behaviour|
|-----|---------|
`0`|The library will create a persistent and invisible controller instance at the start of the game and will collect player input in the Begin Step event. This means verbs, gamepads etc. are updated as soon as possible in a frame. This doesn't necessarily mean verb state is updated as the very first task but it'll be close. Unfortunately, this method requires that a persistent instance has to be created and destroying or deactivating this instance will lead to the library emitting an error message.
`1`|Use a GameMaker time source to collect player input. This means verbs, gamepads etc. are updated somewhere between the Begin Step and Step events. This is the most reliable way of updating input but it does mean that library state in Begin Step event is a frame behind the Step event.
`2`|The library will not automatically collect player input. Instead, you must call `InputManualCollect()` yourself. This gives you maximum flexibility in how player input is collected at the cost of having to manage that yourself.

&nbsp;

### `INPUT_UPDATE_AFTER_COLLECT` {docsify-ignore}

*Typical value: `true`*

Whether to update library state immediately after collecting player input. This is set to `true` by default. If this macro is set to `false` then you should call `InputManualUpdate()` at some point after InputManualCollect() to update the library state. This macro is intended for use with fixed timestep or lockstep implementations. In those situations, you should collect player input within the main GameMaker update loop (see `INPUT_COLLECT_MODE` above). When you want to evaluate a tick of a fixed timestep or lockstep loop then call `InputManualUpdate()` once and then you may call library functions within your custom update loop as normal.