# Verbs and Default Bindings

&nbsp;

Input uses a "verb interface" to coalesce input into easily managed instructions.

Verbs are the basic input actions you want to expose to a player; this includes things like jumping, shooting, pausing the game, or moving in a particular direction. By using verbs we **abstract** user input so that we can change [input source](Input-Sources) whilst playing the game without needing to change anything else. Using verbs also allows for easier key rebinding.

When using Input, you'll need to define your own verb names. A verb name can be either a **string** or a **number**. It is recommend that you use a string to store your verb names, but you're welcome to use whatever method suits you (such as using an enum).

[Several functions](<Functions-(Default-Bindings)>) also include an optional `[alternate]` argument. You can think of alternate bindings as binding "slots" for each verb. This argument allows you to bind multiple similar inputs to the same verb for the same type of [input source](Input-Sources). This is used, for example, to allow both WASD and arrow keys, or both dpad and thumbstick to simultaneously control player movement. `[alternate]` defaults to `0`, while greater values allow you to read and write alternate binding slots.

---

Let's start with a Step event that controls the player for a simple Space Invaders sort of game:

```gml
//// Step event ////

//Move the player if the left or right verb is activated
if (input_check("left")) x -= 4;
if (input_check("right")) x += 4;

//If the player pressed the shoot button, shoot a bullet
if (input_check_pressed("shoot")) shoot_bullet(x, y);
```

In `__input_config_profiles_and_bindings()` we can set up the keyboard bindings like so.

```gml
INPUT_DEFAULT_PROFILES = {
    
    //Bind keyboard controls to verbs
    keyboard_and_mouse:
    {
        left:  input_binding_key(vk_left),
        right: input_binding_key(vk_right),
        shoot: input_binding_key(vk_space),
    },
}
```

&nbsp;

Now let's add some more bindings so that the player can play with a gamepad. We use the `"gamepad"` profile name here to indicate that we want to use a separate profile to store gamepad bindings. The default value for `INPUT_AUTO_PROFILE_FOR_GAMEPAD` is `"gamepad"` so lets use that as the profile name so that when a player hotswaps to a gamepad Input will automatically choose to use the correct bindings.

```gml
INPUT_DEFAULT_PROFILES = {
    
    //Bind keyboard controls to verbs
    keyboard_and_mouse:
    {
        left:  input_binding_key(vk_left),
        right: input_binding_key(vk_right),
        shoot: input_binding_key(vk_space),
    },
	
	gamepad:
	{
        left:  input_binding_gamepad_button(gp_padl),
        right: input_binding_gamepad_button(gp_padr),
        shoot: input_binding_gamepad_button(gp_face1),
	}
}
```

Despite adding these new bindings, we don't need to change anything in our Step event. Because we're using a **verb interface**, all of our binding commands exist separately to our check functions. We can bind multiple kinds of input to the same verb and the relevant binding is used depending on what [input source](Input-Sources) the player is using.

Let's add some alternate bindings:

```gml
INPUT_DEFAULT_PROFILES = {
    
    //Bind keyboard controls to verbs
    keyboard_and_mouse:
    {
        left:  [input_binding_key(vk_left),  input_binding_key("A")],
        right: [input_binding_key(vk_right), input_binding_key("S")],
        shoot: [input_binding_key(vk_space), input_binding_key(vk_enter)],
    },
	
	gamepad:
	{
        left:  [input_binding_gamepad_button(gp_padl),  input_binding_gamepad_axis(gp_axislh, true )],
        right: [input_binding_gamepad_button(gp_padr),  input_binding_gamepad_axis(gp_axislh, false)],
        shoot: [input_binding_gamepad_button(gp_face1), input_binding_gamepad_button(gp_face2)      ],
	}
}
```

Once again, our Step event didn't change. However, we've now added lots more controls that the player can use to control their character.