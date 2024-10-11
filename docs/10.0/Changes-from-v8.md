# Changes from Input 8

&nbsp;

Input 10 is a rewrite of the entire Input library from the ground up. With the benefit of five years of experience, it's been possible to refine the core technology and the API that you use. Input 10 is faster and more extensible than its predecessors whilst retaining its ease of use and consistency across platforms.

?> We've prepared a big list of function equivalents to help jump from Input 8 to Input 10. [You can read it here.](v8-Equivalents)

&nbsp;

There were two major motivations for Input 10:

1. Simplicity

2. Speed

Input 8 are immensely powerful tools but they are rather daunting to get started with. Lots of config macros, lots of unfamiliar terminology, lots of flexibility right on the surface. Input 10 makes basic use of the library obvious, clear, and comfortable.

A common question we got asked about Input was about its performance, and these questions usually were asked by new users who were getting spooked by GameMaker's profiler. Whilst we were happy with performance in prior versions of Input we always knew that there was room for improvement. Input 10 means you'll have precious processor time to play with.

Input 10 achieves these two goals without compromising on its overall featureset. It does this by introducing plug-ins that can hook into the library. These plug-ins are ways for external code to build further features on top of the core library code. We've built a handful of plug-ins already covering some of the useful but niche features of Input 8 and we're made the plug-in API publicly accessible so you can write your own.

&nbsp;

## Improved Features

- 1000% faster. Three zeroes.
- Feather support
- Configuration macros are **way** simpler
- Many advanced features have been moved to plug-ins to reduce clutter
- Simpler device management. Players have one device each
- Binding profiles have been stripped back. Players now have two hardcoded "profiles" - one for keyboard and mouse, one for gamepads
- Adds lots of functions to handle verb state import and export. This is helpful for replaying player input or lockstep multiplayer

&nbsp;

## Breaking Changes

- This is a full rewrite!
- Entire API has changed naming convention from snake_case to PascalCase
- We're using GameMaker's improved SDL implementation more so the library is a lot easier to maintain
- "Sources" in Input 8 have been renamed to "Devices" to better reflect their use
- Verbs are now members of an enum and are integers rather than strings
- 2D checkers are handled with pre-defined "clusters" for simplicity
- Config macros have been overhauled
- Mouse is always linked to the keyboard
- Many extended features have been moved to plug-ins and aren't part of the core library:
  - Binding icons
  - Multiplayer helper
  - Gyro & Motion
  - Vibration
  - Trigger effects
  - Gamepad colour

&nbsp;

## Removed Features

- Keyboard support on anything other than desktop
- Direct checkers for keyboard (though you can still scan for new bindings)
- Combo system has been removed as per Input 8
- Gamepad support on Android and iOS
- Now only one direct checker for gamepad to avoid confusion `PawprintDeviceGetGamepadValue(device, button/axis)`
- Native debug overlay gamepad tester
- General purpose device-agnostic cursor
- Accessibility API has been removed
- Mouse capture API removed as it is now a native GameMaker feature
- `.MIXED` and `.MULTI` sources have been removed
- Players can no longer share the save device