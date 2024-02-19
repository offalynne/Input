# Functions (Advanced Checkers)

&nbsp;

These functions expand upon the [basic verb checkers](Functions-(Checkers)) and give you access to more complex verb behaviours built in to Input.

&nbsp;

## …check_repeat

`input_check_repeat(verb, [playerIndex], [delay], [predelay])`

<!-- tabs:start -->

#### **Description**

**Returns:** Boolean, if the verb has been re-triggered by a repeater behaviour

|Name           |Datatype                        |Purpose                                                                                                                      |
|---------------|--------------------------------|-----------------------------------------------------------------------------------------------------------------------------|
|`verb`         |[verb](Verbs-and-Bindings)      |[Verb](Verbs-and-Bindings) to check                                                                                          |
|`[playerIndex]`|integer                         |Player to target. If not specified, player 0 is used                                                                         |
|`[delay]`      |frames/milliseconds             |Time between re-triggers; if not specified, this will default to [`INPUT_REPEAT_DEFAULT_DELAY`](Config-Macros). The units of this value are determined by [`INPUT_TIMER_MILLISECONDS`](Config-Macros?id=general)|
|`[predelay]`   |frames/milliseconds             |Time before the first re-trigger; if not specified, this will default to [`INPUT_REPEAT_DEFAULT_DELAY`](Config-Macros). The units of this value are determined by [`INPUT_TIMER_MILLISECONDS`](Config-Macros?id=general)|

This function will **not** return `true` on the same frame a verb is activated (unless `predelay` is set to 0). You'll probably want to combine this function with [`input_check_pressed()`](Functions-(Checkers)?id=check_pressed).

#### **Example**

```gml
//Delete a single file on a press, and delete multiple files if the verb is held
if (input_check_pressed("delete") or input_check_repeat("delete"))
{
    delete_file();
}
```

<!-- tabs:end -->

&nbsp;

## …check_double

`input_check_double(verb, [playerIndex], [bufferDuration])`

<!-- tabs:start -->

#### **Description**

**Returns:** Boolean, if the verb is currently active

|Name              |Datatype                        |Purpose                                                                                                   |
|------------------|--------------------------------|----------------------------------------------------------------------------------------------------------|
|`verb`            |[verb](Verbs-and-Bindings)/array|[Verb](Verbs-and-Bindings) to check, or an array of [verbs](Verbs-and-Bindings) (see below)               |
|`[playerIndex]`   |integer                         |Player to target. If not specified, player 0 is used                                                      |
|`[bufferDuration]`|frames/milliseconds             |Input buffering duration, the units of which are determined by [`INPUT_TIMER_MILLISECONDS`](Config-Macros?id=general)|

If an array of [verbs](Verbs-and-Bindings) is provided for the `verb` parameter, this function will return `true` if **any** of the verbs are currently active for the player. The maximum delay between button presses to activate this function is given by [`INPUT_DOUBLE_DELAY`](Config-Macros).

#### **Example**

```gml
if (input_check_double("right"))
{
    //If the player double-tapped "right" then sprint
    sprite_index = spr_player_sprint;
    hspeed = 7;
}
else if (input_check("right"))
{
    //Otherwise use the normal running speed/sprite
    sprite_index = spr_player_run;
    hspeed = 4;
}
```

<!-- tabs:end -->

&nbsp;

## …check_double_pressed

`input_check_double_pressed(verb, [playerIndex], [bufferDuration])`

<!-- tabs:start -->

#### **Description**

**Returns:** Boolean, if the verb is newly active

|Name              |Datatype                        |Purpose                                                                                                   |
|------------------|--------------------------------|----------------------------------------------------------------------------------------------------------|
|`verb`            |[verb](Verbs-and-Bindings)/array|[Verb](Verbs-and-Bindings) to check, or an array of [verbs](Verbs-and-Bindings) (see below)               |
|`[playerIndex]`   |integer                         |Player to target. If not specified, player 0 is used                                                      |
|`[bufferDuration]`|frames/milliseconds             |Input buffering duration, the units of which are determined by [`INPUT_TIMER_MILLISECONDS`](Config-Macros?id=general)|

