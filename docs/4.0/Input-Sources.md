# Input Sources

---

GameMaker has numerous potential input sources - keyboard, mouse, gamepads - and Input provides a single interface to manage input from all of them.

Each player can use one **input source** at a time. These are listed below. [`input_player_source_set()`](Functions-(Players)#input_player_source_setsource-playerindex) and [`input_player_source_get()`](Functions-(Players)#input_player_source_getplayerindex) can be used to directly manage input sources, whilst [`input_assignment_tick()`](Functions-(Source-Assignment)#input_assignment_tickminplayers-maxplayers-leaveverb) and [`input_hotswap_tick()`](Functions-(Source-Assignment)#input_hotswap_tickplayerindex) are available as implementations of common features for your game.

Use of the keyboard and mouse is exclusive - only one player may use the keyboard and mouse. When a player has their input source set to `INPUT_SOURCE.GAMEPAD`, [`input_player_gamepad_set()`](Functions-(Players)#input_player_gamepad_setgamepad-playerindex) will need to be called as well to set that player's gamepad. A gamepad cannot be assigned to more than one player at the same time.

|Name                             |
|---------------------------------|
|`INPUT_SOURCE.NONE`              |
|`INPUT_SOURCE.KEYBOARD_AND_MOUSE`|
|`INPUT_SOURCE.GAMEPAD`           |
