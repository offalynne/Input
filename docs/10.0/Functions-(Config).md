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

`InputDefineVerb(verbIndex, exportName, defaultKbmBinding, defaultGamepadBinding)`

<!-- tabs:start -->

#### **Description**

**Returns:** Boolean, whether the verb is active

|Name                   |Datatype|Purpose                                                             |
|-----------------------|--------|--------------------------------------------------------------------|
|`verbIndex`            |integer |Verb to target                                                      |
|`exportName`           |string  |Name to use to refer to this verb when exporting bindings           |
|`defaultKbmBinding`    |binding |Default binding to use when the player is using a keyboard and mouse|
|`defaultGamepadBinding`|binding |Default binding to use when the player is using a gamepad           |

This function defines a verb within Input. You should provide two sets of bindings - one that is the default binding when the player is using a keyboard and mouse (`INPUT_DEVICE_KBM`) and another for when the player is using a gamepad. Bindings should be specified using the `gp_*` constants for gamepads and the `vk_*` and `mb_*` constants for keyboards. Additionally, you may specify keyboard letter bindings using single character strings e.g. `"A"`.

You can specify multiple bindings for a verb by using an array. In this case, bindings will fill up the "alternate" binding slots for a verb. If you give one binding for a verb then it will fill binding slot 0. Please see the Examples tab for a demonstration.

The `exportName` parameter sets the name of this verb when exporting bindings. Export names should be unique (no two verbs may share the same export name).

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

`InputDefineCluster(clusterIndex, verbUp, verbRight, verbDown, verbLeft)`

<!-- tabs:start -->

#### **Description**

**Returns:** Boolean, whether the verb is active

|Name           |Datatype|Purpose                                             |
|---------------|--------|----------------------------------------------------|
|`clusterIndex` |integer |Verb to target                                      |
|`verbUp`       |integer |Verb to indicate up (positive y) movement           |
|`verbRight`    |integer |Verb to indicate right (positive x) movement        |
|`verbDown`     |integer |Verb to indicate down (negative y) movement         |
|`verbLeft`     |integer |Verb to indicate left (negative x) movement         |

This function defines verb clusters - there are groups of verbs that combine to give an x and y axis of motion. Clusters are a way of generalising keyboard input, thumbstick input, and dpad input into one interface. Clusters can be used with functions like `InputDirection()` and `InputX()` etc.

?> No, I'm not sure why the parameters are ordered this way either.

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

This script is simpler than `__InputConfigVerbs` - it is a list of macros that can be edited to adjust how the library behaves.

### `INPUT_MAX_PLAYERS`

_Typical value:_ `1`

The maximum number of players that your game supports.