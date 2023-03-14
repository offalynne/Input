# Functions (Color)

&nbsp;

Gamepad color can be set for PlayStation console platforms, as well as on [Windows or Linux when the Steamworks extension is configured](Steamworks.md) adding Xbox Elite Series 2 and Steam Controller support.

&nbsp;

## `input_color_get([playerIndex])`

*Returns:* [Color](https://manual.yoyogames.com/GameMaker_Language/GML_Reference/Drawing/Colour_And_Alpha/Colour_And_Alpha.htm)

|Name           |Datatype           |Purpose                                               |
|---------------|-------------------|------------------------------------------------------|
|`[playerIndex]`|integer            |Player to target. If not specified, player 0 is used  |

Gets the LED color of a player's gamepad

&nbsp;

## `input_color_set(color, [playerIndex])`

*Returns:* N/A (`undefined`)

|Name           |Datatype           |Purpose                                               |
|---------------|-------------------|------------------------------------------------------|
|`color`        |color              |[Color](https://manual.yoyogames.com/GameMaker_Language/GML_Reference/Drawing/Colour_And_Alpha/Colour_And_Alpha.htm) to set the player's gamepad source LED |
|`[playerIndex]`|integer            |Player to target. If not specified, player 0 is used  |

Sets the LED color of a player's gamepad

&nbsp;

## `input_color_reset([playerIndex])`

*Returns:* N/A (`undefined`)

|Name           |Datatype           |Purpose                                             |
|---------------|-------------------|----------------------------------------------------|
|`[playerIndex]`|integer            |Player to target. If not specified, player 0 is used|

Resets the LED color of a player's gamepad

&nbsp;
