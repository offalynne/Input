# Functions (Keyboard)

&nbsp;

?> These functions are provided for convenience if you want to implement your own features using Input's keyboard implementation. In general, [verbs](Verbs-and-Bindings) are the intended way to use Input and are preferred.

_These functions are almost directly passed-through and are presently only intended to prevent errors on platforms that do not properly support keyboard input._

&nbsp;

## `...keyboard_check`

**Full Function:** `input_keyboard_check(key)`

**Returns:** Boolean, if the key is currently activated

|Name    |Datatype|Purpose                                               |
|--------|--------|------------------------------------------------------|
|`key`   |integer |Key to check, using GameMaker's native [virtual key constants](https://manual.yoyogames.com/index.htm#t=GameMaker_Language%2FGML_Reference%2FGame_Input%2FKeyboard_Input%2FKeyboard_Input.htm)|

&nbsp;

## `...keyboard_check_pressed`

**Full Function:** `input_keyboard_check_pressed(key)`

**Returns:** Boolean, if the key is newly activated this frame

|Name |Datatype|Purpose                                               |
|-----|--------|------------------------------------------------------|
|`key`|integer |Key to check, using GameMaker's native [virtual key constants](https://manual.yoyogames.com/index.htm#t=GameMaker_Language%2FGML_Reference%2FGame_Input%2FKeyboard_Input%2FKeyboard_Input.htm)|

&nbsp;

## `...keyboard_check_released`

**Full Function:** `input_keyboard_check_released(key)`

**Returns:** Boolean, if the key is newly deactivated this frame

|Name |Datatype|Purpose                                               |
|-----|--------|------------------------------------------------------|
|`key`|integer |Key to check, using GameMaker's native [virtual key constants](https://manual.yoyogames.com/index.htm#t=GameMaker_Language%2FGML_Reference%2FGame_Input%2FKeyboard_Input%2FKeyboard_Input.htm)|
