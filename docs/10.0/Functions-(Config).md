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

#### **Example**

```gml
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

#### **Example**

```gml
InputDefineCluster(INPUT_CLUSTER.NAVIGATION, INPUT_VERB.UP, INPUT_VERB.RIGHT, INPUT_VERB.DOWN, INPUT_VERB.LEFT);
```

<!-- tabs:end -->

&nbsp;

### Adding New Verbs

Adding a new verb is a two step process:

1. Add the new verb to the `INPUT_VERB` enum in `__InputConfigVerbs`

2. Call `InputDefineVerb()` in `__InputConfigVerbs` to set up a default binding for the verb.

If you want to use a verb in a cluster, you'll need to add that verb to the cluster by calling `InputDefineCluster()`.