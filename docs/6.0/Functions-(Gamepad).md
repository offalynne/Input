# Functions (Gamepad)

&nbsp;

?> These functions are provided for convenience if you want to implement your own features using Input's implementation of the SDL gamepad mapping system. In general, [verbs](Verbs-and-Bindings) are the intended way to use Input and are preferred.

&nbsp;

## …gamepad_check

`input_gamepad_check(gamepadIndex, GMconstant)`

<!-- tabs:start -->

#### **Description**

**Returns:** Boolean, if the button/axis is currently activated

|Name          |Datatype|Purpose                                               |
|--------------|--------|------------------------------------------------------|
|`gamepadIndex`|integer |Index of the gamepad to target, using GameMaker's native [gamepad indexes](https://manual.yoyogames.com/#t=GameMaker_Language%2FGML_Reference%2FGame_Input%2FGamePad_Input%2FGamepad_Input.htm)|
|`GMconstant`  |integer |Button or axis to check, using GameMaker's native [virtual button/axis constants](https://manual.yoyogames.com/#t=GameMaker_Language%2FGML_Reference%2FGame_Input%2FGamePad_Input%2FGamepad_Input.htm). What physical input this actually checks is determined by Input's own SDL remapping system|

#### **Example**

```gml
//Simple actions using gamepad buttons
//This works very similar to how it could work without Input
var _gas   = input_gamepad_check(0, gp_face1);
var _brake = input_gamepad_check(0, gp_face2);

//Set
speed = clamp(speed + (_gas - _brake)/20, 0, 8);
```

<!-- tabs:end -->

&nbsp;

## …gamepad_check_pressed

`input_gamepad_check_pressed(gamepadIndex, GMconstant)`

<!-- tabs:start -->

#### **Description**

**Returns:** Boolean, if the button/axis is newly activated this frame

|Name          |Datatype                  |Purpose                                               |
|--------------|--------------------------|------------------------------------------------------|
|`gamepadIndex`|integer                   |Index of the gamepad to target, using GameMaker's native [gamepad indexes](https://manual.yoyogames.com/#t=GameMaker_Language%2FGML_Reference%2FGame_Input%2FGamePad_Input%2FGamepad_Input.htm)|
|`GMconstant`  |integer |Button or axis to check, using GameMaker's native [virtual button/axis constants](https://manual.yoyogames.com/#t=GameMaker_Language%2FGML_Reference%2FGame_Input%2FGamePad_Input%2FGamepad_Input.htm). What physical input this actually checks is determined by Input's own SDL remapping system|

#### **Example**

```gml
//Simple actions using gamepad buttons
//This works very similar to how it could work without Input
var _shoot = input_gamepad_check_pressed(0, gp_face1);
var _load  = input_gamepad_check_pressed(0, gp_face2);

//Handle firing and reloading
if (ammo > 0)
{
    if (_shoot)
    {
        with(instance_create_depth(x, y, depth, objBullet))
        {
            direction = other.direction;
            speed     = other.speed + 10;
        }

        ammo -= 1;
    }
}
else if (_load)
{
    ammo += 10;
}
```

<!-- tabs:end -->

&nbsp;

## …gamepad_check_released

`input_gamepad_check_released(gamepadIndex, GMconstant)`

<!-- tabs:start -->

#### **Description**

**Returns:** Boolean, if the button/axis is newly deactivated this frame

|Name          |Datatype                  |Purpose                                               |
|--------------|--------------------------|------------------------------------------------------|
|`gamepadIndex`|integer                   |Index of the gamepad to target, using GameMaker's native [gamepad indexes](https://manual.yoyogames.com/#t=GameMaker_Language%2FGML_Reference%2FGame_Input%2FGamePad_Input%2FGamepad_Input.htm)|
|`GMconstant`  |integer |Button or axis to check, using GameMaker's native [virtual button/axis constants](https://manual.yoyogames.com/#t=GameMaker_Language%2FGML_Reference%2FGame_Input%2FGamePad_Input%2FGamepad_Input.htm). What physical input this actually checks is determined by Input's own SDL remapping system|

#### **Example**

```gml
//Loose arrow when button is released
if (input_gamepad_check_released(0, gp_face4))
{
    instance_create_depth(x, y, depth, objArrow);
}
```

<!-- tabs:end -->

&nbsp;

## …gamepad_value

`input_gamepad_value(gamepadIndex, GMconstant)`

