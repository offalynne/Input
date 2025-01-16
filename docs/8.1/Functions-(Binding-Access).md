# Functions (Binding Access)

&nbsp;

## …binding_is_valid

`input_binding_is_valid(binding, [playerIndex])`

<!-- tabs:start -->

#### **Description**

_Returns:_ Boolean, if the value is a valid binding for the specified player on the current platform

|Name           |Datatype|Purpose                                                           |
|---------------|--------|------------------------------------------------------------------|
|`binding`      |binding |Binding to check against                                          |
|`[playerIndex]`|integer |Player to validate against. If not specified, player 0 is targeted|

Useful for verifying if a binding returned by [`input_binding_get()`](Functions-(Binding-Access)?id=binding_get) is valid for the specified player on the current platform.

#### **Example**

```gml
//Get the binding for the "jump" verb
var _binding = input_binding_get("jump");

if (input_binding_is_valid(_binding))
{
	//If the binding is valid, use its name
	var _string = input_binding_get_name(_binding);
}
else
{
	//Otherwise display some error text
	var _string = "Unsupported for gamepad";
}

//Draw the result to the screen
draw_text(x, y, "Jump: " + _string);
```

<!-- tabs:end -->

&nbsp;

## …binding_set

`input_binding_set(verb, binding, [playerIndex], [alternate], [profileName])`

<!-- tabs:start -->

#### **Description**

_Returns:_ N/A (`undefined`)

|Name           |Datatype                            |Purpose                                                                                                                                                                                                                                                 |
|---------------|------------------------------------|--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
|`verb`         |[verb](Verbs-and-Bindings)|[Verb](Verbs-and-Bindings) to target                                                                                                                                                                                                          |
|`binding`      |binding                             |Binding to set|
|`[playerIndex]`|integer                             |Player to target. If not specified, player 0 is used                                                                                                                                                                                                    |
|`[alternate]`  |integer                             |[Alternate binding](Verbs-and-Bindings) to target. If not specified, `0` is used                                                                                                                                                              |
|`[profileName]`|string                              |The [profile](Profiles) to set the verb binding for. If no profile is provided then the current profile is used                                                                                                                                         |

Straightforwardly sets the binding for a verb, overwriting what was already there.

#### **Example**

```gml
//Set up left-handed controls by overwriting all the verbs we have
input_binding_set("up",    input_binding_key("I"));
input_binding_set("down",  input_binding_key("K"));
input_binding_set("left",  input_binding_key("J"));
input_binding_set("right", input_binding_key("L"));
input_binding_set("jump",  input_binding_key(vk_space));
input_binding_set("pause", input_binding_key(vk_escape));
```

<!-- tabs:end -->

&nbsp;

## …binding_set_safe

`input_binding_set_safe(verb, binding, [playerIndex], [alternate], [profileName])`

<!-- tabs:start -->

#### **Description**

_Returns:_ N/A (`undefined`)

|Name           |Datatype                            |Purpose                                                                                                                                                                                                                                                 |
|---------------|------------------------------------|--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
|`verb`         |[verb](Verbs-and-Bindings)|[Verb](Verbs-and-Bindings) to target                                                                                                                                                                                                          |
|`binding`      |binding                             |Binding to set|
|`[playerIndex]`|integer                             |Player to target. If not specified, player 0 is used                                                                                                                                                                                                    |
|`[alternate]`  |integer                             |[Alternate binding](Verbs-and-Bindings) to target. If not specified, `0` is used                                                                                                                                                              |
|`[profileName]`|string                              |The [profile](Profiles) to set the verb binding for. If no profile is provided then the current profile is used                                                                                                                                                                |

In contrast to [`input_binding_set()`](Functions-(Binding-Access)?id=binding_set), this function will set the binding for a verb but also try to automatically handle any input conflicts by swapping over bindings. This is effective for simple control schemes but may fail in more complex situations - in these cases, you'll need to handle conflict resolution yourself.

#### **Example**

```gml
//Start a binding scan
input_binding_scan_start(function(_binding)
{
	//When we succeed, set our new binding
    input_binding_set_safe(oGamepadSettings.verbToRebind, _binding);
});
```

<!-- tabs:end -->

&nbsp;

## …binding_get

`input_binding_get(verb, [playerIndex], [alternate], [profileName])`

