# Functions (Other)

&nbsp;

## …clear_momentary

`input_clear_momentary(state)`

<!-- tabs:start -->

#### **Description**

**Returns:** N/A (`undefined`)

|Name   |Datatype|Purpose                             |
|-------|--------|------------------------------------|
|`state`|boolean |Whether to clear all momentary input|

Clears momentary (pressed/released) input and connection checkers. This covers verbs as well as keyboard/mouse/gamepad direct checkers. Useful for [fixed timestep patterns](https://gafferongames.com/post/fix_your_timestep/) where momentary checks should only be handled for one cycle (for example [iota](https://github.com/JujuAdams/iota)).

#### **Example**

```gml
//Handle game logic for 0-n frames per time step 
for(var _i = 0; _i < timeStepIterations; _i++)
{
    //Game logic including input checks
    tickGame();

    //Clear momentary input (pressed, released, etc.) after first tick
    if (_i == 0)
    {
        input_clear_momentary(true);
    }
}
```

<!-- tabs:end -->

&nbsp;


## …ignore_key_add

`input_ignore_key_add(key)`

<!-- tabs:start -->

#### **Description**

**Returns:** N/A (`undefined`)

|Name |Datatype|Purpose                                                                                                                 |
|-----|--------|------------------------------------------------------------------------------------------------------------------------|
|`key`|integer |[Key](https://manual.yoyogames.com/#t=GameMaker_Language%252FGML_Reference%252FGame_Input%252FKeyboard_Input%252FKeyboard_Input.htm) to add|

Adds a keyboard key to be ignored by Input. This will affect binding detection, but any existing bindings set up to scan for this key will still work to prevent players from getting themselves into a position where the game doesn't work (!).

?> The list of ignored keys may already be populated depending on what value is set for `INPUT_IGNORE_RESERVED_KEYS_LEVEL`. Please read the [config macros](Config-Macros) page for more information.

#### **Example**

```gml
////On boot...

//Ignore 'Ctrl' keys for rebinding
input_ignore_key_add(vk_lcontrol);
input_ignore_key_add(vk_rcontrol);
input_ignore_key_add(vk_control);
```

<!-- tabs:end -->

&nbsp;

## …ignore_key_remove

`input_ignore_key_remove(key)`

<!-- tabs:start -->

#### **Description**

**Returns:** N/A (`undefined`)

|Name |Datatype|Purpose                                                                                                                                       |
|-----|--------|----------------------------------------------------------------------------------------------------------------------------------------------|
|`key`|integer |[Key](https://manual.yoyogames.com/#t=GameMaker_Language%252FGML_Reference%252FGame_Input%252FKeyboard_Input%252FKeyboard_Input.htm) to remove|

Removes a keyboard key from the ignore list.

#### **Example**

```gml
////On boot...

//Don't ignore 'Cmd' keys for rebinding on MacOS
if (os_type == os_macosx)
{
	input_ignore_key_remove(vk_lmeta);
	input_ignore_key_remove(vk_rmeta);
}
```

<!-- tabs:end -->

&nbsp;

## …debug_player_input

`input_debug_player_input([playerIndex])`

<!-- tabs:start -->

#### **Description**

**Returns:** Array of bindings

|Name         |Datatype|Purpose                                             |
|-------------|--------|----------------------------------------------------|
|`playerIndex`|integer |Player to target. If not specified, player 0 is used|

Returns an array that contains bindings for each keyboard key, mouse button, and gamepad button/axis that the player is pressing. This function uses the same ignore/allow/source filter behaviour as the binding scan feature (see `input_binding_scan_params_set()`).

!> This function is provided for debug use only and does very little error checking. Use `input_binding_scan_start()` for player-facing binding scan.

#### **Example**

```gml
//Draw input debug for players
for(var _i = 0; _i < INPUT_MAX_PLAYERS; _i++)
{
	//When an F-key matches player index
	if (input_keyboard_check(vk_f1 + _i))
	{
		//...show pressed bindings for that player
		draw_text(10, 10 + 20*_i, string(input_debug_player_input(_i)));
	}
}
```

<!-- tabs:end -->

&nbsp;

## …debug_all_input

`input_debug_all_input()`

<!-- tabs:start -->

#### **Description**

**Returns:** Array of bindings

|Name            |Datatype|Purpose                                                                                                                                                    |
|----------------|--------|-----------------------------------------------------------------------------------------------------------------------------------------------------------|
|`[ignoreArray]` |array   |Array of keyboard keys (`vk_*`, `"A"`), mouse buttons (`mb_*`), or gamepad constants (`gp_*`) to explicitly disallow being scanned                         |
|`[allowArray]`  |array   |Array of keyboard keys (`vk_*`, `"A"`), mouse buttons (`mb_*`), or gamepad constants (`gp_*`) to explicitly scan for, excluding all other possible bindings|
|`[sourceFilter]`|array   |Array of sources to scan. If not specified, all possible sources will be scanned                                                                           |

Returns an array that contains bindings for each keyboard key, mouse button, and gamepad button/axis that are being pressed on any scanned input device.

!> This function is provided for debug use only and does very little error checking. Use `input_binding_scan_start()` for player-facing binding scan.

#### **Example**

```gml
//Track change in input count
static _input_count_previous = 0;
    
//Get all input
var _debug_input = input_debug_all_input();

//Print if input count is changed
var _len = array_length(_debug_input);
if ((_len > 0) && (_len != _input_count_previous))
{
	show_debug_message(_debug_input);
}

//Update count
_input_count_previous = _len;
```

<!-- tabs:end -->

&nbsp;

## …window_has_focus

`input_window_has_focus()`

<!-- tabs:start -->

#### **Description**

**Returns:** Boolean, whether the game window is in focus

|Name|Datatype|Purpose|
|----|--------|-------|
|None|        |       |

!> This function is intended for desktop (Windows, MacOS, Linux) platforms.

#### **Example**

```gml
//Hide aim pointer and pause if focus is lost
if (!input_window_has_focus() && !game_paused)
{
	game_paused = true;
	obj_reticle.visible = false;
}
```

<!-- tabs:end -->


&nbsp;

## …led_pattern_get

`input_led_pattern_get(gamepadIndex)`

<!-- tabs:start -->

#### **Description**

**Returns:** Struct, the gamepad LED pattern state. See below

|Name|Datatype|Purpose|
|----|--------|-------|
|`gamepadIndex`|integer |Index of the gamepad to target, using GameMaker's native [gamepad indexes](https://manual.yoyogames.com/#t=GameMaker_Language%2FGML_Reference%2FGame_Input%2FGamePad_Input%2FGamepad_Input.htm)|

The struct returned by the function contains the following member variables:

|Name        |Datatype|Purpose                                |
|------------|--------|---------------------------------------|
|`.value`    |number  |Number represented by the LED pattern  |
|`.pattern`  |array   |An array of variable size with boolean values representing LED state, `<false>` for off, `<true>` for on|
|`.layout`   |string  |The directional layout of the LED array. `"vertical"`, `"horizontal"`, `"radial"`, or `"unknown"`|

!> This function works on Switch and PS5 platforms, as well as Windows through Steam, and on iOS and tvOS for select gamepads 

#### **Example**

```gml
///Draw controller LED pattern for one player
var _gamepad = input_player_get_gamepad();
if (input_gamepad_is_connected(_gamepad))
{
	//Draw gamepad description
	draw_text(200, 10, input_gamepad_get_description(_gamepad));

	//Get struct containing LED pattern state
	var _led_pattern = input_led_pattern_get(_gamepad);
	
	var _led_x = 200;
	var _led_y = 20;
	if (_led_pattern.pattern == "radial")
	{
		//Draw radial sprite using value for subimage
		draw_sprite(spr_radial_led, _led_pattern.value - 1, _led_x, _led_y);
	}
	else if (_led_pattern.pattern != "unknown"))
	{
		//Iterate through individual LED states
		for(var _led = 0; _led < array_length(_led_pattern.pattern); _led++)
		{
			//Draw state per LED
			draw_sprite(spr_led_light, _led_pattern.pattern[_led], _led_x, _led_y);

			//Offset position of next LED
			_led_x += ((_led_pattern.pattern == "horizontal")? 12 : 0);
			_led_y += ((_led_pattern.pattern == "vertical")? 12 : 0);
		}
	}
}
```

<!-- tabs:end -->


&nbsp;

## …_keyboard_virtual_show

`input_keyboard_virtual_show([virtualKeyboardType])`

<!-- tabs:start -->

#### **Description**

**Returns:** N/A (`undefined`)

|Name|Datatype|Purpose|
|----|--------|-------|
|`[virtualKeyboardType]`|[Virtual Keyboard Type Constant](https://manual.yoyogames.com/GameMaker_Language/GML_Reference/Game_Input/Virtual_Keys_And_Keyboards/keyboard_virtual_show.htm)|Virtual keyboard type to display|

Shows the onscreen virtual keyboard on mobile platforms and SteamOS with the [Steamworks extension](Steamworks.md)

?> For further configuration of the onscreen keyboard see [Touch macros](Config-Macros.md#touch)

!> On web and console platforms, the [Async functions](https://manual.yoyogames.com/GameMaker_Language/GML_Reference/Asynchronous_Functions/Dialog/get_string_async.htm) should be used instead. See [`INPUT_KEYBOARD_TYPE`](Library-Constants.md#input_keyboard_type)

#### **Example**

```gml
///Prompt user to enter a numeric value
var _default_value = 1234;
var _caption = "Enter passcode";

if (INPUT_KEYBOARD_TYPE == "virtual")
{
	//Set keyboard string to default value
	keyboard_string = string(_default_value);

	//Show an onscreen keyboard
	input_keyboard_virtual_show(kbv_type_numbers);
	
	//Prompt user for number entry
	set_hud_string(_caption);
}
else if (INPUT_KEYBOARD_TYPE == "async")
{
	//Show a numeric entry dialogue
	async_id = get_integer_async(_caption, _default_value);
}
```

<!-- tabs:end -->

&nbsp;

## …_keyboard_virtual_hide

`input_keyboard_virtual_hide()`

<!-- tabs:start -->

#### **Description**

**Returns:** N/A (`undefined`)

Hides the onscreen virtual keyboard on mobile platforms and SteamOS with the [Steamworks extension](Steamworks.md)

#### **Example**

```gml
//Abort login if the network connection drops
if (os_is_network_connected(false))
{
	input_keyboard_virtual_hide();
	
	set_hud_string("Network disconnected");
}
```

<!-- tabs:end -->

&nbsp;

## …_input_gamepad_tester_set

`input_gamepad_tester_set(state)`

<!-- tabs:start -->

#### **Description**

**Returns:** N/A (`undefined`)

Creates a gamepad tester GUI using GameMaker's native debug overlay feature. You can use this tool to debug gamepads that you have connected.

?> Whilst the debug overlay is open in general, Input will not pass through any inputs to your game.

#### **Example**

```gml
if (keyboard_check(vk_control)
&&  keyboard_check(vk_shift)
&&  keyboard_check_pressed("G")) //ctrl + shift + G
{
	//Toggle the gamepad tester
	input_gamepad_tester_set(not input_gamepad_tester_get());
}
```

<!-- tabs:end -->

&nbsp;

## …_input_gamepad_tester_get

`input_gamepad_tester_get()`

<!-- tabs:start -->

#### **Description**

**Returns:** Boolean, whether the gamepad tester debug overlay view has been created

#### **Example**

```gml
/// Draw GUI End event

if (input_gamepad_tester_get())
{
	draw_set_color(c_black)
	draw_set_alpha(0.6)

	//Draw a shader over gameplay whilst the gamepad tester is open to aid legibility
	draw_rectangle(0, 0, display_get_gui_width(), display_get_gui_height());

	draw_set_color(c_white)
	draw_set_alpha(1)
}
```

<!-- tabs:end -->
