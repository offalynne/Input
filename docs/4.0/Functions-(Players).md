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

### `input_player_gamepad_get_type([playerIndex])`

*Returns:* String, the player's gamepad's type (after SDL remapping)

|Name           |Datatype|Purpose                                             |
|---------------|--------|----------------------------------------------------|
|`[playerIndex]`|integer |Player to target. If not specified, player 0 is used|

Returns the same values as [`input_gamepad_get_type()`](Functions-(Gamepad)#input_gamepad_get_typegamepadindex).

&nbsp;

&nbsp;

### `input_player_gamepad_get_invalid_bindings([playerIndex])`

*Returns:* Array of structs, gamepad bindings that are invalid due to the gamepad lacking certain mapped inputs

|Name           |Datatype|Purpose                                             |
|---------------|--------|----------------------------------------------------|
|`[playerIndex]`|integer |Player to target. If not specified, player 0 is used|

This functions checks to see whether the current bindings for the given player are valid. Any bindings that are found to be invalid are stored and returned as an array. If there are no invalid bindings, this function will return an empty array.

An invalid binding occurs when the player's gamepad lacks a button or axis that the current binding scheme requires. For example, single Switch Joy-Cons lack a dpad; if the player has a verb mapped to one of the dpad buttons then that verb is no longer accessible if the player uses a single Joy-Con to play.

Single Switch Joy-Cons are far from the only gamepad with fewer buttons than a "standard" Xbox / PlayStation controller. How you respond to devices that lack certain buttons is up to you. In the specific case of single Joy-Cons, Input offers [functionality to handle them automatically](Functions-(Default-Bindings)#input_default_joycon_buttonbutton-verb-alternate).

The array returned by this function contains structs. Each struct contains two member variables:

|Name       |Description                                                                                                                                                                        |
|-----------|-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
|`verb`     |[Verb](https://www.jujuadams.com/Input/#/3.5/Verbs-and-Alternate-Bindings) that contains the invalid binding                                                                       |
|`alternate`|[Alternate index](https://www.jujuadams.com/Input/#/3.5/Verbs-and-Alternate-Bindings) for the invalid binding                                                                      |
|`gm`       |[Virtual button/axis constant](https://docs2.yoyogames.com/source/_build/3_scripting/4_gml_reference/controls/gamepad%20input/index.html) that is missing from the player's gamepad|