If an array of [verbs](Verbs-and-Bindings) is provided for the `verb` parameter, this function will return `true` if **any** of the verbs are newly activated this frame for the player. The maximum delay between button presses to activate this function is given by [`INPUT_DOUBLE_DELAY`](Config-Macros).

#### **Example**

```gml
if (weapon == "boxing_gloves")
{
    //If the player has equipped the boxing gloves, only attack on a double tap
    //This does more damage but is slow to execute and animate
    if (input_check_double_pressed("attack"))
    {
        sprite_index = spr_player_attack_boxing_gloves;
        damage = 13;
    }
}
else
{
    //Otherwise attack on the first press of the "attack" verb
    if (input_check_pressed("attack"))
    {
        sprite_index = spr_player_attack_single;
        damage = 5;
    }
}
```

<!-- tabs:end -->

&nbsp;

## …check_double_released

`input_check_double_released(verb, [playerIndex], [bufferDuration])`

<!-- tabs:start -->

#### **Description**

**Returns:** Boolean, if the verb is newly deactivated this frame

|Name              |Datatype                        |Purpose                                                                                                   |
|------------------|--------------------------------|----------------------------------------------------------------------------------------------------------|
|`verb`            |[verb](Verbs-and-Bindings)/array|[Verb](Verbs-and-Bindings) to check, or an array of [verbs](Verbs-and-Bindings) (see below)               |
|`[playerIndex]`   |integer                         |Player to target. If not specified, player 0 is used                                                      |
|`[bufferDuration]`|frames/milliseconds             |Input buffering duration, the units of which are determined by [`INPUT_TIMER_MILLISECONDS`](Config-Macros?id=general)|

If an array of [verbs](Verbs-and-Bindings) is provided for the `verb` parameter, this function will return `true` if **any** of the verbs are newly deactivated this frame for the player. The maximum delay between button presses to activate this function is given by [`INPUT_DOUBLE_DELAY`](Config-Macros).

#### **Example**

```gml
if (input_check_double_released("bank right"))
{
    //Do a barrel roll on a double tap!
    sprite_index = spr_roll_right;
    hspeed = 4;
}
else if ((sprite_index != spr_roll_right) and input_check("bank right"))
{
    //Otherwise bank gently (if we're not already rolling)
    sprite_index = spr_bank_right;
    hspeed = 2;
}
else
{
    //Finally, reset our bank speed to 0 on no input
    hspeed = 0;
}
```

<!-- tabs:end -->

&nbsp;

## …check_long

`input_check_long(verb, [playerIndex], [bufferDuration])`

<!-- tabs:start -->

#### **Description**

**Returns:** Boolean, if the verb is currently active

|Name              |Datatype                        |Purpose                                                                                                   |
|------------------|--------------------------------|----------------------------------------------------------------------------------------------------------|
|`verb`            |[verb](Verbs-and-Bindings)/array|[Verb](Verbs-and-Bindings) to check, or an array of [verbs](Verbs-and-Bindings) (see below)               |
|`[playerIndex]`   |integer                         |Player to target. If not specified, player 0 is used                                                      |
|`[bufferDuration]`|frames/milliseconds             |Input buffering duration, the units of which are determined by [`INPUT_TIMER_MILLISECONDS`](Config-Macros?id=general)|

If an array of [verbs](Verbs-and-Bindings) is provided for the `verb` parameter, this function will return `true` if **any** of the verbs are currently active for the player. The hold time required to activate this function is given by [`INPUT_LONG_DELAY`](Config-Macros).

#### **Example**

```gml
if (input_check_long("pause"))
{
    //If we're showing the game off in DEMO_MODE then restart
    if (DEMO_MODE) game_restart();
}
```

<!-- tabs:end -->

