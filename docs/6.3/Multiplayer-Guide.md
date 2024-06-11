# Multiplayer Guide

---

Input offers a few distinct ways of handling multiplayer device assignment. The simplest way is to simply forcibly set devices for players using `input_source_set()` in the [`FIXED` source mode](Source-Modes?id=input_source_modefixed) but this approach may introduce small issues that add up to become quite complicated, and you'll end up doing a lot of work to get everything set up just right. Instead, we can use the [`JOIN` source mode](Source-Modes?id=input_source_modejoin) to automatically scan for new input from keyboards, mice, and gamepads and then assign new devices to players waiting for a device.

?> Whilst the `JOIN` source mode is intended for use for multiplayer gameplay, you may find it useful for handling device disconnection scenarios for single player gameplay modes too.

The `JOIN` source mode is set using [`input_source_mode_set()`](Functions-(Source-Modes)?id=source_mode_set). This will immediately start the device scanning process and devices will be assigned and unassigned for as long as Input is in the `JOIN` source mode. If you want to disable device assignment then you should change to another source mode, typically `FIXED`. Here are the rules for the `JOIN` source mode:

1. Any new input from an unassigned device (pressing a key on a keyboard, pressing a button on a gamepad etc.) will be detected, and that device will then be assigned to the lowest index player without a device. This means players join the game in ascending order by pressing any key/button on their device of choice.
2. Devices will only be scanned if you set up bindings for them in a [default profile](Verbs-and-Bindings) i.e. keyboards will only be detected if you used [`input_binding_key()`](Functions-(Binding-Creators)?id=binding_key), gamepads will only be detected if you used [one](Functions-(Binding-Creators)?id=binding_gamepad_button) of the [two](Functions-(Binding-Creators)?id=binding_gamepad_axis) gamepad binding creators
2. A player can leave the game by pressing a key/button that corresponds to a "leave" verb, as defined by [`input_join_params_set()`](Functions-(Source-Modes)?id=join_params_set). If the `dropDown` parameter is set to `true` then players with a higher index than the player leaving will drop down a slot, ensuring that there are no gaps in the conntected players for the game.
3. If no players have a device assigned and the "leave" verb is activated on a device, then that device is assigned to player 0 and the `JOIN` source mode is aborted. The source mode is then set to whatever it was before going into the `JOIN` source mode, and the [abort callback](Functions-(Source-Modes)?id=join_params_set) is executed. This allows players to leave a multiplayer game entirely.

?> Only input from unassigned devices is detected. Players cannot share devices with in the `JOIN` source mode. If you'd like to allow players to share devices then you'll need to write your own assignment system.

You can set parameters for the `JOIN` source mode by using the [`input_join_params_set()`](Functions-(Source-Modes)?id=join_params_set) function. This allows you to set the minimum and maximum players for multiplayer gameplay, and you can optionally set the `dropDown` parameter mentioned above (defaults to `true`). The maximum number of players will actively prevent new players from joining, and the minimum number of players controls the lower threshold for when [`input_join_is_finished()`](Functions-(Source-Modes)?id=join_is_finished) returns `true`.

```gml
//Set the number of players required to exactly 2
input_join_params_set(2, 2);

//Start the JOIN source mode, enabling automatic device assignment
input_source_mode_set(INPUT_SOURCE_MODE.JOIN);
```

Once you have players joining your game, you'll want to display who's connected. You can use the [`input_player_connected()`](Functions-(Players)?id=player_connected) function to determine which players are and aren't connected. As mentioned above, you can determine when you have enough players set up to begin the game by checking against [`input_join_is_finished()`](Functions-(Source-Modes)?id=join_is_finished). In the example below, we wait for enough players to join then we wait for a confirmation button press from either player. Once players have confirmed they want to start the game, we change to the [`FIXED` source mode](Source-Modes?id=input_source_modefixed) to prevent further device assignment and proceed to multiplayer gameplay.

```gml
//Check every frame to see if we've got enough players to start gameplay
if (input_join_is_finished())
{
    if (input_check_long("action", 0) || input_check_long("action", 1))
    {
        input_source_mode_set(INPUT_SOURCE_MODE.FIXED);
        room_goto(rm_multiplayer_gameplay);
    }
}
```

You should also detect when a player's device has been disconnected, espcially if you're planning on shipping on console as it is a compliance requirement for all major platforms. If a player's device is unexpectedly disconnected, you should show a device connection screen and return to the `JOIN` source mode to allow players to reconnect. In these situations you will likely want to set the `dropDown` parameter in `input_join_params_set()` to `false`. You can detect when a player's device has been disconnected by checking against the struct returned by [`input_players_get_status()`](Functions-(Players)?id=input_players_get_status).

```gml
if (array_length(input_players_get_status().__new_disconnections) > 0)
{
    input_source_mode_set(INPUT_SOURCE_MODE.JOIN);
	PauseGame();
}
```
