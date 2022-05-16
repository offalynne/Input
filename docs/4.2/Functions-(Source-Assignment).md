# Functions (Source Assignment)

---

### `input_source_assignment_tick(minPlayers, maxPlayers, leaveVerb)`

*Returns:* Boolean, set to `true` when a player attempts to abort controller assignment

|Name        |Datatype                  |Purpose                                                                                    |
|------------|--------------------------|-------------------------------------------------------------------------------------------|
|`minPlayers`|integer                   |Minimum number of players that are required to play the current game mode                  |
|`maxPlayers`|integer                   |Maximum number of players that are allowed to play the current game mode                   |
|`leaveVerb` |[verb](Verbs-and-Variants)|[Verb](Verbs-and-Variants) that lets a player leave the game or abort controller assignment|

This function handles [input source](Input-Sources) assignment for you by using an internal system. Call this function **every frame** when you want to allow players to swap controllers for a multiplayer mode. You can also call this function when a player's gamepad loses connection and you want to allow them to reconnect it.

Players can join the game by pressing any button on their controller. Players can leave the game by activating the specified `leaveVerb`. If a player has not joined the game and activates `leaveVerb` then `input_assignment_tick()` will return `true` and you should return to the previous screen in your game. If no players had joined the game then the player that aborted source assignment will be set as player 0.

*N.B. If `maxPlayers` is set to `1` it will not be possible to abort source assignment.*

&nbsp;
---
&nbsp;

### `input_source_hotswap_tick([playerIndex])`

*Returns:* Boolean, indicating whether the player's [input source](Input-Sources) and/or [gamepad](https://docs2.yoyogames.com/source/_build/3_scripting/4_gml_reference/controls/gamepad%20input/index.html) was changed this frame

|Name           |Datatype      |Purpose                                             |
|---------------|--------------|----------------------------------------------------|
|`[playerIndex]`|integer       |Player to target. If not specified, player 0 is used|

This function handles [input source](Input-Sources) and [gamepad](https://docs2.yoyogames.com/source/_build/3_scripting/4_gml_reference/controls/gamepad%20input/index.html) hotswapping for you by using an internal system. Call this function **every frame** when you want to allow a player to move between [input sources](Input-Sources) or [gamepads](https://docs2.yoyogames.com/source/_build/3_scripting/4_gml_reference/controls/gamepad%20input/index.html) without having to go through manual reassignment.

*N.B. Turn off hotswapping when in a multiplayer mode!*

&nbsp;
---
&nbsp;

### `input_source_get_name(source)`

*Returns:* String, the name of the source

|Name    |Datatype      |Purpose                                                           |
|--------|--------------|------------------------------------------------------------------|
|`source`|[`INPUT_SOURCE`](Input-Sources)|[Input source](Input-Sources) to get the name for|

This function will return `"none"`, `"keyboard and mouse"`, or `"gamepad"`. If the source type is not recognised then `"unknown"` will be returned.

&nbsp;
---
&nbsp;

### `input_source_detect(source, [gamepad])`

*Returns:* Boolean, whether new input is detected from this [source](Input-Sources) (and the source is unassigned)

|Name       |Datatype                       |Purpose                                                                                                                                                                              |
|-----------|-------------------------------|-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
|`source`   |[`INPUT_SOURCE`](Input-Sources)|[Input source](Input-Sources) to check                                                                                                                                               |
|`[gamepad]`|integer                        |Index of the gamepad to target, using GameMaker's native [gamepad indexes](https://docs2.yoyogames.com/source/_build/3_scripting/4_gml_reference/controls/gamepad%20input/index.html)|

This function will return `false` if the source has been assigned to a player.

&nbsp;
---
&nbsp;

### `input_source_detect_any()`

*Returns:* Struct containing data on a [source](Input-Sources) that has presented **new** input and is unassigned, see below

|Name|Datatype|Purpose|
|----|--------|-------|
|None|        |       |

This function returns a struct with two member variables: `.source` contains a member of the [`INPUT_SOURCE`](Input-Sources) enum, and `.gamepad` will contain the [gamepad index](https://docs2.yoyogames.com/source/_build/3_scripting/4_gml_reference/controls/gamepad%20input/index.html). If new input is detected from the keyboard and mouse, `.gamepad` will contain `INPUT_NO_GAMEPAD`. If no new input is detected, `.source` will be `INPUT_SOURCE.NONE`.

&nbsp;
---
&nbsp;


### `input_source_is_available(source, [gamepad])`

*Returns:* Boolean, whether the given [source](Input-Sources) is unassigned

|Name       |Datatype                       |Purpose                                                                                                                                                                              |
|-----------|-------------------------------|-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
|`source`   |[`INPUT_SOURCE`](Input-Sources)|[Input source](Input-Sources) to check                                                                                                                                               |
|`[gamepad]`|integer                        |Index of the gamepad to target, using GameMaker's native [gamepad indexes](https://docs2.yoyogames.com/source/_build/3_scripting/4_gml_reference/controls/gamepad%20input/index.html)|