&nbsp;

## …check_long_pressed

`input_check_long_pressed(verb, [playerIndex], [bufferDuration])`

<!-- tabs:start -->

#### **Description**

**Returns:** Boolean, if the verb is newly activated this frame

|Name              |Datatype                        |Purpose                                                                                                   |
|------------------|--------------------------------|----------------------------------------------------------------------------------------------------------|
|`verb`            |[verb](Verbs-and-Bindings)/array|[Verb](Verbs-and-Bindings) to check, or an array of [verbs](Verbs-and-Bindings) (see below)               |
|`[playerIndex]`   |integer                         |Player to target. If not specified, player 0 is used                                                      |
|`[bufferDuration]`|frames/milliseconds             |Input buffering duration, the units of which are determined by [`INPUT_TIMER_MILLISECONDS`](Config-Macros?id=general)|

If an array of [verbs](Verbs-and-Bindings) is provided for the `verb` parameter, this function will return `true` if **any** of the verbs are newly activated this frame for the player. The hold time required to activate this function is given by [`INPUT_LONG_DELAY`](Config-Macros).

#### **Example**

```gml
//Crouch when we press the "duck" verb
if (input_check_press("duck"))
{
    sprite_index = spr_player_crouch;
    max_speed = 4;
}
else if (input_check_long_pressed("duck"))
{
    //But if we hold the "duck" verb for longer then crawl
    sprite_index = spr_player_crawl;
    max_speed = 2;
}
```

<!-- tabs:end -->

&nbsp;

## …check_long_released

`input_check_long_released(verb, [playerIndex], [bufferDuration])`

<!-- tabs:start -->

#### **Description**

**Returns:** Boolean, if the verb is newly deactivated this frame

|Name              |Datatype                        |Purpose                                                                                                   |
|------------------|--------------------------------|----------------------------------------------------------------------------------------------------------|
|`verb`            |[verb](Verbs-and-Bindings)/array|[Verb](Verbs-and-Bindings) to check, or an array of [verbs](Verbs-and-Bindings) (see below)               |
|`[playerIndex]`   |integer                         |Player to target. If not specified, player 0 is used                                                      |
|`[bufferDuration]`|frames/milliseconds             |Input buffering duration, the units of which are determined by [`INPUT_TIMER_MILLISECONDS`](Config-Macros?id=general)|

If an array of [verbs](Verbs-and-Bindings) is provided for the `verb` parameter, this function will return `true` if **any** of the verbs are newly deactivated this frame for the player. The hold time required to activate this function is given by [`INPUT_LONG_DELAY`](Config-Macros).

#### **Example**

```gml
if (input_check_long_released("attack"))
{
    //Perform a big flashy attack move if we charged up the attack
    sprite_index = spr_spin_attack;
    damage = 23;
}
else if (input_check_released("attack"))
{
    //Otherwise swing weakly
    sprite_index = spr_standard_attack;
    damage = 15;
}
```

<!-- tabs:end -->

&nbsp;

## …check_quick_pressed

`input_check_quick_pressed(verb, [playerIndex], [bufferDuration])`

<!-- tabs:start -->

#### **Description**

**Returns:** Boolean, whether the given verb has been actived by a quick tap on an analogue (thumbstick/trigger) axis this frame

|Name              |Datatype                        |Purpose                                                                                                   |
|------------------|--------------------------------|----------------------------------------------------------------------------------------------------------|
|`verb`            |[verb](Verbs-and-Bindings)/array|[Verb](Verbs-and-Bindings) to check, or an array of [verbs](Verbs-and-Bindings) (see below)               |
|`[playerIndex]`   |integer                         |Player to target. If not specified, player 0 is used                                                      |
|`[bufferDuration]`|frames/milliseconds             |Input buffering duration, the units of which are determined by [`INPUT_TIMER_MILLISECONDS`](Config-Macros?id=general)|

