# Functions (String)

---

### `input_string_get()`

*Returns:* String, user-entered text

|Name           |Datatype|Purpose                                                                                   |
|---------------|--------|------------------------------------------------------------------------------------------|
|None         | |

Returns a string of user entered text via keyboard (physical, virtual and asychronous prompt). Useful for implementing name fields, chat functions and other text entry.

&nbsp;

&nbsp;

### `input_string_set([string])`

*Returns:* N/A (`undefined`)

|Name           |Datatype|Purpose                                                                                   |
|---------------|--------|------------------------------------------------------------------------------------------|
|`[string]`     |string  |Sets input string. If not specified, input string is cleared (set to empty).              |

This function is used to set the internal text entry value as returned by `input_string_get()`. If the target platform supports it, this includes setting the value of Game Maker's internal [`keyboard_string`](https://manual.yoyogames.com/GameMaker_Language/GML_Reference/Game_Input/Keyboard_Input/keyboard_string.htm) value.

&nbsp;

&nbsp;

### `input_string_async_get(prompt, [string], [allow_empty])`

*Returns:* Boolean, if the async request is successfully issued

|Name           |Datatype|Purpose                                                                                   |
|---------------|--------|------------------------------------------------------------------------------------------|
|`prompt`       |string  |Prompt caption                                                                            |
|`[string]`     |string  |Initial value. If not specified, internal string is used                                  |
|`[allow_empty]`|boolean |Whether a cancelled or returned-empty prompt is treated as valid. `false` if not specified|

Issues a modal prompt for text-entry. Intended for use on console platform targets. 

!>  Requires use of `input_string_dialog_async_event`.

&nbsp;

&nbsp;

### `input_string_dialog_async_event()`

*Returns:* N/A (`undefined`)

|Name           |Datatype|Purpose                                                                                   |
|---------------|--------|------------------------------------------------------------------------------------------|
|None         | |

Sets internal string to the result of a text-entry dialog prompt when issued by `input_string_async_get`.

!> This function must be used in the context of an [_Asynchronous Dialogue event_](https://manual.yoyogames.com/The_Asset_Editors/Object_Properties/Async_Events/Dialog.htm) (typically in a persistent instance). Required for use of `input_string_async_get`.