<!-- tabs:start -->

#### **Description**

**Returns:** Real, the analogue value of the input (after applying SDL axis remapping)

|Name          |Datatype|Purpose                                               |
|--------------|--------|------------------------------------------------------|
|`gamepadIndex`|integer |Index of the gamepad to target, using GameMaker's native [gamepad indexes](https://manual.yoyogames.com/#t=GameMaker_Language%2FGML_Reference%2FGame_Input%2FGamePad_Input%2FGamepad_Input.htm)|
|`GMconstant`  |integer |Button or axis to check, using GameMaker's native [virtual button/axis constants](https://manual.yoyogames.com/#t=GameMaker_Language%2FGML_Reference%2FGame_Input%2FGamePad_Input%2FGamepad_Input.htm). What physical input this actually checks is determined by Input's own SDL remapping system|

#### **Example**

```gml
//Simple actions using gamepad triggers
//This works very similar to how it could work without Input
var _gas   = input_gamepad_value(0, gp_shoulderrb);
var _brake = input_gamepad_value(0, gp_shoulderlb);

//Set vehicle speed supporting analogue
speed = clamp(speed + _gas/20 - _brake/20, 0, 8);
```

<!-- tabs:end -->

&nbsp;

## …gamepad_delta

`input_gamepad_delta(gamepadIndex, GMconstant)`

<!-- tabs:start -->

#### **Description**

**Returns:** Real, difference in value between this frame and the previous frame for the given button/axis

|Name          |Datatype|Purpose                                               |
|--------------|--------|------------------------------------------------------|
|`gamepadIndex`|integer |Index of the gamepad to target, using GameMaker's native [gamepad indexes](https://manual.yoyogames.com/#t=GameMaker_Language%2FGML_Reference%2FGame_Input%2FGamePad_Input%2FGamepad_Input.htm)|
|`GMconstant`  |integer |Button or axis to check, using GameMaker's native [virtual button/axis constants](https://manual.yoyogames.com/#t=GameMaker_Language%2FGML_Reference%2FGame_Input%2FGamePad_Input%2FGamepad_Input.htm). What physical input this actually checks is determined by Input's own SDL remapping system|

#### **Example**

```gml
//Simple movement with left joystick
x += input_gamepad_delta(0, gp_axislh) * 8;
y += input_gamepad_delta(0, gp_axislv) * 8; 
```

<!-- tabs:end -->

&nbsp;

## …gamepad_is_axis

`input_gamepad_is_axis(gamepadIndex, GMconstant)`

<!-- tabs:start -->

#### **Description**

**Returns:** Boolean, if the given `gp_*` constant is mapped as an analogue input

|Name          |Datatype|Purpose                                               |
|--------------|--------|-------------------------------------------------------|
|`gamepadIndex`|integer |Index of the gamepad to target, using GameMaker's native [gamepad indexes](https://manual.yoyogames.com/#t=GameMaker_Language%2FGML_Reference%2FGame_Input%2FGamePad_Input%2FGamepad_Input.htm)|
|`GMconstant`  |integer |Button or axis to check, using GameMaker's native [virtual button/axis constants](https://manual.yoyogames.com/#t=GameMaker_Language%2FGML_Reference%2FGame_Input%2FGamePad_Input%2FGamepad_Input.htm)|

#### **Example**

```gml
//Zoom if right trigger is analogue
if (input_gamepad_is_axis(0, gp_shoulderrb))
{
    zoomScale = input_gamepad_value(0, gp_shoulderrb); 
}
```

<!-- tabs:end -->

&nbsp;

## …gamepad_is_connected

`input_gamepad_is_connected(gamepadIndex)`

<!-- tabs:start -->

#### **Description**

**Returns:** Boolean, whether the given gamepad is connected (omitting [blocked devices](Controller-Mapping?id=controller-blacklist))

|Name          |Datatype|Purpose                                               |
|--------------|--------|-------------------------------------------------------|
|`gamepadIndex`|integer |Index of the gamepad to target, using GameMaker's native [gamepad indexes](https://manual.yoyogames.com/#t=GameMaker_Language%2FGML_Reference%2FGame_Input%2FGamePad_Input%2FGamepad_Input.htm)|

#### **Example**

```gml
//Prompt player for controller if one is missing in the expected slot
if not (input_gamepad_is_connected(0))
{
    instance_create_layer(10, 10, guiLayer, obWarning, {
        message: "No gamepad connected in first slot!",
    });
}
```