If an array of [verbs](Verbs-and-Bindings) is provided for the `verb` parameter, this function will return `true` if **any** of the verbs are quick tapped this frame for the player.

!> This function will only work with anaologue input. This function will return `false` if any digital input is used.

#### **Example**

```gml
//If the player pulls too hard on the fishing rod then snap the line
if (input_check_quick_pressed("fishing rod"))
{
    audio_sound_play(snd_fishing_line_snap, 0, false);
    caught_fish.free = true;
}
```

<!-- tabs:end -->

&nbsp;

## …check_quick_pressed_2d

`input_check_quick_pressed_2d(verbLeft, verbRight, verbUp, verbDown, [playerIndex])`

<!-- tabs:start -->

#### **Description**

**Returns:** Boolean, whether the analogue inputs registered a quick tap this frame

|Name            |Datatype                  |Purpose                                                     |
|----------------|--------------------------|------------------------------------------------------------|
|`verbLeft`      |[verb](Verbs-and-Bindings)|[Verb](Verbs-and-Bindings) that moves the point of aim left |
|`verbRight`     |[verb](Verbs-and-Bindings)|[Verb](Verbs-and-Bindings) that moves the point of aim right|
|`verbUp`        |[verb](Verbs-and-Bindings)|[Verb](Verbs-and-Bindings) that moves the point of aim up   |
|`verbDown`      |[verb](Verbs-and-Bindings)|[Verb](Verbs-and-Bindings) that moves the point of aim down |
|`[playerIndex]` |integer                   |Player to target. If not specified, player 0 is used        |

!> Only analogue inputs can trigger quick taps. This function will return `false` if any digital input is used.

#### **Example**

```gml
//Double instance speed if input is quick (analogue only) or double-pressed (analogue or digital)
if (input_check_quick_pressed_2d("left", "right", "up", "down") 
or  input_check_double_pressed(["left", "right", "up", "down"]))
{
    speed *= 2;
}
```

<!-- tabs:end -->

&nbsp;

## …check_opposing

`input_check_opposing(verbNegative, verbPositive, [playerIndex], [mostRecent])`

<!-- tabs:start -->

#### **Description**

**Returns:** Real, the sign of the result of the negative and positive active verbs

|Name              |Datatype                  |Purpose                                                                                                   |
|------------------|--------------------------|----------------------------------------------------------------------------------------------------------|
|`verbNegative`    |[verb](Verbs-and-Bindings)|[Verb](Verbs-and-Bindings) to check as negative component                                                 |
|`verbPositive`    |[verb](Verbs-and-Bindings)|[Verb](Verbs-and-Bindings) to check as positive component                                                 |
|`[playerIndex]`   |integer                   |Player to target. If not specified, player 0 is used                                                      |
|`[mostRecent]`    |boolean                   |Whether to use the most recent input instead of returning `false` when two verbs conflict. `INPUT_DEFAULT_OPPOSING_MOST_RECENT` is used if unspecified|

#### **Example**

```gml
//Rotate the turret based on whether the "left" or "right" verb is active
//If the player holds both at the same time, the most recent verb takes priority
var _speed = 6;
direction += _speed*input_check_opposing("left", "right", 0, true);
```

<!-- tabs:end -->

&nbsp;

## …check_opposing_repeat

`input_check_opposing_repeat(verbNegative, verbPositive, [playerIndex], [mostRecent], [delay], [predelay])`

<!-- tabs:start -->

#### **Description**

**Returns:** Real, the sign of the result of the negative and positive active verbs as re-triggered by a repeater behaviour

