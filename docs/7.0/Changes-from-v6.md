# Changes from Input 6

&nbsp;

Input 7 introduces a number of new features alongside a number of breaking changes. This page will help you understand the differences between the two versions and help guide you towards spotting issues before updating.

&nbsp;

## New Features

- Improves SDL2 mapping DB load time
- Adds generic mapping for Xbox controllers on Linux
- Adds Windows IME state handling
- Adds gamepad handling exception for GMRT 
- Improves PlayStation 4 and PlayStation 5 gamepad mappings
- Updated gamepad data

&nbsp;

## Breaking Changes

- All struct variables returned by Input functions are now prefixed, eg. `value` becomes `__value` impacting the following functions
    - `input_axis_threshold_get()`
    - `input_axis_threshold_set()`
    - `input_virtual_create().get_position()`
    - `input_hotswap_params_get()`
    - `input_join_params_get()`
    - `input_cursor_limit_get()`
    - `input_mouse_capture_get()`
    - `input_binding_threshold_get()`
    - `input_binding_get()`
    - `input_binding_test_collisions()`
    - `input_binding_get_verbs()`
    - `input_players_get_status` 

&nbsp;

## Removed Features

- Support for older versions of GM LTS are deprecated