<!-- tabs:end -->

## …gamepad_is_any_connected

`input_gamepad_is_any_connected(gamepadIndex)`

<!-- tabs:start -->

#### **Description**

**Returns:** Boolean, whether any gamepad is connected (omitting [blocked devices](Controller-Mapping?id=controller-blacklist))

|Name|Datatype|Purpose|
|----|--------|-------|
|None|        |       |

#### **Example**

```gml
//Draw a little gamepad notification sign if any gamepads are hooked up
if (input_gamepad_is_any_connected())
{
    draw_set_halign(fa_center);
    draw_set_valign(fa_middle);
    
    var _wiggle = 5*dsin(current_time/20);
    draw_text_transformed(room_width/2, 20, "Gamepads supported!", 1, 1, _wiggle);
    
    draw_set_halign(fa_left);
    draw_set_valign(fa_top);
}
```

<!-- tabs:end -->

&nbsp;

## …gamepad_get_description

`input_gamepad_get_description(gamepadIndex)`

<!-- tabs:start -->

#### **Description**

**Returns:** String, the name of the gamepad (after SDL remapping)

|Name          |Datatype|Purpose                                               |
|--------------|--------|------------------------------------------------------|
|`gamepadIndex`|integer |Index of the gamepad to target, using GameMaker's native [gamepad indexes](https://manual.yoyogames.com/#t=GameMaker_Language%2FGML_Reference%2FGame_Input%2FGamePad_Input%2FGamepad_Input.htm)|

#### **Example**

```gml
//Display the name of the gamepad used by the first player
if (input_gamepad_is_connected(input_player_get_gamepad()))
{
    draw_text(10, 10, "Using gamepad: " + input_gamepad_get_description(input_player_get_gamepad()));
}
```

<!-- tabs:end -->

&nbsp;

## …gamepad_get_type

`input_gamepad_get_type(gamepadIndex)`

<!-- tabs:start -->

#### **Description**

**Returns:** String, the gamepad type (after SDL remapping)

|Name          |Datatype                  |Purpose                                               |
|--------------|--------------------------|------------------------------------------------------|
|`gamepadIndex`|integer                   |Index of the gamepad to target, using GameMaker's native [gamepad indexes](https://manual.yoyogames.com/#t=GameMaker_Language%2FGML_Reference%2FGame_Input%2FGamePad_Input%2FGamepad_Input.htm)|

