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

Swapping A/O with B/X is a global setting and, once set, cannot be changed during game operation. As a result, this function should be called once at the start of the game before [`input_default_gamepad_button()`](https://github.com/JujuAdams/Input/wiki/Functions-(Default-Bindings)#input_default_gamepad_buttonbutton-verb-alternate).

If you *would* like to swap A/O with B/X during gameplay, please use the [binding functions](https://github.com/JujuAdams/Input/wiki/Functions-(Binding-Management)).