<!-- tabs:start -->

#### **Description**

_Returns:_ Struct. See below.

|Name           |Datatype                  |Purpose                                                                                                                                             |
|---------------|--------------------------|----------------------------------------------------------------------------------------------------------------------------------------------------|
|`verb`         |[verb](Verbs-and-Bindings)|[Verb](Verbs-and-Bindings) to target                                                                                                                |
|`[playerIndex]`|integer                   |Player to target. If not specified, player 0 is used. You may also use `"default"` as the player index to retrieve the default binding for this verb|
|`[alternate]`  |integer                   |[Alternate binding](Verbs-and-Bindings) to target. If not specified, `0` is used                                                                    |
|`[profileName]`|string                    |The [profile](Profiles) to get the verb binding from. If no profile is provided then the current profile is used                                    |

This function returns a struct that describes the binding for the given verb. It has the following member variables:

|Variable        |Datatype|Purpose                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                    |
|----------------|--------|---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
|`.__type`         |string  |Type of binding, one of the following:<br>`"key"` `"gamepad button"` `"gamepad axis"` `"mouse button"` `"mouse wheel up"` `"mouse wheel down"` (and `undefined`)                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                           |
|`.__value`        |integer |[Keycode](https://manual.yoyogames.com/#t=GameMaker_Language%252FGML_Reference%252FGame_Input%252FKeyboard_Input%252FKeyboard_Input.htm), [gamepad button](https://manual.yoyogames.com/#t=GameMaker_Language%2FGML_Reference%2FGame_Input%2FGamePad_Input%2FGamepad_Input.htm), [gamepad axis](https://manual.yoyogames.com/#t=GameMaker_Language%2FGML_Reference%2FGame_Input%2FGamePad_Input%2FGamepad_Input.htm), or [mouse button](https://manual.yoyogames.com/#t=GameMaker_Language%252FGML_Reference%252FGame_Input%252FMouse_Input%252FMouse_Input.htm) that this binding uses. This variable is `undefined` for `"mouse wheel up"` and `"mouse wheel down"` types|
|`.__axis_negative`|boolean |Whether this binding expects negative values (`"gamepad axis"` type only)                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                  |

#### **Example**

```gml
//Get the binding for the "special" verb
var _binding = input_binding_get("special");

//If this binding is a keyboard key, and it's a simple ASCII character...
if ((_binding.__type == "key") && (_binding.__value > 32) && (_binding.__value < 128))
{
	//...then draw some text on top of a keyboard key icon
	draw_sprite(spr_icon_small_key, 0, x, y);

	draw_set_halign(fa_center);
	draw_set_valign(fa_midde);
	draw_text(x, y, chr(_binding.__value));
	draw_set_halign(fa_left);
	draw_set_valign(fa_top);
}
else
{
	//Otherwise draw the icon that we've set up elsewhere
	draw_sprite(input_binding_get_icon(_binding), 0, x, y);
}
```

<!-- tabs:end -->

&nbsp;

## …binding_get_name

`input_binding_get_name(binding)`

<!-- tabs:start -->

#### **Description**

_Returns:_ String, the human-readable [name for the binding](Binding-Names)

|Name     |Datatype|Purpose                       |
|---------|--------|------------------------------|
|`binding`|binding |Binding to return the name for|

Returns the [name of the binding](Binding-Names) in a way that is (mostly!) human-readable. This string can be the name of a keyboard key or the name of a gamepad axis, including direction of travel. The intention is for this information to be parsed by your own code and then used to display a string or icon to the player indicating which button/key etc. is associated with which verb. All return values are listed as [Binding Names](Binding-Names).

For example, `input_binding_get_name(input_binding_get("jump"))` will return the name of the binding for the "jump" verb if it is defined, or "not a binding" otherwise.

?> In situations where you are displaying control prompt to a player, `input_binding_get_icon()` is likely to be more useful.

#### **Example**

```gml
//Get the binding for the "confirm" verb
var _binding = input_binding_get("confirm");

//Draw the name of the binding to the screen
draw_text(x, y, input_binding_get_name(_binding));
```

<!-- tabs:end -->

&nbsp;

## …binding_get_source_type

`input_binding_get_source_type(binding)`

<!-- tabs:start -->

#### **Description**

_Returns:_ Various, the source type for the binding (see below)

|Name     |Datatype|Purpose                       |
|---------|--------|------------------------------|
|`binding`|binding |Binding to return the type for|

Returns one of the following:
- `INPUT_KEYBOARD`
- `INPUT_MOUSE`
- `INPUT_TOUCH`
- `INPUT_GAMEPAD`

If the binding is invalid or the source type cannot be determined, `undefined` is returned. As with other functions, if `INPUT_ASSIGN_KEYBOARD_AND_MOUSE_TOGETHER` is set to `true` then `INPUT_KEYBOARD` and `INPUT_MOUSE` are interchangeable.

#### **Example**

```gml
//Get the binding for the "cancel" verb, and then get its source type
var _binding = input_binding_get("cancel");
var _source_type = input_binding_get_source_type(_binding);

//Determine what icon to use for the source type for this binding
switch(_source_type)
{
	case INPUT_KEYBOARD: _sprite = spr_icon_keyboard;      break;
	case INPUT_MOUSE:    _sprite = spr_icon_mouse;         break;
	case INPUT_TOUCH:    _sprite = spr_icon_touch;         break;
	case INPUT_GAMEPAD:  _sprite = spr_icon_gamepad;       break;
	default:             _sprite = spr_icon_question_mark; break;
}

//Draw the source type icon for the binding
draw_sprite(_sprite, 0, x, y);
```

<!-- tabs:end -->

&nbsp;

## …binding_test_collisions

`input_binding_test_collisions(verb, binding, [playerIndex], [profileName])`

<!-- tabs:start -->

#### **Description**

_Returns:_ Array of structs containing conflicting verb/alternate indexes

|Name           |Datatype                  |Purpose                                                                                                                                                                                                                                                           |
|---------------|--------------------------|------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
|`verb`         |[verb](Verbs-and-Bindings)|[Verb](Verbs-and-Bindings) to target                                                                                                                                                                                                                    |
|`binding`      |binding                   |Binding to check against|
|`[playerIndex]`|integer                   |Player to target. If not specified, player 0 is used                                                                                                                                                                                                              |
|`[profileName]`|string                    |The [profile](Profiles) to get the binding from. If no profile is provided then the current profile is used                                                                                                                                                                                         |

The array that this function returns contains structs that define which verb bindings conflict with the given binding. If the array is empty then there are no conflicting bindings.

The structs returned in the array contain the following:

|Variable    |Datatype                  |Purpose                     |
|------------|--------------------------|----------------------------|
|`.__verb`     |[verb](Verbs-and-Bindings)|Verb binding that conflicts |
|`.__alternate`|integer                   |Alternate index for the verb|

#### **Example**

```gml
//Start a binding scan
input_binding_scan_start(function(_binding)
{
	//Figure out if this new binding collides with anything
	var _collisionsArray = input_binding_test_collisions(oGamepadSettings.verbToRebind);

	//If we have no collisions, set the verb
	if (array_length(_collisionsArray) <= 0)
	{
	    input_binding_set(oGamepadSettings.verbToRebind, _binding);
	}
});
```

<!-- tabs:end -->

&nbsp;

## …binding_remove

`input_binding_remove(verb, [playerIndex], [alternate], [profileName])`

<!-- tabs:start -->

#### **Description**

_Returns:_ N/A (`undefined`)

|Name           |Datatype                            |Purpose                                                                                   |
|---------------|------------------------------------|------------------------------------------------------------------------------------------|
|`verb`         |[verb](Verbs-and-Bindings)|[Verb](Verbs-and-Bindings) to target                                            |
|`[playerIndex]`|integer                             |Player to target. If not specified, player 0 is used                                      |
|`[alternate]`  |integer                             |[Alternate binding](Verbs-and-Bindings) to target. If not specified, `0` is used|
|`[profileName]`|string                              |The [profile](Profiles) to remove the binding from. If no profile is provided then the current profile is used|

Removes a binding from Input. **Be very careful with this function!** It's possible to remove any binding and this could potentially make your game unplayable.

#### **Example**

```gml
//Start a binding scan
input_binding_scan_start(function(_binding)
{
	//If the incoming binding is the same as the existing binding...
	if (input_binding_get_name(_binding) == input_binding_get_name(oGamepadSettings.verbToRebind))
	{
		//...then remove the binding we already have
		input_binding_remove(oGamepadSettings.verbToRebind);
	}
	else
	{
		//Otherwise set the binding as normal
		input_binding_set_safe(oGamepadSettings.verbToRebind, _binding);
	}
});
```

<!-- tabs:end -->

&nbsp;

## …binding_swap

`input_binding_swap(verbA, alternateA, verbB, alternateB, [source], [playerIndex], [profileName])`

<!-- tabs:start -->

#### **Description**

_Returns:_ N/A (`undefined`)

|Name           |Datatype                            |Purpose                                                                        |
|---------------|------------------------------------|-------------------------------------------------------------------------------|
|`verbA`        |[verb](Verbs-and-Bindings)|First [verb](Verbs-and-Bindings) to target                           |
|`alternateA`   |integer                             |[Alternate binding](Verbs-and-Bindings) to target for the first verb |
|`verbB`        |[verb](Verbs-and-Bindings)|Second [verb](Verbs-and-Bindings) to target                          |
|`alternateB`   |integer                             |[Alternate binding](Verbs-and-Bindings) to target for the second verb|
|`[playerIndex]`|integer                             |Player to target. If not specified, player 0 is used                           |
|`[profileName]`|string                              |The [profile](Profiles) to target. If no profile is provided then the current profile is used                                                                               |

Swaps over the two verb bindings specified.

#### **Example**

```gml
//Flip the roll verbs
input_binding_swap("roll left", 0, "roll right", 0);
```

<!-- tabs:end -->

&nbsp;

## …binding_gamepad_set

`input_binding_gamepad_set(binding. gamepad)`

<!-- tabs:start -->

#### **Description**

_Returns:_ N/A (`undefined`)

|Name     |Datatype                     |Purpose                                          |
|---------|-----------------------------|-------------------------------------------------|
|`binding`|[binding](Verbs-and-Bindings)|[Binding](Verbs-and-Bindings) to target|
|`gamepad`|integer                      |Gamepad index to set for the given binding|

?> The gamepad index for a binding is only relevant when in the [multidevice source mode](Input-Sources?id=source-modes) and will be disregarded by Input when checking for gamepad input in other source modes.

#### **Example**

```gml
var _binding = input_binding_get(verbToChange);

//Scroll through gamepads using the "left" and "right" verbs
var _delta = input_check_opposing_pressed("left", "right");
if (_delta != 0)
{
	//Figure out which gamepad to assign
	var _gamepad = clamp(input_binding_gamepad_get(_binding) + _delta, 0, 12);

	//Set the new gamepad for the binding
	input_binding_gamepad_set(_binding, _gamepad);
}
```

<!-- tabs:end -->

&nbsp;

## …binding_gamepad_get

`input_binding_gamepad_get(binding)`

<!-- tabs:start -->

#### **Description**

_Returns:_ Integer, the gamepad index for the binding

|Name     |Datatype                     |Purpose                                          |
|---------|-----------------------------|-------------------------------------------------|
|`binding`|[binding](Verbs-and-Bindings)|[Binding](Verbs-and-Bindings) to target|

If no gamepad has been set, this function returns `undefined`.

?> The gamepad index for a binding is only relevant when in the [multidevice source mode](Input-Sources?id=source-modes) and will be disregarded by Input when checking for gamepad input in other source modes.

#### **Example**

```gml
//Get the gamepad for the binding
var _binding = input_binding_get("pause");
var _gamepad = input_binding_gamepad_get(_binding);

//Determine which gamepad icon to use for this binding
switch(input_gamepad_get_type)
{
	case INPUT_GAMEPAD_TYPE_XBOX_ONE:
	case INPUT_GAMEPAD_TYPE_XBOX_360:
		var _sprite = spr_icon_gamepad_xbox;
	break;

	case INPUT_GAMEPAD_TYPE_PS5:
	case INPUT_GAMEPAD_TYPE_PS4:
	case INPUT_GAMEPAD_TYPE_PSX:
		var _sprite = spr_icon_gamepad_playstation;
	break;

	case INPUT_GAMEPAD_TYPE_SWITCH:
		var _sprite = spr_icon_gamepad_switch;
	break;

	case INPUT_GAMEPAD_TYPE_JOYCON_LEFT:
		var _sprite = spr_icon_gamepad_joycon_left;
	break;

	case INPUT_GAMEPAD_TYPE_JOYCON_RIGHT:
		var _sprite = spr_icon_gamepad_joycon_right;
	break;

	case INPUT_GAMEPAD_TYPE_GAMECUBE:
		var _sprite = spr_icon_gamepad_gamecube;
	break;

	default:
		var _sprite = spr_icon_gamepad_unknown;
	break;
}

//Draw the icon for the binding
draw_sprite(_sprite, 0, x, y);
```

<!-- tabs:end -->

&nbsp;

## …binding_threshold_set

`input_binding_threshold_set(binding, min, max)`

<!-- tabs:start -->

#### **Description**

_Returns:_ N/A (`undefined`)

|Name     |Datatype                     |Purpose                                          |
|---------|-----------------------------|-------------------------------------------------|
|`binding`|[binding](Verbs-and-Bindings)|[Binding](Verbs-and-Bindings) to target|
|`min`    |number                       |Minimum threshold for this binding               |
|`max`    |number                       |Maximum threshold for this binding               |

Sets the minimum and maximum threshold values for this binding. This is only relevant when applied to a [gamepad axis binding](Functions-(Binding-Creators)?id=binding_gamepad_axis).

This function is entirely optional. If a gamepad axis binding has no specific thresholds set then the player's axis thresholds are used, as set by [`input_axis_thresholds_set()`](Functions-(Accessibility)?id=axis_threshold_set).

#### **Example**

```gml
//Apply minimum and maximum threshold to all movement verbs
input_binding_threshold_set(input_binding_get("left" ), minThreshold, maxThreshold);
input_binding_threshold_set(input_binding_get("right"), minThreshold, maxThreshold);
input_binding_threshold_set(input_binding_get("up"   ), minThreshold, maxThreshold);
input_binding_threshold_set(input_binding_get("down" ), minThreshold, maxThreshold);
```

<!-- tabs:end -->

&nbsp;

## …binding_threshold_get

`input_binding_threshold_get(binding)`

<!-- tabs:start -->

#### **Description**

_Returns:_ A struct with two member variables, `.__mini` and `.__maxi`, containing the minimum and maximum thresholds

|Name     |Datatype                     |Purpose                                          |
|---------|-----------------------------|-------------------------------------------------|
|`binding`|[binding](Verbs-and-Bindings)|[Binding](Verbs-and-Bindings) to target|

#### **Example**

```gml
//Obtain the threshold values for the "left" verb (which is indicative of all movement verbs)
var _binding = input_binding_get("left");
var _struct = input_binding_threshold_get(_binding);

//Then draw them to the screen
draw_text(x, y,    "Min: " + string(_struct.__mini));
draw_text(x, y+20, "Max: " + string(_struct.__maxi));
```

<!-- tabs:end -->

&nbsp;

## …binding_get_verbs

`input_binding_get_verbs(binding, [playerIndex], [profileName])`

<!-- tabs:start -->

#### **Description**

_Returns:_ Array of structs containing verb/alternate indexes

|Name           |Datatype|Purpose                                                                                                                                                                                                                                                           |
|---------------|--------|------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
|`binding`      |binding |Binding to check against|
|`[playerIndex]`|integer |Player to target. If not specified, player 0 is used                                                                                                                                                                                                              |
|`[profileName]`|string  |The [profile](Profiles) to target. If no profile is provided then the current profile is used                                                                                                                                                                                                                                                                  |

The array that this function returns contains structs that define which verbs match the given binding. If the array is empty then there are no matching verbs.

The structs returned in the array contain the following:

|Variable    |Datatype                  |Purpose                     |
|------------|--------------------------|----------------------------|
|`.__verb`     |[verb](Verbs-and-Bindings)|Verb binding that conflicts |
|`.__alternate`|integer                   |Alternate index for the verb|

#### **Example**

```gml
//Find out if any verbs are using the left mouse button
var _verbArray = input_binding_get_verbs(input_binding_mouse_button(mb_left));

if (array_length(_verbArray) > 0)
{
	//If so, draw a cursor at the mouse position
	draw_sprite(spr_mouse, 0, input_mouse_x(), input_mouse_y());
}
```

<!-- tabs:end -->
