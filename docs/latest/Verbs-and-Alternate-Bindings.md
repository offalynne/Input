# Verbs and Alternate Bindings

---

Input uses a "verb interface" to coalesce input into easily managed instructions.

Verbs are the basic input actions you want to expose to a player; this includes things like jumping, shooting, pausing the game, or moving in a particular direction. By using verbs we **abstract** user input so that we can change [input source](Input-Sources) whilst playing the game without needing to change anything else. Using verbs also allows for easier key rebinding.

When using Input, you'll need to define your own verb names. A verb name can be either a **string** or a **number**. It is recommend that you use a string to store your verb names, but you're welcome to use whatever method suits you (such as using an enum).

[Several functions](Functions-(Default-Bindings)) also include an optional `[alternate]` argument. You can think of alternate bindings as binding "slots" for each verb. This argument allows you to bind multiple similar inputs to the same verb for the same type of [input source](Input-Sources). This is used, for example, to allow both WASD and arrow keys, or both dpad and thumbstick to simultaneously control player movement. `[alternate]` defaults to `0`, but increasing this integer will allow you to read and write alternate binding slots.

-----

Here is a simple example for a Space Invaders sort of game:

```GML
//// Game Start event ////

//Bind keyboard controls to verbs
input_default_key(vk_left, "left");
input_default_key(vk_right, "right");
input_default_key(vk_space, "shoot");



//// Step event ////

//Move the player if the left or right verb is activated
if (input_check("left")) x -= 4;
if (input_check("right")) x += 4;

//If the player pressed the shoot button, shoot a bullet
if (input_check_pressed("shoot")) shoot_bullet(x, y);
```

Now let's add some more bindings so that the player can play with a gamepad:

```GML
//// Game Start event ////

//Bind keyboard controls to verbs
input_default_key(vk_left, "left");
input_default_key(vk_right, "right");
input_default_key(vk_space, "shoot");

//Bind gamepad controls to verbs
input_default_gamepad_button(gp_padl, "left");
input_default_gamepad_button(gp_padr, "right");
input_default_gamepad_button(gp_face1, "shoot");



//// Step event ////

//Move the player if the Leftor Down verb is activated
if (input_check("left")) x -= 4;
if (input_check("right")) x += 4;

//If the player pressed the shoot button, shoot a bullet
if (input_check_pressed("shoot")) shoot_bullet(x, y);
```

Did you notice how the Step event code didn't change at all? Because we're using a **verb interface**, all of our binding commands exist separately to our check functions. We can bind multiple kinds of input to the same verb and the relevant binding is used depending on what [input source](Input-Sources) the player is using.

Let's add some alternate bindings:

```GML
//// Game Start event ////

//Bind keyboard controls to verbs
input_default_key(vk_left, "left");
input_default_key(vk_right, "right");
input_default_key(vk_space, "shoot");

//Alternate keyboard bindings
input_default_key(ord("A"), "left", 1); //We use 1 here to indicate we're setting an alternate binding
input_default_key(ord("S"), "right", 1);
input_default_key(vk_enter, "shoot", 1);

//Bind gamepad controls to verbs
input_default_gamepad_button(gp_padl, "left");
input_default_gamepad_button(gp_padr, "right");
input_default_gamepad_button(gp_face1, "shoot");

//Alternate gamepad bindings
input_default_gamepad_axis(gp_axislh, true, "left", 1);
input_default_gamepad_axis(gp_axislh, false, "right", 1);
//All the face buttons shoot!
//Don't forget to use different numbers for different alternate binding slots
input_default_gamepad_button(gp_face2, "shoot", 1);
input_default_gamepad_button(gp_face3, "shoot", 2);
input_default_gamepad_button(gp_face4, "shoot", 3);



//// Step event ////

//Move the player if the Left or Right verb is activated
if (input_check("left")) x -= 4;
if (input_check("right")) x += 4;

//If the player pressed the shoot button, shoot a bullet
if (input_check_pressed("shoot")) shoot_bullet(x, y);
```

Once again, our Step event didn't change. However, we've now added lots more controls that the player can use to control their character.
