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

!> Consider allowing Input to handle player gamepad assignment automatically using the [source assignment functions](Functions-(Source-Assignment)), or for single player, using [source hotswapping](Functions-(Source-Assignment)?id=input_source_hotswap_tickplayerindex). Avoid handling player gamepad assignment manually, as a gamepads may be disconnected or [blocklisted](Controller-Mapping?id=controller-blacklist), and on many platforms [may not enumerate in a predictable order](Device-Quirks?id=gamepad).

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

[XInput](https://wikipedia.org/wiki/DirectInput#XInput) controllers will typically return `xbox one` whereas any unrecognised gamepad will return `unknown`. Xbox Series X/S controllers will return `xbox one` owing to similarities across console generations, and that Xbox One gamepads are forwards compatible.

The following are valid strings this function may return besides `unknown`:

|Results   |          |          |
|----------|----------|----------| 
|`switch`  |`switch joycon left` | `switch joycon right`|
|`psx`     |`ps4`     |`ps5`     |
|`xbox 360`|`xbox one`|`saturn`  |
|`snes`    |`n64`     |`gamecube`|

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

&nbsp;

&nbsp;

### `input_players_get_status()`

*Returns:* Struct, detailing the state of player connection and disconnection

|Name|Datatype|Purpose|
|----|--------|-------|
|None|        |       |

This function returns a struct that describes the state of each player's connectivity, following the formatting below. This data is useful for detecting a change in player state wherein the game may need to create a new instance for that player or show a disconnection warning.

!> Do not edit the struct that this function returns! You may encounter undefined behaviour if you do.

```
{
    any_changes: <boolean that indicates whether anything has changed at all>
    new_connections: [
        <array of player indexes that are newly connected this step>
    ],
    new_disconnections: [
        <array of player indexes that are newly disconnected this step>
    ],
    players: [
        <array of values from the INPUT_STATUS enum, one for each player up to INPUT_MAX_PLAYERS>
    ],
}
```

The `INPUT_STATUS` enum contains the following members:

|Name                 |Purpose                                         |
|---------------------|------------------------------------------------|
|`.NEWLY_DISCONNECTED`|Player has been disconnected this frame         |
|`.DISCONNECTED`      |Player is disconnected (for at least two frames)|
|`.NEWLY_CONNECTED`   |Player has been connected this frame            |
|`.CONNECTED`         |Player is connected (for at least two frames)   |
