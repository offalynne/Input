# Verbs and Bindings

&nbsp;

Input uses a "verb interface" to coalesce input into easily managed instructions. Verbs are created by defining [default profiles](Profiles).

Verbs are the basic input actions you want to expose to a player; this includes things like jumping, shooting, pausing the game, or moving in a particular direction. By using verbs we **abstract** user input so that we can change [input source](Input-Sources) whilst playing the game without needing to change anything else. Using verbs also allows for easier rebinding because we can update bindings behind the scenes to reroute player input, but the verb names themselves won't change.

Verbs can be checked in multiple ways, mostly using the [checker](Functions-(Checkers)) and [2D checker](Functions-(2D-Checkers)) functions.

!> The name of a verb is **always a string**. In previous versions of Input, a verb name could also be a number, but this is no longer the case.

In addition to basic verbs, you can also create chords and combos. Chords and combos are built by calling [specific functions](Functions-(Extended-Verbs)). Basic verbs, chord verbs, and combo verbs can all be checked using the same functions (though you may find `input_check_double_pressed()` has limited uses for combo verbs).

A "binding" is a piece of logic that ties a physical input on an input source (keyboard, mouse, or gamepad) to a verb in-game. For example, we might want to create a binding that ties the up arrow key on a keyboard to a verb called `"move_up"`. There are [seven types of binding](Functions-(Binding-Creators)):

|Type                   |Creator function                                                                                    |
|-----------------------|----------------------------------------------------------------------------------------------------|
|Empty, inactive binding|[`input_binding_empty()`](Functions-(Binding-Creators)?id=binding_empty)                            |
|Keyboard key           |[`input_binding_key(key)`](Functions-(Binding-Creators)?id=binding_key)                             |
|Mouse button           |[`input_binding_mouse_button()`](Functions-(Binding-Creators)?id=binding_mouse_button)              |
|Mouse wheel up         |[`input_binding_mouse_wheel_up()`](Functions-(Binding-Creators)?id=binding_mouse_wheel_up)          |
|Mouse wheel down       |[`input_binding_mouse_wheel_down()`](Functions-(Binding-Creators)?id=binding_mouse_wheel_down)      |
|Gamepad button         |[`input_binding_gamepad_button(button)`](Functions-(Binding-Creators)?id=binding_gamepad_button)    |
|Gamepad axis           |[`input_binding_gamepad_axis(axis, negative)`](Functions-(Binding-Creators)?id=binding_gamepad_axis)|
|Virtual button         |[`input_binding_virtual_button()`](Functions-(Binding-Creators)?id=binding_virtual_button)          |

?> Aside from [binding creator functions](Functions-(Binding-Creators)), bindings can also be created by listening for player input using [the binding scan feature](Functions-(Binding-Scan)?id=binding_scan_start).

Bindings are arranged into groups called ["profiles"](Profiles). Profiles allow you to bundle bindings together, typically so that you can change what bindings are active depending on what [input source](Input-Sources) the player is using, but profiles are also useful for providing extra flexibility for genres such as fighting games. You may also want to create different profiles to store bindings for different gamepad types.

Players will inherit default profiles set via `__input_config_verbs()`. Bindings in a player's profile can be changed at will, and one player's bindings do not necessarily need to be the same as another player's. You can copy profiles between players using [`input_profile_copy()`](Functions-(Exporting-and-Importing)?id=profile_copy).

Profiles allow you to define multiple bindings per verb. You can think of alternate bindings as binding "slots" for each verb. These are called "alternates". Alternates are used, for example, to allow both WASD and arrow keys, or both dpad and thumbstick to simultaneously control player movement. Any verb can have alternates created for it, though there is a maximum number of alternates you can have per verb per profile (this is defined by the [`INPUT_MAX_ALTERNATE_BINDINGS`](Config-Macros?id=verb-behaviour) macro).

## Example of Use

Let's demonstrate these concepts with a practical example. Let's make a basic platformer control scheme.

We start by defining a default profile. This serves two purposes - firstly, it lets Input know what verbs we're expecting to use. Secondly, it allows us to create some bindings so that Input will know how to interpret user input straight away.

?> When you import Input it’ll come with some default controls already set up. To explain this clearer, we must delete everything that’s already in `__input_config_verbs()` and start fresh. This is where we'll set up our default profile.

```gml
return {

    //Bind keyboard controls to verbs
    keyboard_and_mouse:
    {
        left:  input_binding_key(vk_left),
        right: input_binding_key(vk_right),
        jump:  input_binding_key(vk_space),
    },
};
```

