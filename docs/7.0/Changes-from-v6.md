# Changes from Input 6

&nbsp;

Input 7 introduces a number of new features alongside a number of breaking changes. This page will help you understand the differences between the two versions and help guide you towards spotting issues before updating.

&nbsp;

## Breaking Changes

- All struct variables returned by Input functions are now prefixed, eg. `value` becomes `__value` impacting the following functions
    - [`input_axis_threshold_get()`](https://offalynne.github.io/Input/#/7.0/Functions-(Accessibility)?id=axis_threshold_get)
    - [`input_axis_threshold_set()`](https://offalynne.github.io/Input/#/7.0/Functions-(Accessibility)?id=axis_threshold_set)
    - [`input_virtual_create().get_position()`](https://offalynne.github.io/Input/#/7.0/Functions-(Virtual-Button-Setup)?id=get_position)
    - [`input_hotswap_params_get()`](https://offalynne.github.io/Input/#/7.0/Functions-(Source-Modes)?id=hotswap_params_get)
    - [`input_join_params_get()`](https://offalynne.github.io/Input/#/7.0/Functions-(Source-Modes)?id=join_params_get)
    - [`input_cursor_limit_get()`](https://offalynne.github.io/Input/#/7.0/Functions-(Cursor-Control)?id=cursor_limit_get)
    - [`input_mouse_capture_get()`](https://offalynne.github.io/Input/#/7.0/Functions-(Mouse-Capture)?id=mouse_capture_get)
    - [`input_binding_threshold_get()`](https://offalynne.github.io/Input/#/7.0/Functions-(Binding-Access)?id=binding_threshold_get)
    - [`input_binding_get()`](https://offalynne.github.io/Input/#/7.0/Functions-(Binding-Access)?id=binding_get)
    - [`input_binding_test_collisions()`](https://offalynne.github.io/Input/#/7.0/Functions-(Binding-Access)?id=binding_test_collisions)
    - [`input_binding_get_verbs()`](https://offalynne.github.io/Input/#/7.0/Functions-(Binding-Access)?id=binding_get_verbs)
    - [`input_players_get_status()`](https://offalynne.github.io/Input/#/7.0/Functions-(Players)?id=players_get_status)

&nbsp;

## Improved Features

- Improves SDL2 mapping DB load time
- Adds generic mapping for Xbox controllers on Linux
- Adds Windows IME state handling
- Adds gamepad handling exception for GMRT 
- Improves PlayStation 4 and PlayStation 5 gamepad mappings
- Disables DualSense trigger effects on game end
- Safer Steamworks struct name handling
- Corrects F13-24 binding labels
- Updates gamepad data

&nbsp;

## Removed Features

- Support for older versions of GM LTS are deprecated
