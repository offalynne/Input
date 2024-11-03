# Plug-ins

&nbsp;

Prior versions of Input have included a lot of functionality in the library itself making it bulky. To streamline Input, many features have been split off and reimplemented as plug-ins that you can choose to use if you want. These plug-ins are additional bits of code that bolt onto the core Input library, taking advantage of a new plug-in API.

?> You can also create your own plug-ins by using the [plug-in API](Functions-(Plug-ins)).

&nbsp;

## Binding Icons

*[Binding Icons Plug-In API](Plug-in-Binding-Icons)*

It is very common to need to show context hints for player input and this library provides a set of tools to show the necessary information.

&nbsp;

## Party Multiplayer

*[Party Multiplayer Plug-In API](Plug-in-Party-Multiplayer)*

This plug-in adds a handful of helpful behaviours to manage multiple players joining and leaving the game. You can read more about this plug-in in the [multiplayer guide](Multiplayer-Guide).

&nbsp;

## Gyro & Motion

*[Vibration Plug-In API](Plug-in-Gyro-Motion)*

Many gamepads contain accelerometers and gyroscopes that can be used to measure gamepad motion. This is increasingly popular with first-person shooters. Input supports this as far as is possible but requires Steam Input for this feature to be available on desktop. You can read more about implementing [Steam Input and Steamworks here](Steamworks).

&nbsp;

## Vibration

*[Vibration Plug-In API](Plug-in-Vibration)*

Gamepad vibration can add a lot to gamefeel. The Vibration plug-in implements some basic effects for you and makes implementing vibration much easier than without it.

&nbsp;

## Color

*[Color Plug-In API](Plug-in-Color)*

PlayStation gamepads have a series of RGB lights built into them that can be controlled, either to set the mood or to communicate to players which gamepad is which. When playing on a PlayStation console, these lights can be changed at will using Input. However, these lights cannot be controlled on any platform other than Windows and Steam Input must be running on Windows to control the gamepad colour. You can read more about implementing [Steam Input and Steamworks here](Steamworks).

&nbsp;

## Trigger Effects

*[Color Plug-In API](Plug-in-Trigger-Effects)*

PlayStation 5 introduced force feedback into DualSense 5 gamepads. Much like with gamepad colour above, this plug-in allows you to control the trigger effect applied to the gamepad. Trigger effects are available when running Input on a PlayStation 5 console or on Windows with Steam Input running. You can read more about implementing [Steam Input and Steamworks here](Steamworks).