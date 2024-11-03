# Verbs and Bindings

&nbsp;

Input uses a "verb interface" to coalesce input into easily managed instructions. Verbs are created by calling [`InputDefineVerb()`](Config?id=inputdefineverb) in [`__InputConfigVerb()`](Config?id=__inputconfigverb).

Verbs are the basic input actions you want to expose to a player; this includes things like jumping, shooting, pausing the game, or moving in a particular direction. By using verbs we **abstract** user input so that we can change [device](Devices) whilst playing the game without needing to change anything else. Using verbs also allows for easier rebinding because we can update bindings behind the scenes to reroute player input, but the verb names themselves won't change. Verbs can be checked in multiple ways using the spectrum of [checker](Functions-(Checkers)) functions.

!> A verb reference is **always an integer** and should typically be a member of an enum. In previous versions of Input a verb name was a string but this is no longer the case.

A "binding" is a piece of logic that ties a physical input on an input device (keyboard, mouse, or gamepad) to a verb in-game. For example, we might want to create a binding that ties the up arrow key on a keyboard to a verb called `INPUT_VERB.UP`. To do this, we might execute the following code:

```gml
InputDefineVerb(INPUT_VERB.UP, "up", vk_up, undefined);
``` 

Some checker functions require the use of "clusters" which will be explained later in this document. Bindings are arranged into two groups: one group for keyboard and mouse input, and another group for gamepad input. Aside from defining bindings in `__InputConfigVerb()`, bindings can also be discovered by starting the [rebinding system](Functions-(Rebinding)?id=devicesetrebinding) and then calling [`InputDeviceGetRebindingResult()`](Functions-(Rebinding)?id=devicegetrebindingresult). Players will inherit default binding set via `__InputConfigVerb()`. A player's bindings be changed at will, and one player's bindings do not necessarily need to be the same as another player's. You can copy profiles between players using [`InputBindingsExport()`](Functions-(Rebinding)?id=bindingsexport) and [`InputBindingsImport()`](Functions-(Rebinding)?id=bindingsimport).

You may define multiple bindings per verb. You can think of alternate bindings as binding "slots" for each verb. These are called "alternates". Alternates are used, for example, to allow both WASD and arrow keys, or both dpad and thumbstick to simultaneously control player movement. Any verb can have alternates created for it and there is no limit on the number of alternates that can be set per verb.

## Example of Use

Let's demonstrate these concepts with a practical example. Let's make a basic platformer control scheme.

We start by defining an enum called `INPUT_VERB`. This serves two purposes: it ensures that we generate verb references that are integers, and that no verb references overlap

?> When you import Input it’ll come with some default controls already set up. To explain this clearer, we must delete everything that’s already in `__InputConfigVerb()` and start fresh. This is where we'll set up our default profile.

```gml
function __InputConfigVerbs()
{
    enum INPUT_VERB
    {
        LEFT,
        RIGHT,
        JUMP,
    }
    
    InputDefineVerb(INPUT_VERB.LEFT,  "left",  vk_left,  undefined);
    InputDefineVerb(INPUT_VERB.RIGHT, "right", vk_right, undefined);
    InputDefineVerb(INPUT_VERB.JUMP,  "jump",  vk_space, undefined);
}
```

In the above struct we've defined three verbs with keyboard bindings, `INPUT_VERB.LEFT`, `INPUT_VERB.RIGHT`, and `INPUT_VERB.JUMP`. Now that we've created default keyboard bindings, we can insert some verbs into our player object.

<!-- tabs:start -->
#### **Game Start**
```gml
//Make sure we have some resistance to movement to stop the player flying away
friction = 0.5;
gravity = 0.3;
```
#### **Step Event**
```gml
//Move the player if the left or right verb is activated
if (InputCheck(INPUT_VERB.LEFT )) hspeed = -4;
if (InputCheck(INPUT_VERB.RIGHT)) hspeed = 4;

//If the player pressed the jump button, jump!
if (InputCheckPressed(INPUT_VERB.JUMP)) vspeed = -8;
```
<!-- tabs:end -->

Now let's add some more bindings so that the player can play with a gamepad. Mouse and keyboard bindings chosen when the player starts pressing keys on the keyboard. We can also set up the same behaviour for gamepads such that when the player starts using a gamepad, Input will automatically change bindings and start scanning for input from the gamepad device as well.

```gml
function __InputConfigVerbs()
{
    enum INPUT_VERB
    {
        LEFT,
        RIGHT,
        JUMP,
    }
    
    InputDefineVerb(INPUT_VERB.LEFT,  "left",  vk_left,  gp_padl);
    InputDefineVerb(INPUT_VERB.RIGHT, "right", vk_right, gp_padr);
    InputDefineVerb(INPUT_VERB.JUMP,  "jump",  vk_space, gp_face1);
}
```

Despite adding these new bindings, we don't need to change anything in our Step event. Because we're using a **verb interface**, all of our binding commands exist separately to our check functions. We can bind multiple kinds of input to the same verb and the relevant binding is used depending on what [device](Devices) the player is using.

As mentioned above, we can also add alternate bindings for every verb.

```gml
function __InputConfigVerbs()
{
    enum INPUT_VERB
    {
        LEFT,
        RIGHT,
        JUMP,
    }
    
    InputDefineVerb(INPUT_VERB.LEFT,  "left",  [vk_left,  "A"     ], [gp_padl,  -gp_axislh]);
    InputDefineVerb(INPUT_VERB.RIGHT, "right", [vk_right, "S"     ], [gp_padr,   gp_axislh]);
    InputDefineVerb(INPUT_VERB.JUMP,  "jump",  [vk_space, vk_enter], [gp_face1,  gp_face2 ]);
}
```

Once again, our Step event didn't change. However, we've now added lots more controls that the player can use to control their character.

&nbsp;

## Clusters

Clusters are a group of four verbs that combine together to create two axes of movement. Clusters are useful to simplify two-dimensional movement and make it consistent across different input devices. Clusters are defined much in the same way as verbs. Cluster references are integers and to create a cluster you need to call a function, [`InputDefineCluster()`](Config?id=inputdefinecluster).

```gml

enum INPUT_CLUSTER
{
    NAVIGATION,
}

InputDefineCluster(INPUT_CLUSTER.NAVIGATION, INPUT_VERB.UP, INPUT_VERB.RIGHT, INPUT_VERB.DOWN, INPUT_VERB.LEFT);
```

Clusters do not need updating if verbs are rebound. 2D checkers such as `InputDirection()` require the use of a cluster and will return an accurate answer whereas using `point_direction()` on the basic verb values will not return an accurate answer due to the influence of gamepad thumbstick thresholds.