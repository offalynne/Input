# Functions (Further Verbs)

&nbsp;

This page contains verb-related functions that don't fit elsewhere. They give you more control over the exact behaviour of verbs in your game, potentially giving you options to work around difficult interaction problems.

&nbsp;

## …verb_consume

`input_verb_consume(verb, [playerIndex])`

<!-- tabs:start -->

#### **Description**

**Returns:** N/A (`undefined`)

|Name           |Datatype                            |Purpose                                                                                                  |
|---------------|------------------------------------|---------------------------------------------------------------------------------------------------------|
|`verb`         |[verb](Verbs-and-Bindings)|[Verb](Verbs-and-Bindings) to consume. If keyword `all` is used, all verbs for the player(s) are consumed          |
|`[playerIndex]`|integer                             |Player to target. If not specified, player 0 is used.  If keyword `all` is used, all players are targeted|

When a verb has been consumed, [check functions](Functions-(Checkers)) that target the verb will return `false` until the button is released and pressed again. This function will clear the verb state similarly to how you might expect to use native functions [`keyboard_clear()`](https://manual.gamemaker.io/lts/en/GameMaker_Language/GML_Reference/Game_Input/Keyboard_Input/keyboard_clear.htm) and [`mouse_clear()`](https://manual.gamemaker.io/lts/en/GameMaker_Language/GML_Reference/Game_Input/Mouse_Input/mouse_clear.htm).

#### **Example**

```gml
//If we've selected this button...
if (input_check_pressed("ui select"))
{
	open_settings_menu();

	//Ensure the "ui select" verb can't instantly select a button on the settings menu
	input_verb_consume("ui select");
}
```

<!-- tabs:end -->

&nbsp;

## …verb_set

`input_verb_set(verb, value, [playerIndex])`

<!-- tabs:start -->

#### **Description**

**Returns:** N/A (`undefined`)

|Name           |Datatype                             |Purpose                                                                                                 |
|---------------|-------------------------------------|--------------------------------------------------------------------------------------------------------|
|`verb`         |[verb](Verbs-and-Bindings) |[Verb](Verbs-and-Bindings) to set                                                             |
|`value`        |number                               |Value to set for the verb, from `-1` to `+1` (though most verbs will only expect values from `0` to `+1`|
|`[playerIndex]`|integer                              |Player to target. If not specified, player 0 is used                                                    |

#### **Example**

```gml
//Read input values from a packet received on the network
var _left  = buffer_read(_net_buffer, buffer_f64);
var _right = buffer_read(_net_buffer, buffer_f64);

//Pass these values into Input to move the other player
input_verb_set("left", _left_value);
input_verb_set("right", _right_value)
```

<!-- tabs:end -->

&nbsp;

## …chord_create

`input_chord_create(name, maxTimeBetweenPresses, verb1, verb2, ...)`

<!-- tabs:start -->

#### **Description**

**Returns:** N/A (`undefined`)

|Name                   |Datatype                  |Purpose                                                                                                                        |
|-----------------------|--------------------------|-------------------------------------------------------------------------------------------------------------------------------|
|`name`                 |string                    |Name of the chord verb to create                                                                                               |
|`maxTimeBetweenPresses`|number                    |Maximum time allowed between verb activations, the units of which are determined by [`INPUT_TIMER_MILLISECONDS`](Config-Macros?id=general)|
|`verb1`                |[verb](Verbs-and-Bindings)|Name of a required [verb](Verbs-and-Bindings)                                                                                  |
|`verb2`                |[verb](Verbs-and-Bindings)|Name of a required [verb](Verbs-and-Bindings)                                                                                  |
|...                    |                          |etc.                                                                                                                           |

A "chord" is a set of verbs that must be pressed together (near simultaneously, in combination) for example `ctrl + alt + delete` or `ctrl + S`. When all of the specified verbs are pressed together, the chord verb itself is activated. If there is too much time between individual key presses, determined by the `maxTimeBetweenPresses` argument, then the chord verb will fail to activate.

#### **Example**

```gml
//// On boot...

//Create a chord to toggle debug mode
input_chord_create("debug toggle", 10, "scroll left", "scroll right", "pause");



//// In a Step event...

//Swap in and out of debug mode when the chord is activated
if (input_check_pressed("debug toggle"))
{
	global.debug_mode = not global.debug_mode;
}
```

<!-- tabs:end -->

&nbsp;

## …verb_get_group

`input_verb_get_group(verb)`

<!-- tabs:start -->

#### **Description**

**Returns:** String or `undefined`, the collision group defined for the target verb

|Name  |Datatype                  |Purpose                             |
|------|--------------------------|------------------------------------|
|`verb`|[verb](Verbs-and-Bindings)|[Verb](Verbs-and-Bindings) to target|

String values that this function may return are defined via [`INPUT_VERB_GROUPS`](Config-Macros?id=profiles-and-bindings). If no verb group has been defined for the target verb then this function will return `undefined` (and the verb is considered as being in every group).

#### **Example**

```gml
if (input_verb_get_group(verb_to_rebind) == "essential")
{
	//Essential verbs can't be rebound, show a pop-up
	instance_create_layer(x, y, "UI", obj_rebind_not_allowed);
}
else
{
	//Start rebinding for this verb
	input_binding_scan_start(function(_binding)
	{
		input_binding_set_safe(verb_to_rebind, _binding);
	})
}
```

<!-- tabs:end -->

&nbsp;

## …verb_group_active

`input_verb_group_active(verbGroup, state, [playerIndex], [exclusive])`

<!-- tabs:start -->

#### **Description**

**Returns:** N/A (`undefined`)

|Name           |Datatype                        |Purpose                                                                                                                                                                                                                                            |
|---------------|--------------------------------|---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
|`verbGroup`    |[verb group](Verbs-and-Bindings)|[Verb group](Verbs-and-Bindings) to target                                                                                                                                                                                                         |
|`state`        |boolean                         |State to set for the verb group                                                                                                                                                                                                                    |
|`[playerIndex]`|integer                         |Player to target. If not specified, player 0 is used                                                                                                                                                                                               |
|`[exclusive]`  |boolean                         |Whether to force all verb groups, other than the one being targeted, to be deactivated. This only applies if `state` is set to `true`. If not specified, `exclusive` defaults to `false`, allowing multiple verb groups to be active simultaneously|

A verb is considerd inactive when the verb group that that verb is a part of has been deactivated. A verb that has been assigned to no groups cannot be deactivated using this function.

#### **Example**

```gml
//If the player is trying to enter a car
if (input_check_pressed("interact") and (distance_to_object(obj_car) < 30))
{
	//Set the player's state
	state = "in car";

	//Turn off verbs in the "walking" group and turn on verbs in the "driving" group
	input_verb_group_active("walking", false);
	input_verb_group_active("driving", true);
}
```

<!-- tabs:end -->

&nbsp;

## …verb_group_is_active

`input_verb_group_is_active(verbGroup, [playerIndex])`

<!-- tabs:start -->

#### **Description**

**Returns:** Boolean, whether the verb group is active for the given player

|Name           |Datatype                        |Purpose                                             |
|---------------|--------------------------------|----------------------------------------------------|
|`verbGroup`    |[verb group](Verbs-and-Bindings)|[Verb group](Verbs-and-Bindings) to target          |
|`[playerIndex]`|integer                         |Player to target. If not specified, player 0 is used|

#### **Example**

```gml
if (input_verb_group_is_active("driving"))
{
	//Draw the driving controls when that verb group is active
	draw_driving_controls();
}
else
{
	//Otherwise draw the standard walking controls
	draw_walking_controls();
}
```

<!-- tabs:end -->

&nbsp;

## …verb_groups_get

`input_verb_groups_get()`

<!-- tabs:start -->

#### **Description**

**Returns:** Array, the verb groups set in `__input_config_verb_groups`

|Name|Datatype|Purpose|
|----|--------|-------|
|None|        |       |

#### **Example**

```gml
//Get all the verb groups in the game
var _verb_group_array = input_verb_groups_get();

//Create a tab on our settings menu for each group
for(var _i = 0; _i < array_length(_verb_group_array); _i++)
{
	create_controls_tab(_verb_group_array[_i]);
}
```

<!-- tabs:end -->

&nbsp;

## …verb_group_get_verbs

`input_verb_group_get_verbs(verbGroup)`

<!-- tabs:start -->

#### **Description**

**Returns:** Array, the verbs set for the verb group

|Name           |Datatype                        |Purpose                                             |
|---------------|--------------------------------|----------------------------------------------------|
|`verbGroup`    |[verb group](Verbs-and-Bindings)|[Verb group](Verbs-and-Bindings) to target          |

#### **Example**

```gml
//Get all the verbs for this group
var _verb_array = input_verb_group_get_verbs(verb_group);

//Create a rebinding button for each verb
for(var _i = 0; _i < array_length(_verb_array); _i++)
{
	create_rebinding_button(_verb_array[_i]);
}
```

<!-- tabs:end -->
