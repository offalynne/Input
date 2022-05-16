# Changes from Input 4

&nbsp;

## New Features

- Profiles
- Verb collision groups
- Dedicated cross-platform and device-agnostic cursor
- State-based hotswapping and multiplayer source assignment
- Gamepad and keyboard sharing
- Single player mixed input and multidevice modes
- Chords and combos
- Player ghosts
- Verb groups
- Bindings can now be manually generated
- Device agnostic cursor reintroduced
- Configuration has been expanded and split up for greater legibility

&nbsp;

## Other Changes

- Verb names must now be strings
- `input_tick()` is no longer needed (GMS2022.5 and later only)
- `input_binding_get_collisions()` has been renamed to `input_binding_test_collisions()`
- Default binding setter functions (`input_default_key()` etc.) have been removed in preference for a macro (`INPUT_DEFAULT_PROFILES`)
- `input_source_hotswap_tick()` and `input_source_assignment_tick()` have been replaced by source modes
- `input_guess_keyboard_layout()` and `input_platform_text_source()` have been replaced by `INPUT_KEYBOARD_LAYOUT` and `INPUT_KEYBOARD_TYPE` respectively
- `input_players_connected()` has been renamed to `input_player_connected_count()`
- `input_player_source_set()` has been renamed to `input_source_set()`, and 
- To support mixed/multidevice source modes, `input_player_source_get()`