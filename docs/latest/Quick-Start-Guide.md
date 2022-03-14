# Quick Start Guide

---

*This guide was written by community member **Grace**. You can find her on [Twitter](https://twitter.com/gart_gh) and on [Twitch](https://www.twitch.tv/gart222).*

&nbsp;

Hey there! Maybe you heard on the grapevine that the pug has some new tools for you to play with.  Maybe you've tried to get this to work already, and missed one or two crucial details that were required to make it work.  Well, fear no more because I'm about to show you the ropes.  This guide assumes you have a pretty baseline level on how to use GMS, it won't be going into how to make any of the gamey bits, just how to make the input system start y'know, reading your input.

&nbsp;

## Step 1:  Setup

To get this whole rigamaroll on the road, first thing you're gonna want to do is to drag the [.yymps file](https://github.com/JujuAdams/Input/releases) you got into your project.  Some kind of screen will pop up and you just gotta hit "add all" and then "OK".  This will leave you with a new folder in your Asset Browser labeled "Input".  That's good.  You want that.

Now since we're on a roll, why don't you make an input manager object?  I'm gonna call mine `obj_input_manager`, but you might have a better or funnier name or whatever.  Add yourself a Create event, a Begin Step event, and a Step Event.

Straight away you're going to want to put [`input_tick()`](Functions-(System)#input_tick) into your Begin Step event.
[`input_tick()`](Functions-(System)#input_tick) is a function that does a few important things, all you need to know for now is that it belongs there.

&nbsp;

## Step 2: The Verb Zone

Now that the boring techy stuff is out of the way, we can get to the real fun and power of this input system.  We're going to now be defining our verbs.

[Verbs](Verbs-and-Alternate-Bindings) are the basic input actions you want to expose to a player; this includes things like jumping, shooting, pausing the game, or moving in a particular direction. By using verbs we **abstract** user input so that we can change [input source](Input-Sources) while the game is played without needing to change anything else. Using verbs also allows for easier key rebinding.

Let's define some verbs then! You can put this in the Create event of your object... I'm going to define three controls, one for left, right, and shoot, and then we'll set the [input source](Input-Sources).

```
//Bind keyboard controls to verbs
input_default_key(vk_left, "left");
input_default_key(vk_right, "right");
input_default_key(ord("A"), "shoot"); 

input_player_source_set(INPUT_SOURCE.KEYBOARD_AND_MOUSE);
```
We've got the [`input_default_key()`](Functions-(Default-Bindings)#input_default_keykey-verb-alternate) functions taking the [normal key values](https://manual.yoyogames.com/GameMaker_Language/GML_Reference/Game_Input/Keyboard_Input/Keyboard_Input.htm) for the standard GM input features and then the verb we want to assign it to. Verbs can be numbers if you want to use an enum but, for ease of use, we'll stick to strings.

[`input_player_source_set()`](Functions-(Players)#input_player_source_setsource-playerindex) sets which device you're using. Now we're only one step away from using these tasty functions in game. By uh, using them. In game.

Here's a Step event for you to put in a character object or whatever!

 ```
//Move the player if the Left or Right verb is activated
if (input_check("left")) x -= 4;
if (input_check("right")) x += 4;

//If the player pressed the "Shoot" button, shoot a bullet
if (input_check_pressed("shoot")) show_debug_message("bang");
```

If you're at all familiar with how the standard GML input functions work, this should look pretty familiar to you. [`input_check()`](Functions-(Checkers)#input_checkverb-playerindex-bufferduration) is like [`keyboard_check()`](https://docs2.yoyogames.com/source/_build/3_scripting/4_gml_reference/controls/keyboard%20input/keyboard_check.html) and [`input_check_pressed()`](Functions-(Checkers)#input_check_pressedverb-playerindex-bufferduration) is like [`keyboard_check_pressed()`](https://docs2.yoyogames.com/source/_build/3_scripting/4_gml_reference/controls/keyboard%20input/keyboard_check_pressed.html).
Now, run the game and look at your hard work! Dang, aren't those inputs tasty? Ooh, looky here, buttons!

But by this point, you must be asking yourself "well grace, why didn't i just use `keyboard_check` functions and save myself all of this finagling?

Oh you sweet summer child, did you think we were done?

&nbsp;

## Step 3: Alternate bindings and more!

Lets go back to our create event for a hot sec.

Take a gander at this new code:

```
//Bind keyboard controls to verbs
input_default_key(vk_left, "left");
input_default_key(vk_right, "right");
input_default_key(ord("A"), "shoot"); 

//Bind gamepad controls to verbs
input_default_gamepad_button(gp_padl, "left");
input_default_gamepad_button(gp_padr, "right");
input_default_gamepad_button(gp_face1, "shoot");

//input_player_source_set(INPUT_SOURCE.KEYBOARD_AND_MOUSE);
input_player_source_set(INPUT_SOURCE.GAMEPAD);
input_player_gamepad_set(0);
```

Just like the keyboard functions, gamepad functions use [normal gamepad input values](https://manual.yoyogames.com/GameMaker_Language/GML_Reference/Game_Input/GamePad_Input/Gamepad_Input.htm) from standard GM features. Congratulations, you now have gamepad input!  In order for the player to be able to switch between keyboard and gamepad devices on the fly, add [`input_source_hotswap_tick()](input_source_hotswap_tick);` to your Step event.

Et voilà! This system is also great for rebinding controls, handling multiplayer, and more. Take a deeper dive into the documentation for details on the features of Input, and feel free to [join us for discussion on Discord](https://discord.gg/8krYCqr).
