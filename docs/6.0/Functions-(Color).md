# Functions (Color)

&nbsp;

Gamepad color can be set for PlayStation console platforms, as well as on Windows or Linux [with Steamworks extension](Steamworks.md) adding Xbox Elite Series 2 and Steam Controller support.

&nbsp;

## …color_get

`input_color_get([playerIndex])`

<!-- tabs:start -->

#### **Description**

**Returns:** [Color](https://manual.yoyogames.com/GameMaker_Language/GML_Reference/Drawing/Colour_And_Alpha/Colour_And_Alpha.htm)

|Name           |Datatype|Purpose                                             |
|---------------|--------|----------------------------------------------------|
|`[playerIndex]`|integer |Player to target. If not specified, player 0 is used|

Gets the LED color of a player's gamepad.

#### **Example**

```gml
//Tint instance to match gamepad light
image_blend = input_color_get();
```

<!-- tabs:end -->

&nbsp;

## …color_set

`input_color_set([playerIndex])`

<!-- tabs:start -->

#### **Description**

**Returns:** N/A (`undefined`)

|Name           |Datatype|Purpose                                                                                                                                                    |
|---------------|--------|-----------------------------------------------------------------------------------------------------------------------------------------------------------|
|`color`        |color   |[Color](https://manual.yoyogames.com/GameMaker_Language/GML_Reference/Drawing/Colour_And_Alpha/Colour_And_Alpha.htm) to set the player's gamepad source LED|
|`[playerIndex]`|integer |Player to target. If not specified, player 0 is used                                                                                                       |

Sets the LED color of a player's gamepad.

#### **Example**

```gml
//Assign gamepad a random color value
input_color_set(irandom(c_white));
```

<!-- tabs:end -->

&nbsp;

## …color_reset

`input_color_reset([playerIndex])`

<!-- tabs:start -->

#### **Description**

**Returns:** N/A (`undefined`)

|Name           |Datatype|Purpose                                             |
|---------------|--------|----------------------------------------------------|
|`[playerIndex]`|integer |Player to target. If not specified, player 0 is used|

Resets the player's device's LED colour.

#### **Example**

```gml
//Pause game
if ((paused == false) && input_check_pressed("pause"))
{
    //Set gamepad light to default
    input_color_reset();

    paused = true;
}
```

<!-- tabs:end -->
