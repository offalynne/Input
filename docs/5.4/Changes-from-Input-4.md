# Changes from Input 4

&nbsp;

## New Features

- New logo!
- Defining default bindings is now way clearer using [`INPUT_DEFAULT_PROFILES`](Verbs-and-Bindings?id=example-of-use)
- Binding [profiles](Profiles)
- [Verb groups](Verbs-and-Bindings?id=verb-groups)
- Accessibility features, including [momentary toggle](Functions-(Accessibility)) behaviour
- The native cross-platform and device-agnostic [cursor](Functions-(Cursor)) is back from the dead!
- [Chords and combos](Functions-(Extended-Verbs))
- Easier hotswapping and multiplayer source assignment via [source modes](Input-Sources?id=source-modes)
- Single player [mixed input](Input-Sources?id=input_source_modemixed) and [multidevice modes](Input-Sources?id=input_source_modemultidevice)
- Multiplayer gamepad and keyboard sharing supported out of the box using [dedicated functions](Functions-(Sources)?id=input_source_sharesource-playerindex-autoprofile)
- Expanded mouse support, including native mouse capture behaviour
- Player ghosts for use with replay systems, networking, or AI
- Stronger HTML5 support
- Bindings can now be manually generated
- Configuration macros have been expanded and split up for more customisation and greater legibility

&nbsp;

## Breaking Changes

- `input_tick()` is no longer needed (GMS2022.5 and later only)
- Default verb bindings are now configured using the [`INPUT_DEFAULT_PROFILES`](Verbs-and-Bindings?id=example-of-use) macro rather than using functions
- Complete reworking of the source system, allowing for players to be given multiple sources when you want. Please see the [sources](Input-Sources) documentation for more information
- Verb names must now be strings
- `input_binding_get_collisions()` has been renamed to `input_binding_test_collisions()`
- Default binding setter functions (`input_default_key()` etc.) have been removed in preference for the [`INPUT_DEFAULT_PROFILES`](Profiles)
- `input_source_hotswap_tick()` has been replaced by a [source mode](Input-Sources?id=source-modes)
- `input_source_assignment_tick()` has also been replaced by a [source mode](Input-Sources?id=source-modes). You'll need to configure multiplayer logic using the [multiplayer param](Functions-(Players)?id=input_multiplayer_params_setmin-max-dropdown) functions
- `input_guess_keyboard_layout()` and `input_platform_text_source()` have been replaced by [`INPUT_KEYBOARD_LOCALE`](Library-Constants?id=input_keyboard_locale) and [`INPUT_KEYBOARD_TYPE`](Library-Constants?id=input_keyboard_type) respectively
- `input_players_connected()` has been renamed to `input_player_connected_count()`
- `INPUT_MOUSE_MODE` has been removed and replaced with `input_mouse_coord_space_set()` and `input_mouse_coord_space_get()`
- Binding system read/write functions have now been renamed to export/import. More information [here](Functions-(Exporting-and-Importing))
- Input now supports multiple [binding profiles](Profiles) per player, rendering the old JoyCon-specific functions redundant
- `input_gamepad_get_button_label()` and `input_gamepad_get_button_color()` have been removed in preference for [`input_binding_get_icon()`](Functions-(Binding-Access)?id=input_binding_get_iconbinding-playerindex), as configued by [`__input_config_icons()`](Configuration?id=icons)
- `input_player_source_get()` has been replaced by `input_source_using()` due to the fact that players can have more than one device assigned to them