|Name           |Datatype                        |Purpose                                                                                                                      |
|---------------|--------------------------------|-----------------------------------------------------------------------------------------------------------------------------|
|`verbNegative` |[verb](Verbs-and-Bindings)      |[Verb](Verbs-and-Bindings) to check as negative component                                                                    |
|`verbPositive` |[verb](Verbs-and-Bindings)      |[Verb](Verbs-and-Bindings) to check as positive component                                                                    |
|`[playerIndex]`|integer                         |Player to target. If not specified, player 0 is used                                                                         |
|`[mostRecent]` |boolean                         |Whether to use the most recent input instead of returning `false` when two verbs conflict. `INPUT_DEFAULT_OPPOSING_MOST_RECENT` is used if unspecified            |
|`[delay]`      |frames/milliseconds             |Time between re-triggers; if not specified, this will default to [`INPUT_REPEAT_DEFAULT_DELAY`](Config-Macros). The units of this value are determined by [`INPUT_TIMER_MILLISECONDS`](Config-Macros?id=general)|
|`[predelay]`   |frames/milliseconds             |Time before the first re-trigger; if not specified, this will default to [`INPUT_REPEAT_DEFAULT_DELAY`](Config-Macros). The units of this value are determined by [`INPUT_TIMER_MILLISECONDS`](Config-Macros?id=general)|

This function will **not** return `true` on the same frame a verb is activated (unless `predelay` is set to 0). You'll probably want to combine this function with [`input_check_pressed()`](Functions-(Checkers)#input_check_pressedverb-playerindex-bufferduration).

#### **Example**

```gml
//Change option we've selected based on the "menu up" and "menu down" verbs
//If the player holds either down, the menu option will quickly scroll
option += input_check_opposing_pressed("menu up", "menu down");
option += input_check_opposing_repeat( "menu up", "menu down");
if (loopMenu)
{
    option = option mod option_count;
}
else
{
    option = clamp(option, 0, option_count - 1);
}
```

<!-- tabs:end -->

&nbsp;

## …check_opposing_pressed

`input_check_opposing_pressed(verbNegative, verbPositive, [playerIndex], [mostRecent])`

<!-- tabs:start -->

#### **Description**

**Returns:** Real, the sign of the result of the negative and positive newly active verbs

|Name              |Datatype                  |Purpose                                                                                                   |
|------------------|--------------------------|----------------------------------------------------------------------------------------------------------|
|`verbNegative`    |[verb](Verbs-and-Bindings)|[Verb](Verbs-and-Bindings) to check as negative component                                                 |
|`verbPositive`    |[verb](Verbs-and-Bindings)|[Verb](Verbs-and-Bindings) to check as positive component                                                 |
|`[playerIndex]`   |integer                   |Player to target. If not specified, player 0 is used                                                      |
|`[mostRecent]`    |boolean                   |Whether to use the most recent input instead of returning `false` when two verbs conflict. `INPUT_DEFAULT_OPPOSING_MOST_RECENT` is used if unspecified|

#### **Example**

```gml
//Vertically flip our sprite based on whether the "up" or "down" verbs have been pressed
var _sign = input_check_opposing_pressed("up", "down");
if (_sign != 0)
{
    image_yscale = _sign;
    instance_create_depth(x, y, depth-1, obj_sparks);
}
```

<!-- tabs:end -->

&nbsp;

## …held_time

`input_held_time(verb, [playerIndex])`

<!-- tabs:start -->

#### **Description**

**Returns:** Number, the length of time that a verb has been active (held)

|Name           |Datatype                  |Purpose                                             |
|---------------|--------------------------|----------------------------------------------------|
|`verb`         |[verb](Verbs-and-Bindings)|[Verb](Verbs-and-Bindings) to check                 |
|`[playerIndex]`|integer                   |Player to target. If not specified, player 0 is used|

The units returned by this function is determined by `INPUT_TIMER_MILLISECONDS`. This function returns a value less than 0 if the verb is not active or is not being held.

#### **Example**

```gml
var _target_time = 20;
var _width       = 40;

//Determine how much of the bar to fill
var _time = max(0, input_held_time("bow attack"));
var _fill = clamp(_time/_target_time, 0, 1);

//Draw the bow charge bar's fill
draw_rectangle(x, y, x + _width*_fill, y + 10, false);

//Draw the outline of the charge bar
draw_rectangle(x, y, x + _width, y + 10, true);
```

