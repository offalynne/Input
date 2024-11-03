# Newbie Guide

---

*This guide was originally authored by community member **Grace**.*

&nbsp;

Hey there! Maybe you heard on the grapevine that the pug has some new tools for you to play with. Maybe you've tried to get this to work already, and missed one or two crucial details that were required to make it work. Well, fear no more because I'm about to show you the ropes. This guide assumes you have a pretty baseline level on how to use GameMaker, it won't be going into how to make any of the gamey bits, just how to make the input system start y'know, reading your input.

&nbsp;

## Step 1: Setup

To get this show on the road, first thing you're gonna want to do is to drag the [.yymps file](https://github.com/offalynne/Input/releases) you got into your project. A dialogue will pop up and you just gotta hit "add all" and then "OK". This will leave you with a new folder in your Asset Browser labeled "Input". That's good. You want that.

!> Input creates an instance using an internal object when the game boots up. Make sure that you don't accidentally destroy or deactivate this instance!

&nbsp;

## Step 2: The Verb Zone

Now we can get to the real fun and power of this input system. We're going to now be defining our verbs.

[Verbs](Verbs-and-Bindings) are the basic input actions you want to expose to a player; this includes things like jumping, shooting, pausing the game, or moving in a particular direction. By using verbs we **abstract** user input so that we can change [device](Devices) while the game is played without needing to change anything else. Using verbs also allows for easier key rebinding.

Let's define some verbs then! To define default bindings for your verbs you'll need to edit the `__InputConfigVerbs()` script. When you import Input it'll come with some default controls already set up. To explain this clearer, let's delete everything that's already in `__InputConfigVerbs()` and start fresh.

I'm going to define three controls, one for left, right, and shoot. We need to create an [enum](https://manual.gamemaker.io/beta/en/GameMaker_Language/GML_Overview/Variables/Constants.htm) and then call a function for each member of the enum. The enum can be called anything you like but, by convention, we'll call it `INPUT_VERB`.

```gml
function __InputConfigVerbs()
{
    enum INPUT_VERB
    {
        LEFT,
        RIGHT,
        SHOOT,
    }
    
    InputDefineVerb(INPUT_VERB.LEFT,  "left",  vk_left,  undefined);
    InputDefineVerb(INPUT_VERB.RIGHT, "right", vk_right, undefined);
    InputDefineVerb(INPUT_VERB.SHOOT, "shoot", vk_space, undefined);
}
```

We've got the [`InputDefineVerb()`](https://offalynne.github.io/Input/#/10.0/Config?id=inputdefineverb) functions taking the [normal key values](https://manual.yoyogames.com/GameMaker_Language/GML_Reference/Game_Input/Keyboard_Input/Keyboard_Input.htm) for the standard GM input features and then the verb we want to assign it to. We also fill in the "export name" with a unique name for each verb. Finally, we leave the gamepad binding parameter as `undefined` (we'll set up gamepad bindings in a moment).

Here's a Step event for you to put in a character object or whatever!

```gml
//Move the player if the Left or Right verb is activated
if (InputCheck(INPUT_VERB.LEFT )) x -= 4;
if (InputCheck(INPUT_VERB.RIGHT)) x += 4;

//If the player pressed the "Shoot" button, fire a bullet
if (InputCheckPressed(INPUT_VERB.SHOOT)) show_debug_message("bang");
```

If you're at all familiar with how the standard GML input functions work, this should look pretty familiar to you. [`InputCheck()`](Functions-(Checkers)?id=check) is like [`keyboard_check()`](https://manual.yoyogames.com/#t=GameMaker_Language%252FGML_Reference%252FGame_Input%252FKeyboard_Input%252Fkeyboard_check.htm) and [`InputCheckPressed()`](Functions-(Checkers)?id=check_pressed) is like [`keyboard_check_pressed()`](https://manual.yoyogames.com/#t=GameMaker_Language%252FGML_Reference%252FGame_Input%252FKeyboard_Input%252Fkeyboard_check_pressed.htm). We use the enum we created to tell Input which values to check. Now, run the game and look at your hard work! Dang, aren't those inputs tasty? Ooh, looky here, buttons!

But by this point, you must be asking yourself "well grace, why didn't i just use `keyboard_check` functions and save myself all of this finagling?

Oh you sweet summer child, did you think we were done?

&nbsp;

## Step 3: Gamepad bindings

Lets go back to our default profiles in `__InputConfigVerbs()` for a hot sec.

Take a gander at this new code we'll add:

```gml
function __InputConfigVerbs()
{
    enum INPUT_VERB
    {
        LEFT,
        RIGHT,
        SHOOT,
    }
    
    InputDefineVerb(INPUT_VERB.LEFT,  "left",  vk_left,  -gp_axislh);
    InputDefineVerb(INPUT_VERB.RIGHT, "right", vk_right,  gp_axislh);
    InputDefineVerb(INPUT_VERB.SHOOT, "shoot", vk_space,  gp_face1);
}
```

Just like the keyboard binding functions, gamepad binding functions use [normal gamepad input values](https://manual.yoyogames.com/GameMaker_Language/GML_Reference/Game_Input/GamePad_Input/Gamepad_Input.htm) from standard GM features. Congratulations, you now have gamepad input.

Input by default will start scanning for gamepad input when your game boots up. If the player uses the keyboard then Input will switch over to using mouse and keyboard bindings, if the player uses a gamepad then Input will switch over to using the gamepad bindings.

&nbsp;

## Step 4: Next Steps

In Step 2, we used `InputCheck()` to move a character when a verb is activated. When using a gamepad, if the player is using a thumbstick or trigger axis, input may be analogue (a fractional value between `0` and `1`) instead of digital (boolean, `true` or `false`). You can find the analogue input value using [`InputValue()`](Functions-(Checkers)?id=value). If you want to handle movement in 2D, you'll want to set up clusters by calling `InputDefineCluster()` and then check 2D values by calling functions that use cluster (e.g. [`InputDirection()`](Functions-(Checkers)?id=direction)).

This is only scratching the surface of what Input is capable of. Further examples can be found in the project in the [main GitHub repository](https://github.com/offalynne/Input), including control rebinding and multiplayer. You should also take a deeper dive into the documentation for details on the features of Input, but if you get lost or want a quick answer, then we invite you to [join us on Discord](https://discord.gg/8krYCqr).
