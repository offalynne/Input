# Functions (Players)

---

### `input_player_source_set(source, [playerIndex])`

*Returns:* N/A (`undefined`)

|Name           |Datatype                 |Purpose                                             |
|---------------|-------------------------|----------------------------------------------------|
|`source`       |[`INPUT_SOURCE`](Input-Sources)|[Input source](Input-Sources) to set for this player      |
|`[playerIndex]`|integer                  |Player to target. If not specified, player 0 is used|

&nbsp;

&nbsp;

### `input_player_source_get([playerIndex])`

*Returns:* [`INPUT_SOURCE`](Input-Sources)

|Name           |Datatype                 |Purpose                                             |
|---------------|-------------------------|----------------------------------------------------|
|`[playerIndex]`|integer                  |Player to target. If not specified, player 0 is used|

&nbsp;

&nbsp;

### `input_player_gamepad_set(gamepad, [playerIndex])`

*Returns:* N/A (`undefined`)

|Name           |Datatype|Purpose                                             |
|---------------|--------|----------------------------------------------------|
|`gamepad`      |[Gamepad](https://docs2.yoyogames.com/source/_build/3_scripting/4_gml_reference/controls/gamepad%20input/index.html) index|[Gamepad](https://docs2.yoyogames.com/source/_build/3_scripting/4_gml_reference/controls/gamepad%20input/index.html) to set for this player|
|`[playerIndex]`|integer |Player to target. If not specified, player 0 is used|

Use the macro `INPUT_NO_GAMEPAD` as the `gamepad` argument to indicate the player has no connected gamepad.

&nbsp;

&nbsp;

### `input_player_gamepad_get([playerIndex])`

*Returns:* [Gamepad](https://docs2.yoyogames.com/source/_build/3_scripting/4_gml_reference/controls/gamepad%20input/index.html) index

|Name           |Datatype|Purpose                                             |
|---------------|--------|----------------------------------------------------|
|`[playerIndex]`|integer |Player to target. If not specified, player 0 is used|

This function will return `INPUT_NO_GAMEPAD` if the player has no connected gamepad.

&nbsp;

&nbsp;

### `input_player_connected([playerIndex])`

*Returns:* Boolean, whether the player's device is connected

|Name           |Datatype|Purpose                                             |
|---------------|--------|----------------------------------------------------|
|`[playerIndex]`|integer |Player to target. If not specified, player 0 is used|

&nbsp;

&nbsp;

### `input_players_connected()`

*Returns:* Integer, the number of players with connected devices

|Name|Datatype|Purpose|
|----|--------|-------|
|None|        |       |

&nbsp;

&nbsp;

### `input_player_gamepad_get_description([playerIndex])`

*Returns:* String, the name of the player's gamepad (after SDL remapping)

|Name           |Datatype|Purpose                                             |
|---------------|--------|----------------------------------------------------|
|`[playerIndex]`|integer |Player to target. If not specified, player 0 is used|

Returns the same values as [`input_gamepad_get_description()`](https://github.com/JujuAdams/Input/wiki/Functions-(Gamepad)#input_gamepad_get_descriptiongamepadindex).

&nbsp;

&nbsp;

### `input_player_gamepad_get_type([playerIndex])`

*Returns:* String, the player's gamepad's type (after SDL remapping)

|Name           |Datatype|Purpose                                             |
|---------------|--------|----------------------------------------------------|
|`[playerIndex]`|integer |Player to target. If not specified, player 0 is used|

Returns the same values as [`input_gamepad_get_type()`](https://github.com/JujuAdams/Input/wiki/Functions-(Gamepad)#input_gamepad_get_typegamepadindex).

&nbsp;

&nbsp;

### `input_player_gamepad_get_dpad_style([playerIndex])`

*Returns:* String, the player's gamepad's dpad style (after SDL remapping)

|Name           |Datatype|Purpose                                             |
|---------------|--------|----------------------------------------------------|
|`[playerIndex]`|integer |Player to target. If not specified, player 0 is used|

Returns the same values as [`input_gamepad_get_dpad_style()`](https://github.com/JujuAdams/Input/wiki/Functions-(Gamepad)#input_gamepad_get_dpad_stylegamepadindex).