<!-- tabs:end -->

&nbsp;

## …held_time_released

`input_held_time_released(verb, [playerIndex])`

<!-- tabs:start -->

#### **Description**

**Returns:** Number, how long the current verb was held when released

|Name           |Datatype                  |Purpose                                             |
|---------------|--------------------------|----------------------------------------------------|
|`verb`         |[verb](Verbs-and-Bindings)|[Verb](Verbs-and-Bindings) to check                 |
|`[playerIndex]`|integer                   |Player to target. If not specified, player 0 is used|

The units returned by this function is determined by `INPUT_TIMER_MILLISECONDS`. This function returns a value less than 0 if the verb is not active or was not released.

#### **Example**

```gml
//When we release the bow attack, determine how much damage to do
if (input_held_released("bow attack"))
{
    var _damage_multiplier;

    if (input_held_time_released("bow attack") > 20)
    {
        //Held for over 20 frames = Max power shot!
        _damage_multiplier = 2;
    }
    else if (input_held_time_released("bow attack") > 10)
    {
        //Held for anything over 10 frames = Standard shot
        _damage_multiplier = 1;
    }
    else if (input_held_time_released("bow attack") == 10)
    {
        //Held for extra 10 frames = Special snapshot bonus
        _damage_multiplier = 1.5;
    }
    else
    {
        //No damage at all
        _damage_multiplier = 0;
    }

    //Only create an arrow projectile if we're going to deal damage
    if (_damage_multiplier > 0)
    {
        instance_create_layer(x, y, "Projectiles", obj_player_arrow,
        {
            damage_multiplier: _damage_multiplier
        });
    }
}
```

<!-- tabs:end -->

&nbsp;

## …check_press_most_recent

`input_check_press_most_recent([array], [playerIndex])`

<!-- tabs:start -->

#### **Description**

**Returns:** String, most recent [verb](Verbs-and-Bindings) pressed in the specified array, or `undefined` if no verb is active

|Name              |Datatype                        |Purpose                                                                                                                                              |
|------------------|--------------------------------|-----------------------------------------------------------------------------------------------------------------------------------------------------|
|`[array]`         |[verb](Verbs-and-Bindings) array|Array of [verbs](Verbs-and-Bindings) to check. If keyword `all` is used, or this argument is not specified, then all verbs for the player are checked|
|`[playerIndex]`   |integer                         |Player to target. If not specified, player 0 is used                                                                                                 |

#### **Example**

```gml
//Choose the colour of the damage text based on what spell we cast last
switch(input_check_press_most_recent(["fire", "water", "air", "earth", "heart"])
{
    case "fire":  draw_set_colour(c_red);     break;
    case "water": draw_set_colour(c_blue);    break;
    case "air":   draw_set_colour(c_yellow);  break;
    case "earth": draw_set_colour(c_lime);    break;
    case "heart": draw_set_colour(c_fuchsia); break;
}

draw_text(x, y, "Damage: " + string(damage));

//Reset the draw colour!
draw_set_colour(c_white);
```

<!-- tabs:end -->

&nbsp;

## …max_value

`input_max_value(verb, [playerIndex])`

<!-- tabs:start -->

#### **Description**

**Returns:** Real, the maximum analogue value that the verb has received since it was pressed

|Name              |Datatype                        |Purpose                                                                                    |
|------------------|--------------------------------|-------------------------------------------------------------------------------------------|
|`verb`            |[verb](Verbs-and-Bindings)/array|[Verb](Verbs-and-Bindings) to check, or an array of [verbs](Verbs-and-Bindings) (see below)|
|`[playerIndex]`   |integer                         |Player to target. If not specified, player 0 is used                                       |

For on/off inputs, this function will return `0.0` or `1.0`.

If an array of [verbs](Verbs-and-Bindings) is provided for the `verb` parameter, this function will return the **sum** of the verb values for the player.

<!-- tabs:end -->
