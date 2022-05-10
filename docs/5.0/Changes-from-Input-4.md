# Changes from Input 4

&nbsp;

## New Features

- Profiles
- Verb collision groups
- State-based hotswapping and multiplayer source assignment
- Gamepad and keyboard sharing
- Single player mixed input and multidevice modes
- Chords and combos
- Player ghosts
- Bindings can now be manually generated
- Device agnostic cursor reintroduced
- Configuration has been expanded and split up for greater legibility
- Improved memory management throughout

&nbsp;

## Other Changes

- Verb names must now be strings
- `input_tick()` is no longer needed (GMS2022.5 and later only)
- `input_binding_get_collisions()` has been renamed to `input_binding_test_collisions()`
- Default binding setter functions (`input_default_key()` etc.) have been removed in preference for a macro (`INPUT_DEFAULT_PROFILES`)
- `input_source_hotswap_tick()` and `input_source_assignment_tick()` have been replaced by source modes