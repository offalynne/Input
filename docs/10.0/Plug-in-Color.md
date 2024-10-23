# Plug-in: Color

&nbsp;

Gamepad color can be set for PlayStation console platforms, as well as on Windows or Linux with [Steamworks](Steamworks.md) which additionally supports Xbox Elite Series 2 and Steam Controller.

&nbsp;

## …ColorGet

`InputColorGet([playerIndex])`

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
image_blend = InputColorGet();
```

<!-- tabs:end -->

## …ColorSet

`InputColorSet(color, [playerIndex])`

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
InputColorSet(irandom(c_white));
```

<!-- tabs:end -->

&nbsp;

## …ColorReset

`InputColorReset([playerIndex])`

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
if ((paused == false) && InputPressed(INPUT_VERB.PAUSE))
{
    //Set gamepad light to default
    InputColorReset();

    paused = true;
}
```

<!-- tabs:end -->

&nbsp;

## …ColorSupportedByDevice

`InputColorSupportedByDevice([playerIndex])`

<!-- tabs:start -->

#### **Description**

**Returns:** Boolean, whether color is supported for the device assigned to a player

|Name           |Datatype|Purpose                                             |
|---------------|--------|----------------------------------------------------|
|`[playerIndex]`|integer |Player to target. If not specified, player 0 is used|

#### **Example**

```gml
//Draw gamepad color availability
draw_text(x, y, "Color support: ", string(InputColorSupportedByDevice()));
```

<!-- tabs:end -->