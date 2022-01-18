# Functions (Default Bindings)

---

### `input_default_key(key, verb, [alternate])`

*Returns:* N/A (`undefined`)

|Name         |Datatype|Purpose       |
|-------------|--------|--------------|
|`key`        |integer |[Key](https://docs2.yoyogames.com/source/_build/3_scripting/4_gml_reference/controls/keyboard%20input/index.html) to bind|
|`verb`       |[verb](Verbs-and-Alternate-Bindings)|[Verb](Verbs-and-Alternate-Bindings) to target|
|`[alternate]`|integer |[Alternate binding](Verbs-and-Alternate-Bindings) to set|

&nbsp;

&nbsp;

### `input_default_mouse_button(button, verb, [alternate])`

*Returns:* N/A (`undefined`)

|Name       |Datatype      |Purpose       |
|-----------|--------------|--------------|
|`button`   |integer       |[Mouse button](https://docs.yoyogames.com/source/dadiospice/002_reference/mouse,%20keyboard%20and%20other%20controls/mouse%20input/index.html) to bind|
|`verb`     |[verb](Verbs-and-Alternate-Bindings)|[Verb](Verbs-and-Alternate-Bindings) to target|
|`[alternate]`|integer |[Alternate binding](Verbs-and-Alternate-Bindings) to set|

&nbsp;

&nbsp;

### `input_default_mouse_wheel_up(verb, [alternate])`

*Returns:* N/A (`undefined`)

|Name       |Datatype      |Purpose       |
|-----------|--------------|--------------|
|`verb`     |[verb](Verbs-and-Alternate-Bindings)|[Verb](Verbs-and-Alternate-Bindings) to target|
|`[alternate]`|integer |[Alternate binding](Verbs-and-Alternate-Bindings) to set|

&nbsp;

&nbsp;

### `input_default_mouse_wheel_down(verb, [alternate])`

*Returns:* N/A (`undefined`)

|Name       |Datatype      |Purpose       |
|-----------|--------------|--------------|
|`verb`     |[verb](Verbs-and-Alternate-Bindings)|[Verb](Verbs-and-Alternate-Bindings) to target|
|`[alternate]`|integer |[Alternate binding](Verbs-and-Alternate-Bindings) to set|

&nbsp;

&nbsp;

### `input_default_gamepad_button(button, verb, [alternate])`

*Returns:* N/A (`undefined`)

|Name       |Datatype      |Purpose       |
|-----------|--------------|--------------|
|`button`   |integer       |[Gamepad button](https://docs2.yoyogames.com/source/_build/3_scripting/4_gml_reference/controls/gamepad%20input/index.html) to bind|
|`verb`     |[verb](Verbs-and-Alternate-Bindings)|[Verb](Verbs-and-Alternate-Bindings) to target|
|`[alternate]`|integer |[Alternate binding](Verbs-and-Alternate-Bindings) to set|

&nbsp;

&nbsp;

### `input_default_gamepad_axis(axis, negative, verb, [alternate])`

*Returns:* N/A (`undefined`)

|Name       |Datatype      |Purpose       |
|-----------|--------------|--------------|
|`axis`     |integer       |[Gamepad axis](https://docs2.yoyogames.com/source/_build/3_scripting/4_gml_reference/controls/gamepad%20input/index.html) to bind|
|`negative` |boolean       |Whether the axis expects negative values|
|`verb`     |[verb](Verbs-and-Alternate-Bindings)|[Verb](Verbs-and-Alternate-Bindings) to target|
|`[alternate]`|integer |[Alternate binding](Verbs-and-Alternate-Bindings) to set|

&nbsp;

&nbsp;

### `input_default_gamepad_swap_ab(state)`

*Returns:* N/A (`undefined`)

|Name   |Datatype|Purpose       |
|-------|--------|--------------|
|`state`|boolean |[Gamepad axis](https://docs2.yoyogames.com/source/_build/3_scripting/4_gml_reference/controls/gamepad%20input/index.html) to bind|

Swapping A/O with B/X is a global setting and, once set, cannot be changed during game operation. As a result, this function should be called once at the start of the game before [`input_default_gamepad_button()`](Functions-(Default-Bindings)#input_default_gamepad_buttonbutton-verb-alternate) and [`input_default_joycon_button()`](Functions-(Default-Bindings)#input_default_joycon_buttonbutton-verb-alternate).

If you *would* like to swap A/O with B/X during gameplay, please use the [binding functions](Functions-(Bindings)).

&nbsp;

&nbsp;

### `input_default_joycon_button(button, verb, [alternate])`

*Returns:* N/A (`undefined`)

|Name       |Datatype      |Purpose       |
|-----------|--------------|--------------|
|`button`   |integer       |[Gamepad button](https://docs2.yoyogames.com/source/_build/3_scripting/4_gml_reference/controls/gamepad%20input/index.html) to bind|
|`verb`     |[verb](Verbs-and-Alternate-Bindings)|[Verb](Verbs-and-Alternate-Bindings) to target|
|`[alternate]`|integer |[Alternate binding](Verbs-and-Alternate-Bindings) to set|

?> Default Joy-Con bindings are optional. For basic gamepad configuration, you can stick to `input_default_gamepad_button()` and `input_default_gamepad_axis()`.

This function sets up default bindings for single Switch Joy-Cons. Due to single Joy-Cons having substantially fewer buttons than "standard" Xbox / PlayStation controllers, it's common to require a different button layout when using single Joy-Cons.

Simple games won't need to call `input_default_joycon_button()` or `input_default_joycon_axis()` provided that essential verbs are placed on button/axes that exist on a single Joy-Con. In this situation, calling the standard `input_default_gamepad*()` functions will suffice.

However, if `input_default_joycon_button()` or `input_default_joycon_axis()` have been called during the initialization of your game, the binding configuration you've defined using those functions will be used when a player plays with a single Joy-Con. Calling either function also enables a separate rebinding category for Joy-Cons versus other gamepads.

!> The state set by `input_default_gamepad_swap_ab()` still applies to single Joy-Cons.

&nbsp;

&nbsp;

### `input_default_joycon_axis(axis, negative, verb, [alternate])`

*Returns:* N/A (`undefined`)

|Name       |Datatype      |Purpose       |
|-----------|--------------|--------------|
|`axis`     |integer       |[Gamepad axis](https://docs2.yoyogames.com/source/_build/3_scripting/4_gml_reference/controls/gamepad%20input/index.html) to bind|
|`negative` |boolean       |Whether the axis expects negative values|
|`verb`     |[verb](Verbs-and-Alternate-Bindings)|[Verb](Verbs-and-Alternate-Bindings) to target|
|`[alternate]`|integer |[Alternate binding](Verbs-and-Alternate-Bindings) to set|

?> Default Joy-Con bindings are optional. For basic gamepad configuration, you can stick to `input_default_gamepad_button()` and `input_default_gamepad_axis()`.

This function sets up default bindings for single Switch Joy-Cons. Due to single Joy-Cons having substantially fewer buttons than "standard" Xbox / PlayStation controllers, it's common to require a different button layout when using single Joy-Cons.

Simple games won't need to call `input_default_joycon_button()` or `input_default_joycon_axis()` provided that essential verbs are placed on button/axes that exist on a single Joy-Con. In this situation, calling the standard `input_default_gamepad*()` functions will suffice.

However, if `input_default_joycon_axis()` or `input_default_joycon_button()` have been called during the initialization of your game, the binding configuration you've defined using those functions will be used when a player plays with a single Joy-Con. Calling either function also enables a separate rebinding category for Joy-Cons versus other gamepads.
