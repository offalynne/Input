# Binding Names

---

A list of possible return strings for [`input_binding_get_name`](Functions-(Bindings)#input_binding_get_namebinding). Keyboard bindings not covered by these specific output strings, such as letters with diacritics and non-Latin characters in general, fall back to the string a given keyboard key produces via [`keyboard_lastchar`](https://manual.yoyogames.com/GameMaker_Language/GML_Reference/Game_Input/Keyboard_Input/keyboard_lastchar.htm).

&nbsp;

&nbsp;

## Pointer

| Mouse button          |                       |
|-----------------------|-----------------------|
| `mouse button left`   | `mouse button right`  |
| `mouse button back`   | `mouse button forward`|
| `mouse button middle` | `mouse button unknown`|

&nbsp;

| Mouse wheel           |                       |
|-----------------------|-----------------------|
| `mouse wheel up`      | `mouse wheel down`    |

&nbsp;

| Touchscreen         |
|---------------------|
| `touchscreen press` |

&nbsp;

&nbsp;

## Gamepad

| Gamepad digital              |                              |
|------------------------------|------------------------------|
| `gamepad face south`         | `gamepad face east`          |
| `gamepad face west`          | `gamepad face north`         |
| `gamepad shoulder l`         | `gamepad shoulder r`         |
| `gamepad trigger l`          | `gamepad trigger r`          |
| `gamepad select`             | `gamepad start`              |
| `gamepad guide`              | `gamepad misc 1`             |
| `gamepad dpad up`            | `gamepad dpad down`          |
| `gamepad dpad left`          | `gamepad dpad right`         |
| `gamepad thumbstick l left`  | `gamepad thumbstick l right` |
| `gamepad thumbstick l up`    | `gamepad thumbstick l down`  |
| `gamepad thumbstick r left`  | `gamepad thumbstick r right` |
| `gamepad thumbstick r up`    | `gamepad thumbstick r down`  |
| `gamepad thumbstick l click` | `gamepad thumbstick r click` |
| `gamepad touchpad click`     | `gamepad unknown`            |

?> For labels specific to gamepad type, see [Button Labels by Gamepad Type](Gamepad-Button-Labels).

&nbsp;

&nbsp;

## Keyboard

| Primary  |          |          |
|----------|----------|----------|
| `0`-`9`  | `A`-`Z`  |`F1`-`F32`|

&nbsp;

| Symbols |
|---------|
|<code>&#124;</code> <code>&#59;</code> <code>&#61;</code> <code>&#44;</code> <code>&#45;</code> <code>&#46;</code> <code>&#47;</code> <code>&#39;</code> <code>&#91;</code> <code>&#92;</code> <code>&#93;</code> <code>&#35;</code> <code>&#96;</code>|

&nbsp;

| Numpad       |            |
|--------------|------------|
| `numpad 0-9` | `numpad .` |
| `numpad /`   | `numpad *` |
| `numpad -`   | `numpad +` |

&nbsp;

| Command        |                |
|----------------|----------------|
| `arrow up`     | `arrow down`   |
| `arrow left`   | `arrow right`  |
| `escape`       | `backspace`    |
| `enter`        | `delete`       |
| `home`         | `end`          |
| `space`        | `tab`          |
| `insert`       | `print screen` |
| `page down`    | `page up`      |
| `shift`        | `pause break`  |
| `ctrl`         | `alt`          |
| `left shift`   | `right shift`  |
| `left ctrl`    | `right ctrl`   |
| `left alt`     | `right alt`    |

&nbsp;

| Miscellaneous            |                          |
|--------------------------|--------------------------|
| `clear`                  | `help`                   |
| `menu`<sup>1</sup>       | `scroll lock`            |
| `capslock`               | `numlock`                |
| `left meta`<sup>2</sup>  | `right meta`<sup>2</sup> |

<sup>1</sup>a.k.a. Apps<br>
<sup>2</sup>a.k.a. Windows, Command (Mac), Search (Chrome OS)
