# Multiplayer Guide

---

Out of the box, Input gives you the basic tools to handle multiplayer games. You can manually set devices for players using [`InputPlayerSetDevice()`](Functions-(Player)?id=setdevice) and you can check to see if a player's is connected by calling [`InputPlayerIsConnected()`](Functions-(Player)?id=isconnected). You can further scan for input from a new device by calling [`InputDeviceGetNewActivity()`](Functions-(Device)?id=devicegetnewactivity). Using these tools, you can build your very own device assignment flow by checking for new activity on a device and then assigning that device to a disconnected player.

You can skip a lot of the work by using the [Party Multiplayer plug-in](Plug-in-Party-Multiplayer). This plug-in allows you to easily manage players joining and leaving the game without needing to write the system yourself. This plug-in has a simple API: [`InputPartySetParams()`](Plug-in-Party-Multiplayer?id=partysetparams) sets parameters for the game session (minimum and maximum number of players etc.), [`InputPartySetJoin()`](Plug-in-Party-Multiplayer?id=partysetjoin) sets whether players are able to join the game, and [`InputPartyGetReady()`](Plug-in-Party-Multiplayer?id=partygetready) returns whether enough players have joined the game based on the current parameters.

Calling `InputPartySetJoin(true)` will start the joining flow for players. Players will be able to join (and perhaps leave) the game freely. Once `InputPartySetJoin(false)` is called then players will no longer be able to join and the devices for your players are now locked in and gameplay can start. The exact rules for how players join the game are as follows:

1. Any new input from an unassigned device (pressing a key on a keyboard, pressing a button on a gamepad etc.) will be detected, and that device will then be assigned to the lowest index player without a device. This means players join the game in ascending order by pressing any key/button on their device of choice.
2. A player can leave the game by pressing a key/button that corresponds to a "leave" verb, as defined by `InputPartySetParams()`. If the `fillEmptyPlayers` parameter is set to `true` then players with a higher index than the player leaving will drop down a slot, ensuring that there are no gaps in the conntected players for the game.
3. If no players have a device assigned and the "leave" verb is activated on a device, then that device is assigned to player 0 and `InputPartySetJoin(false)` is called. The abort callback is executed, if defined. This allows players to leave a multiplayer game entirely.

?> Only input from unassigned devices is detected. Players cannot share devices in Input in general.

You can set parameters for the party multiplayer by using the `InputPartySetParams()` function. This allows you to set the minimum and maximum players for multiplayer gameplay, and you can optionally set the `fillEmptyPlayers` parameter mentioned above (defaults to `true`). The maximum number of players will actively prevent new players from joining, and the minimum number of players controls the lower threshold for when `InputPartyGetReady()` returns `true`.

```gml
//Set the number of players required to exactly 2
InputPartySetParams(INPUT_VERB.ACCEPT, 2, 2, true, INPUT_VERB.LEAVE, undefined, true);

//Start the party multiplayer, enabling automatic device assignment
InputPartySetJoin(true);
```

Once you have players joining your game, you'll want to display who's connected. You can use the `InputPlayerIsConnected()` function to determine which players are and aren't connected. As mentioned above, you can determine when you have enough players set up to begin the game by checking against `InputPartyGetReady()`. In the example below, we wait for enough players to join then we wait for a confirmation button press from either player. Once players have confirmed they want to start the game, we turn off party multiplayer joining to prevent further device assignment and proceed to multiplayer gameplay.

```gml
//Check every frame to see if we've got enough players to start gameplay
if (InputPartyGetReady())
{
    if (InputCheckLong(INPUT_VERB.ACCEPT, 0) || InputCheckLong(INPUT_VERB.ACCEPT, 1))
    {
        InputPartySetJoin(false);
        room_goto(rMultiplayerGameplay);
    }
}
```

You should also detect when a player's device has been disconnected, espcially if you're planning on shipping on console as it is a compliance requirement for all major platforms. If a player's device is unexpectedly disconnected, you should show a device connection screen and turn party joining back on to allow players to reconnect. In these situations you will likely want to set the `fillEmptyPlayers` parameter in `InputPartySetParams()` to `false`. You can detect when a player's device has been disconnected by checking `InputPlayerGetStatus()`.

```gml
if ((InputPlayerGetStatus(0) == INPUT_PLAYER_STATUS.NEWLY_DISCONNECTED)
||  (InputPlayerGetStatus(1) == INPUT_PLAYER_STATUS.NEWLY_DISCONNECTED))
{
    InputPartySetJoin(true);
    InputPartySetParams(INPUT_VERB.ACCEPT, 2, 2, false, undefined, undefined, true);
	PauseGame();
}
```