In the above struct we've defined a profile called `keyboard_and_mouse` and we've set up three verbs, `left`, `right`, and `jump`. This example presumes Input has been imported using its default configuration: `INPUT_AUTO_PROFILE_FOR_KEYBOARD` is set to `"keyboard_and_mouse"` and `INPUT_STARTING_SOURCE_MODE` is set to `INPUT_SOURCE_MODE.HOTSWAP`. This ensure that when your game starts, Input will automatically choose the `keyboard_and_mouse` profile (which we've just defined) whenever the player starts pressing keys on the keyboard.

?> Automatically switching between [input source](Input-Sources) is called "hotswapping" and is a native feature for Input. You can turn this feature off if you'd like by calling [`input_source_mode_set()`](Functions-(Sources)?id=input_source_mode_setmode) with a different [source mode](Input-Sources).

Now that we've created a default profile for keyboard usage, we can insert some verbs into our player object.

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
if (input_check("left")) hspeed = -4;
if (input_check("right")) hspeed = 4;

//If the player pressed the jump button, jump!
if (input_check_pressed("jump")) vspeed = -8;
```
<!-- tabs:end -->

Now let's add some more bindings so that the player can play with a gamepad. As mentioned above, the `keyboard_and_mouse` profile is chosen when the player starts pressing keys on the keyboard. We can also set up the same behaviour for gamepads such that when the player starts using a gamepad, Input will automatically change profile and start scanning for input from that source as well.

We make sure `INPUT_AUTO_PROFILE_FOR_GAMEPAD` is set to `"gamepad"` and then we add a `gamepad` profile to `__input_config_verbs()`.

```gml
return {
    
	//Bind keyboard controls to verbs
	keyboard_and_mouse:
	{
		left:  input_binding_key(vk_left),
		right: input_binding_key(vk_right),
		jump:  input_binding_key(vk_space),
	},
	
	gamepad:
	{
		left:  input_binding_gamepad_button(gp_padl),
		right: input_binding_gamepad_button(gp_padr),
		jump:  input_binding_gamepad_button(gp_face1),
	}
}
```

Despite adding these new bindings, we don't need to change anything in our Step event. Because we're using a **verb interface**, all of our binding commands exist separately to our check functions. We can bind multiple kinds of input to the same verb and the relevant binding is used depending on what [input source](Input-Sources) the player is using.

As mentioned above, we can also add alternate bindings for every verb. Input defaults to allowing 2 different bindings per verb (which can be increased by modifying [`INPUT_MAX_ALTERNATE_BINDINGS`](Config-Macros?id=verb-behaviour) so let's add some alternate bindings to show that off:

```gml
return {
    
	//Bind keyboard controls to verbs
	keyboard_and_mouse:
	{
		left:  [input_binding_key(vk_left),  input_binding_key("A")],
		right: [input_binding_key(vk_right), input_binding_key("S")],
		jump:  [input_binding_key(vk_space), input_binding_key(vk_enter)],
	},
	
	gamepad:
	{
		left:  [input_binding_gamepad_button(gp_padl),  input_binding_gamepad_axis(gp_axislh, true )],
		right: [input_binding_gamepad_button(gp_padr),  input_binding_gamepad_axis(gp_axislh, false)],
		jump:  [input_binding_gamepad_button(gp_face1), input_binding_gamepad_button(gp_face2)      ],
	}
}
```

Once again, our Step event didn't change. However, we've now added lots more controls that the player can use to control their character.

&nbsp;

## Verb Groups

`__input_config_verb_groups()` allows you to differentiate groups of verbs that should not affect one another when checking for collisions (either using [`input_binding_test_collisions()`](Functions-(Binding-Access)?id=input_binding_test_collisionsverb-binding-playerindex-profilename) or [`input_binding_set_safe()`](Functions-(Binding-Access)?id=binding_set_safe)). This is useful for separating sets of verbs that are contextually separate, such as verbs that are used in a menu and verbs that are used during gameplay. By putting menu verbs and gameplay verbs in two different groups, two identical bindings in two different groups can co-exist.

A verb can only be in one group at a time and, once assigned a group, will only collide with other verbs in that group. If a verb is not assigned to a group then it may collide with all verbs, regardless of what group the colliding verb is in. You can return the group for a verb by calling [`input_verb_get_group()`](Functions-(Further-Verbs)?id=verb_get_group), and a verb that has not been assigned a group will return `undefined`.

`__input_config_verb_groups()` must be defined using the following format:
```
return {
    <group name>: [<verb1>, <verb2>, ...],
	<group name>: [<verb3>, <verb4>, ...],
	...
}
```

By default, `__input_config_verb_groups()` is set to an empty struct meaning that all verbs may collide with all other verbs.