Returns a [gamepad type constant](Library-Constants#gamepad-types).

#### **Example**

```gml
//Display the type of the gamepad used by the first player
if (input_gamepad_is_connected(input_player_get_gamepad()))
{
    draw_text(10, 10, "Using gamepad type: " + input_gamepad_get_type(input_player_get_gamepad()));
}
```

<!-- tabs:end -->

&nbsp;

## …gamepad_get_map

`input_gamepad_get_map(gamepadIndex)`

<!-- tabs:start -->

#### **Description**

**Returns:** Array of integers, the buttons and axes that are mapped for the given gamepad

|Name          |Datatype|Purpose                                               |
|--------------|--------|------------------------------------------------------|
|`gamepadIndex`|integer |Index of the gamepad to target, using GameMaker's native [gamepad indexes](https://manual.yoyogames.com/#t=GameMaker_Language%2FGML_Reference%2FGame_Input%2FGamePad_Input%2FGamepad_Input.htm)|

The returned array contains integers that correspond the GameMaker's native [virtual button/axis constants](https://manual.yoyogames.com/#t=GameMaker_Language%2FGML_Reference%2FGame_Input%2FGamePad_Input%2FGamepad_Input.htm). These values indicate what buttons/axes have been mapped for the target gamepad.

If there is no gamepad connected for the given index, an empty array will be returned. If no mapping was applied to the gamepad (typically due to the gamepad not being covered by the SDL2 database) then all GameMaker constants are returned in the array.

#### **Example**

```gml
//Display the player's gamepad mappings in the debug log
if (input_gamepad_is_connected(input_player_get_gamepad()))
{
    show_debug_message("Player 0 gamepad mapping: " + string(input_gamepad_get_map(input_player_get_gamepad())));
}
```

<!-- tabs:end -->

&nbsp;


## …gamepad_map_contains

`input_gamepad_map_contains(gamepadIndex, GMconstant)`

<!-- tabs:start -->

#### **Description**

**Returns:** Boolean, if the indicated button or axis is mapped for the given gamepad

|Name          |Datatype|Purpose                                               |
|--------------|--------|------------------------------------------------------|
|`gamepadIndex`|integer |Index of the gamepad to target, using GameMaker's native [gamepad indexes](https://manual.yoyogames.com/#t=GameMaker_Language%2FGML_Reference%2FGame_Input%2FGamePad_Input%2FGamepad_Input.htm)|
|`GMconstant`  |integer/array |Button or axis to check, using GameMaker's native [virtual button/axis constants](https://manual.yoyogames.com/#t=GameMaker_Language%2FGML_Reference%2FGame_Input%2FGamePad_Input%2FGamepad_Input.htm), or an array of buttons or axes (see below) |

Returns whether the indicated buttons and axis are mapped for the target gamepad. `GMconstant` can also be an array of constants.

If there is no gamepad connected for the given index, the function returns `false`. If no mapping was applied to the gamepad (typically due to the gamepad not being covered by the SDL2 database) then all GameMaker constants return `true`. If an array of button and axis constants is provided for `GMconstant`, the function returns `true` if all buttons and axis are mapped.

#### **Example**

```gml
//Bind gamepad Start button to pause verb, using Guide instead if it is mapped
var _pause_binding = input_binding_gamepad_button(gp_start);
if (input_gamepad_map_contains(input_player_get_gamepad(), gp_guide))
{
    var _pause_binding = input_binding_gamepad_button(gp_guide);
}

input_binding_set("pause", _pause_binding);
```

<!-- tabs:end -->

&nbsp;

## …gamepad_constant_get_name

`input_gamepad_constant_get_name(GMconstant)`

<!-- tabs:start -->

#### **Description**

**Returns:** String, the human-readable name of the [virtual button/axis constant](https://manual.yoyogames.com/#t=GameMaker_Language%2FGML_Reference%2FGame_Input%2FGamePad_Input%2FGamepad_Input.htm)

|Name          |Datatype|Purpose                                               |
|--------------|--------|------------------------------------------------------|
|`GMconstant`  |integer |Button or axis to stringify, using GameMaker's native [virtual button/axis constants](https://manual.yoyogames.com/#t=GameMaker_Language%2FGML_Reference%2FGame_Input%2FGamePad_Input%2FGamepad_Input.htm)|

#### **Example**

```gml
//Show gamepad constant checked when the pause verb is activated
var _pause_binding = input_binding_get("pause");
if (input_check_pressed("pause") && (input_binding_get_source_type(_pause_binding) == INPUT_GAMEPAD))
{
    show_debug_message("Player paused using " + input_gamepad_constant_get_name(_pause_binding) + " gamepad binding");
}
```

<!-- tabs:end -->

&nbsp;

## …gamepads_get_status

`input_gamepads_get_status()`

<!-- tabs:start -->

#### **Description**

**Returns:** Struct, detailing the state of gamepad connection and disconnection

|Name|Datatype|Purpose|
|----|--------|-------|
|None|        |       |

This function returns a struct that describes the state of each gamepad, following the formatting below.

!> Do not edit the struct that this function returns! You may encounter undefined behaviour if you do.

```
{
    any_changes: <boolean that indicates whether anything has changed at all>
    new_connections: [
        <array of gamepad indexes that are newly connected this step>
    ],
    new_disconnections: [
        <array of gamepad indexes that are newly disconnected this step>
    ],
    gamepads: [
        <array of values from the INPUT_STATUS enum, one for each gamepad available on this platform>
    ],
}
```

The `INPUT_STATUS` enum contains the following members:

|Name                 |Purpose                                          |
|---------------------|-------------------------------------------------|
|`.NEWLY_DISCONNECTED`|Gamepad has been disconnected this frame         |
|`.DISCONNECTED`      |Gamepad is disconnected (for at least two frames)|
|`.NEWLY_CONNECTED`   |Gamepad has been connected this frame            |
|`.CONNECTED`         |Gamepad is connected (for at least two frames)   |

#### **Example**

```gml
//Alert player when a new gamepad is connected
var _gamepad_connections = array_length(input_gamepads_get_status().new_connections);
if (_gamepad_connections > 0) 
{
    instance_create_layer(10, 10, guiLayer, obWarning, {
        message: string(_gamepad_connections) + " new gamepad(s) connected!",
    });
}
```

<!-- tabs:end -->
