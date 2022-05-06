# Verbs and Alternate Bindings

---

Input uses a "verb interface" to coalesce input into easily managed instructions.

Verbs are the basic input actions you want to expose to a player; this includes things like jumping, shooting, pausing the game, or moving in a particular direction. By using verbs we **abstract** user input so that we can change [input source](Input-Sources) whilst playing the game without needing to change anything else. Using verbs also allows for easier key rebinding.

When using Input, you'll need to define your own verb names. A verb name can be either a **string** or a **number**. It is recommend that you use an enum or some macros to store your verb names, but you're welcome to use whatever verb names suit you.

[Several functions](<Functions-(Default-Bindings)>) also include an optional `[alternate]` argument. You can think of alternate bindings as binding "slots" for each verb. This argument allows you to bind multiple similar inputs to the same verb for the same type of [input source](Input-Sources). This is used, for example, to allow WASD and arrow keys to simultaneously control player movement. `[alternate]` defaults to `0`, but increasing this integer will allow you to read and write alternate binding slots.

---

Here is a simple example for a Space Invaders sort of game:

```gml
//// Game Start event ////

//Declare an enum that stores verb names
enum eVerb
{
    Left,
    Right,
    Shoot,
}

//Bind keyboard controls to verbs
input_default_key(vk_left, eVerb.Left);
input_default_key(vk_right, eVerb.Right);
input_default_key(vk_space, eVerb.Shoot);



//// Step event ////

//Move the player if the Leftor Down verb is activated
if (input_check(eVerb.Left)) x -= 4;
if (input_check(eVerb.Right)) x += 4;

//If the player pressed the "Shoot" button, shoot a bullet
if (input_check_pressed(eVerb.Shoot)) shoot_bullet(x, y);
```

Now let's add some more bindings so that the player can play with a gamepad:

```gml
//// Game Start event ////

//Declare an enum that stores verb names
enum eVerb
{
    Left,
    Right,
    Shoot,
}

//Bind keyboard controls to verbs
input_default_key(vk_left, eVerb.Left);
input_default_key(vk_right, eVerb.Right);
input_default_key(vk_space, eVerb.Shoot);

//Bind gamepad controls to verbs
input_default_gamepad_button(gp_padl, eVerb.Left);
input_default_gamepad_button(gp_padr, eVerb.Right);
input_default_gamepad_button(gp_face1, eVerb.Shoot);



//// Step event ////

//Move the player if the Leftor Down verb is activated
if (input_check(eVerb.Left)) x -= 4;
if (input_check(eVerb.Right)) x += 4;

//If the player pressed the "Shoot" button, shoot a bullet
if (input_check_pressed(eVerb.Shoot)) shoot_bullet(x, y);
```

Did you notice how the Step event code didn't change at all? Because we're using a **verb interface**, all of our binding commands exist separately to our check functions. We can bind multiple kinds of input to the same verb and the relevant binding is used depending on what [input source](Input-Sources) the player is using.

Let's add some alternate bindings:

```gml
//// Game Start event ////

//Declare an enum that stores verb names
enum eVerb
{
    Left,
    Right,
    Shoot,
}

//Bind keyboard controls to verbs
input_default_key(vk_left, eVerb.Left);
input_default_key(vk_right, eVerb.Right);
input_default_key(vk_space, eVerb.Shoot);

//Alternate keyboard bindings
input_default_key(ord("A"), eVerb.Left, 1); //We use 1 here to indicate we're setting an alternate binding
input_default_key(ord("S"), eVerb.Right, 1);
input_default_key(vk_enter, eVerb.Shoot, 1);

//Bind gamepad controls to verbs
input_default_gamepad_button(gp_padl, eVerb.Left);
input_default_gamepad_button(gp_padr, eVerb.Right);
input_default_gamepad_button(gp_face1, eVerb.Shoot);

//Alternate gamepad bindings
input_default_gamepad_axis(gp_axislh, true, eVerb.Left, 1);
input_default_gamepad_axis(gp_axislh, false, eVerb.Right, 1);
//All the face buttons shoot!
//Don't forget to use different numbers for different alternate binding slots
input_default_gamepad_button(gp_face2, eVerb.Shoot, 1);
input_default_gamepad_button(gp_face3, eVerb.Shoot, 2);
input_default_gamepad_button(gp_face4, eVerb.Shoot, 3);



//// Step event ////

//Move the player if the Left or Right verb is activated
if (input_check(eVerb.Left)) x -= 4;
if (input_check(eVerb.Right)) x += 4;

//If the player pressed the "Shoot" button, shoot a bullet
if (input_check_pressed(eVerb.Shoot)) shoot_bullet(x, y);
```

Once again, our Step event didn't change. However, we've now added lots more controls that the player can use to control their character.
