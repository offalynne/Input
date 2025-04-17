# Changes from Input 8

&nbsp;

Input 10 is a rewrite of the entire Input library from the ground up. With the benefit of five years of experience, it's been possible to refine the core technology and the API that you use. Input 10 is faster and more extensible than its predecessors whilst retaining its ease of use and consistency across platforms.

?> We've prepared a big list of function equivalents to help jump from Input 8 to Input 10. [You can read it here.](v8-Equivalents)

&nbsp;

There were two major motivations for Input 10:

1. Simplicity

2. Speed

Input 8 contains immensely powerful tools but they are rather daunting to get started with. Lots of config macros, lots of unfamiliar terminology, lots of flexibility right on the surface. Input 10 makes basic use of the library obvious, clear, and comfortable.

A common question we got asked about Input was about its performance, and these questions usually were asked by new users who were getting spooked by GameMaker's profiler. Whilst we were happy with performance in prior versions of Input we always knew that there was room for improvement. Input 10 means you'll have precious processor time to play with.

Input 10 achieves these two goals without compromising on its overall featureset. It does this by introducing plug-ins that can hook into the library. These plug-ins are ways for external code to build further features on top of the core library code. We've built a handful of plug-ins already covering some of the useful but niche features of Input 8 and we have made the plug-in API publicly accessible so you can write your own.

&nbsp;

## Improved Features

- 1000% faster. Three zeroes
- Feather support
- Configuration macros are **way** simpler
- Faster to get set up
- Many advanced features have been moved to plug-ins to reduce clutter
- Simpler device management. Players have one device each
- Binding profiles have been stripped back. Players now have two hardcoded "profiles" - one for keyboard and mouse, one for gamepads
- Adds lots of functions to handle verb state import and export. This is helpful for replaying player input or lockstep multiplayer
- 2D checker setup is easier via "clusters"
- Plug-in system to allow swapping extra features in and out

&nbsp;

## Plug-ins

This plug-in system is a new concept for Input. Many of the niche features that saw lower usage have been rewritten as separate components that can be added and removed easily. The core library is thus much cleaner and leaner. Plug-ins that have been implemented are:

- Binding icons
- Multiplayer helper
- Gyro & motion
- Vibration
- Trigger effects
- Gamepad colour

&nbsp;

## Breaking Changes

- This is a full rewrite!
- Entire API has changed naming convention from snake_case to PascalCase for consistency with other popular libraries
- We're using GameMaker's improved SDL implementation more so the library is a lot easier to maintain
- "Sources" in Input 8 have been renamed to "Devices" to better reflect their use
- Verbs are now members of an enum and are integers rather than strings
- 2D checkers are handled with pre-defined "clusters" for simplicity
- Config macros have been overhauled
- Mouse is always linked to the keyboard

&nbsp;

## Removed Features

Not all features from Input 8 have been implemented in Input 10. These are features that saw very little usage, are easy to implement for the end user, or are very complex and need more development time. Features from Input 8 that have not been implemented yet but may return as plug-ins are:

- Some less common advanced checkers
- Chords
- Combos
- Replay
- General purpose device-agnostic cursor
- Accessibility features
- Separate mouse-only device (mouse is always linked to keyboard)
- `MIXED` and `MULTI` device types
- Multiple gamepad profiles per player

Features that have not made it to Input 10 for one reason or another are:

- Keyboard support on anything other than desktop
- Direct checkers for keyboard (though you can still scan for new bindings)
- Gamepad support on Android and iOS
- Now only one direct checker for gamepad to avoid confusion `InputDeviceGetGamepadValue(device, button/axis)`
- Native debug overlay gamepad tester
- Mouse capture API removed as it is now a native GameMaker feature
- Players can no longer share the same device
