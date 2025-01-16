# Functions (Accessibility)

&nbsp;

## References

- [Game Accessibility Guidelines](https://gameaccessibilityguidelines.com/) from a panel of contributors, including [OneSwich](https://www.oneswitch.org.uk/)
- [Xbox Accessibility Guidelines for Input](https://docs.microsoft.com/en-us/gaming/accessibility/xbox-accessibility-guidelines/107) from Microsoft
- [DevKit Accessibility Resource](https://specialeffectdevkit.info/input/) from [SpecialEffect](https://www.specialeffect.org.uk/)

&nbsp;

## …axis_threshold_set

`input_axis_threshold_set(axis, min, max, [playerIndex])`

<!-- tabs:start -->

#### **Description**

**Returns:** A struct with two member variables, `__mini` and `__maxi`, containing the minimum and maximum thresholds

|Name           |Datatype|Purpose                                             |
|---------------|--------|----------------------------------------------------|
|`axis`         |real    |[Gamepad axis](https://manual.yoyogames.com/#t=GameMaker_Language%2FGML_Reference%2FGame_Input%2FGamePad_Input%2FGamepad_Input.htm) to target|
|`min`          |real    |Minimum threshold value                             |
|`max`          |real    |Maximum threshold value                             |
|`[playerIndex]`|integer |Player to target. If not specified, player 0 is used|

#### **Example**

```gml
//Set the threshold of the horizontal component of the left stick based on a sensitivity mode
switch(sensitivity_mode)
{
	case 0: input_axis_threshold_set(gp_axislh, 0.3, 1.0); break;
	case 1: input_axis_threshold_set(gp_axislh, 0.4, 0.9); break;
	case 2: input_axis_threshold_set(gp_axislh, 0.5, 0.8); break;
}
```

<!-- tabs:end -->

&nbsp;

## …axis_threshold_get

`input_axis_threshold_get(axis, [playerIndex])`

<!-- tabs:start -->

#### **Description**

**Returns:** A struct with two member variables, `.__mini` and `.__maxi`, containing the minimum and maximum thresholds

|Name           |Datatype|Purpose                                             |
|---------------|--------|----------------------------------------------------|
|`axis`         |real    |[Gamepad axis](https://manual.yoyogames.com/#t=GameMaker_Language%2FGML_Reference%2FGame_Input%2FGamePad_Input%2FGamepad_Input.htm) to target|
|`[playerIndex]`|integer |Player to target. If not specified, player 0 is used|

If the axis does not have a threshold definition (as set by `input_axis_threshold_set()`) when this function is called then a new definition is created using `INPUT_DEFAULT_MIN_THRESHOLD` and `INPUT_DEFAULT_MAX_THRESHOLD`.

#### **Example**

```gml
//Grab the axis thresholds
var _threshold = input_axis_threshold_get(gp_axislh);

//Draw a representation of the thresholds
//We use two different radii so the two circles never overlap
draw_circle(x, y, 110*_threshold.__mini, true);
draw_circle(x, y, 120*_threshold.__maxi, true);
```

<!-- tabs:end -->

&nbsp;

## …accessibility_global_toggle_set

`input_accessibility_global_toggle_set(state)`

<!-- tabs:start -->

#### **Description**

**Returns:** N/A (`undefined`)

|Name   |Datatype|Purpose                                                     |
|-------|--------|------------------------------------------------------------|
|`state`|boolean |Whether to allow momentary toggles across the project at all|

#### **Example**

```gml
//Toggle momentary state across the entire game
if (input_check_pressed("accept"))
{
	input_accessibility_global_toggle_set(not input_accessibility_global_toggle_get());
}
```

<!-- tabs:end -->

&nbsp;

## …accessibility_global_toggle_get

`input_accessibility_global_toggle_get()`

<!-- tabs:start -->

#### **Description**

**Returns:** Boolean, whether momentary toggle behaviour is allowed

|Name|Datatype|Purpose|
|----|--------|-------|
|None|        |       |

#### **Example**

```gml
//Determine what string to show based on the momentary toggle
var _string = "Momentary toggle is set to ";
if (input_accessibility_global_toggle_get())
{
	_string += "ON";
}
else
{
	_string += "OFF";
}

//Draw that to the screen
draw_text(x, y, _string);
```

<!-- tabs:end -->

&nbsp;

## …accessibility_verb_toggle_set

`input_accessibility_verb_toggle_set(verb, state)`

<!-- tabs:start -->

#### **Description**

**Returns:** N/A (`undefined`)

|Name   |Datatype|Purpose                                         |
|-------|--------|------------------------------------------------|
|`verb` |string  |Name of the [verb](Verbs-and-Bindings) to target|
|`state`|boolean |Whether to enable toggling for the verb         |

#### **Example**

```gml
//Set whether the "shoot" verb is set to toggle
if (input_check_pressed("accept"))
{
	input_accessibility_verb_toggle_set("shoot", true);
}
else if (input_check_pressed("cancel"))
{
	input_accessibility_verb_toggle_set("shoot", false);
}
```

<!-- tabs:end -->

&nbsp;

## …accessibility_verb_toggle_get

`input_accessibility_verb_toggle_get(verb)`

<!-- tabs:start -->

#### **Description**

**Returns:** Boolean, whether momentary toggle behaviour is enabled for the verb

|Name  |Datatype|Purpose                                         |
|------|--------|------------------------------------------------|
|`verb`|string  |Name of the [verb](Verbs-and-Bindings) to target|

#### **Example**

```gml
//Draw the state of the verb toggle for "shoot"
draw_text(x, y, "Shoot");
draw_sprite(spr_toggle_state, input_accessibility_verb_toggle_get("shoot"), x + 52, y);
```

<!-- tabs:end -->

&nbsp;

## …accessibility_global_cooldown_set

`input_accessibility_global_cooldown_set(state)`

<!-- tabs:start -->

#### **Description**

**Returns:** N/A (`undefined`)

|Name   |Datatype|Purpose                                                  |
|-------|--------|---------------------------------------------------------|
|`state`|boolean |Whether to allow verb cooldowns across the project at all|

#### **Example**

```gml
//Toggle input cooldown across the entire game
if (input_check_pressed("accept"))
{
	input_accessibility_global_cooldown_set(not input_accessibility_global_cooldown_get());
}
```

<!-- tabs:end -->

&nbsp;

## …accessibility_global_cooldown_get

`input_accessibility_global_cooldown_get()`

<!-- tabs:start -->

#### **Description**

**Returns:** Boolean, whether cooldown behaviour is allowed

|Name|Datatype|Purpose|
|----|--------|-------|
|None|        |       |

#### **Example**

```gml
//Determine what string to show based on the cooldown toggle
var _string = "Input cooldown is set to ";
if (input_accessibility_global_cooldown_get())
{
	_string += "ON";
}
else
{
	_string += "OFF";
}

//Draw that to the screen
draw_text(x, y, _string);
```

<!-- tabs:end -->

&nbsp;

## …accessibility_verb_cooldown_set

`input_accessibility_verb_cooldown_set(verb, state)`

<!-- tabs:start -->

#### **Description**

**Returns:** N/A (`undefined`)

|Name   |Datatype|Purpose                                         |
|-------|--------|------------------------------------------------|
|`verb` |string  |Name of the [verb](Verbs-and-Bindings) to target|
|`state`|boolean |Whether to enable cooldown for the verb         |

#### **Example**

```gml
//Toggle verb cooldown for the "talk" verb
if (input_check_pressed("accept"))
{
	input_accessibility_verb_cooldown_set("talk", not input_accessibility_verb_cooldown_get("talk"));
}
```

<!-- tabs:end -->

&nbsp;

## …accessibility_verb_cooldown_get

`input_accessibility_verb_cooldown_get(verb)`

<!-- tabs:start -->

#### **Description**

**Returns:** Boolean, whether cooldown behaviour is enabled for the verb

|Name  |Datatype|Purpose                                         |
|------|--------|------------------------------------------------|
|`verb`|string  |Name of the [verb](Verbs-and-Bindings) to target|

#### **Example**

```gml
//Draw the state of the verb toggle for "talk"
draw_text(x, y, "Talk");
draw_sprite(spr_cooldown_state, input_accessibility_verb_cooldown_get("talk"), x + 52, y);
```

<!-- tabs:end -->
