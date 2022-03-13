# Functions (Other)

---

### `input_axis_threshold_set(axis, min, max, [playerIndex])`

*Returns:* A struct with two member variables, `mini` and `maxi`, containing the minimum and maximum thresholds

|Name           |Datatype|Purpose                                             |
|---------------|--------|----------------------------------------------------|
|`axis`         |real    |[Gamepad axis](https://docs2.yoyogames.com/source/_build/3_scripting/4_gml_reference/controls/gamepad%20input/index.html) to target|
|`min`          |real    |Minimum threshold value                             |
|`max`          |real    |Maximum threshold value                             |
|`[playerIndex]`|integer |Player to target. If not specified, player 0 is used|

&nbsp;

&nbsp;

### `input_axis_threshold_get(axis, [playerIndex])`

*Returns:* A struct with two member variables, `mini` and `maxi`, containing the minimum and maximum thresholds

|Name           |Datatype|Purpose                                             |
|---------------|--------|----------------------------------------------------|
|`axis`         |real    |[Gamepad axis](https://docs2.yoyogames.com/source/_build/3_scripting/4_gml_reference/controls/gamepad%20input/index.html) to target|
|`[playerIndex]`|integer |Player to target. If not specified, player 0 is used|

If the axis does not have a threshold definition (as set by `input_axis_threshold_set()`) when this function is called then a new definition is created using `INPUT_DEFAULT_MIN_THRESHOLD` and `INPUT_DEFAULT_MAX_THRESHOLD`.

&nbsp;

&nbsp;

### `input_consume(verb, [playerIndex])`

*Returns:* N/A (`undefined`)

|Name           |Datatype                            |Purpose                                                                                                          |
|---------------|------------------------------------|-----------------------------------------------------------------------------------------------------------------|
|`verb`         |[verb](Verbs-and-Alternate-Bindings)|[Verb](Verbs-and-Alternate-Bindings) to consume. If keyword `all` is used, all verbs for the player are consumed.|
|`[playerIndex]`|integer                             |Player to target. If not specified, player 0 is used                                                             |

When a verb has been consumed, [check functions](Functions-(Checkers)) that target the verb will return `false` until the button is released and pressed again.

&nbsp;

&nbsp;

### `input_clear_momentary(state)`

*Returns:* N/A (`undefined`)

|Name   |Datatype|Purpose       |
|-------|--------|--------------|
|`state`|boolean |Whether to clear all momentary input|

Clear all pressed/released input checkers. This covers verbs as well as keyboard/mouse/gamepad direct checkers. Useful for [fixed timestep patterns](https://gafferongames.com/post/fix_your_timestep/) where momentary checks should only be handled for one cycle (for example [iota](https://github.com/JujuAdams/iota)).

&nbsp;

&nbsp;

### `input_guess_keyboard_layout()`

*Returns:* String indicating keyboard layout hint, `QWERTY` `AZERTY` or `QWERTZ`

|Name           |Datatype                                                             |Purpose                                                                         |
|---------------|---------------------------------------------------------------------|--------------------------------------------------------------------------------|
|None         | |

Provides a hint for default Latin keyboard layout based on available information. Utility for building safe default bindings based on [keyboard layout differences](https://www.typingpal.com/en/news/what-is-the-difference-between-QWERTY-QWERTZ-and-AZERTY-keyboards). Note that while system software determines the active keyboard layout and we can not detect this at runtime, this function provides a suggestion as to the system-default using OS locale info ([ISO 639-1](https://en.wikipedia.org/wiki/ISO_639-1) and [ISO 3166-1](https://en.wikipedia.org/wiki/ISO_3166-1)).

_Example usage_
```
if (input_guess_keyboard_layout() == "AZERTY")
{
    input_default_key(ord("E"), VERB.UP);
    input_default_key(ord("S"), VERB.LEFT);
    input_default_key(ord("D"), VERB.DOWN);
    input_default_key(ord("F"), VERB.RIGHT);
}
else
{
    input_default_key(ord("W"), VERB.UP);
    input_default_key(ord("A"), VERB.LEFT);
    input_default_key(ord("S"), VERB.DOWN);
    input_default_key(ord("D"), VERB.RIGHT);
}
```

&nbsp;

&nbsp;

### `input_verb_set(verb, value, [playerIndex])`

*Returns:* N/A (`undefined`)

|Name           |Datatype                             |Purpose                                                                                                 |
|---------------|-------------------------------------|--------------------------------------------------------------------------------------------------------|
|`verb`         |[verb](Verbs-and-Alternate-Bindings) |[Verb](Verbs-and-Alternate-Bindings) to set                                                             |
|`value`        |number                               |Value to set for the verb, from `-1` to `+1` (though most verbs will only expect values from `0` to `+1`|
|`[playerIndex]`|integer                              |Player to target. If not specified, player 0 is used                                                    |

Sets a value directly for a verb. It is recommend that verb values are set before executing [`input_tick()`](Functions-(System)#input_tick), or the change will not take effect until the following frame.

&nbsp;

&nbsp;

### `input_platform_text_source()`

*Returns:* String indicating platform text source, `async` `virtual` or `keyboard`

|Name           |Datatype                                                             |Purpose                                                                         |
|---------------|---------------------------------------------------------------------|--------------------------------------------------------------------------------|
|None         | |

Provides a suggestion for text entry handling based on platform target.

&nbsp;

&nbsp;

### `input_ignore_key_add(key)`

*Returns:* N/A (`undefined`)

|Name |Datatype|Purpose                                                                                                                 |
|-----|--------|------------------------------------------------------------------------------------------------------------------------|
|`key`|integer |[Key](https://docs2.yoyogames.com/source/_build/3_scripting/4_gml_reference/controls/keyboard%20input/index.html) to add|

Adds a keyboard key to be ignored by Input. This will affect binding detection, but any existing bindings set up to scan for this key will still work to prevent players from getting themselves into a position where the game doesn't work (!).

**Please note** that the list of ignored keys may already be populated depending on what value is set for `INPUT_IGNORE_RESERVED_KEYS_LEVEL`. Please read the [`Configuration`](Configuration) page for more information.

&nbsp;

&nbsp;

### `input_ignore_key_remove(key)`

*Returns:* N/A (`undefined`)

|Name |Datatype|Purpose                                                                                                                    |
|-----|--------|---------------------------------------------------------------------------------------------------------------------------|
|`key`|integer |[Key](https://docs2.yoyogames.com/source/_build/3_scripting/4_gml_reference/controls/keyboard%20input/index.html) to remove|

Removes a keyboard key from the ignore list.
