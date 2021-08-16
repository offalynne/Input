# Binding Names

---

A list of possible return strings for [`input_binding_get_name()`](Functions-(Bindings)#input_binding_get_namebinding). Keyboard bindings not covered by these specific output strings, such as letters with diacritics and non-Latin characters in general, fall back to the string a given keyboard key produces via [`keyboard_lastchar`](https://manual.yoyogames.com/GameMaker_Language/GML_Reference/Game_Input/Keyboard_Input/keyboard_lastchar.htm).

&nbsp;

&nbsp;

## Mouse

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

&nbsp;

## Gamepad

|Gamepad button                       |                                     |
|-------------------------------------|-------------------------------------|
| `gamepad button a`                  | `gamepad button b`                  |
| `gamepad button x`                  | `gamepad button y`                  |
| `gamepad button shoulder l`         | `gamepad button shoulder r`         |
| `gamepad button trigger l`          | `gamepad button trigger r`          |
| `gamepad button select`             | `gamepad button start`              |
| `gamepad button guide`              | `gamepad button misc 1`             |
| `gamepad button dpad up`            | `gamepad button dpad down`          |
| `gamepad button dpad left`          | `gamepad button dpad right`         |
| `gamepad button thumbstick l left`  | `gamepad button thumbstick l right` |
| `gamepad button thumbstick l up`    | `gamepad button thumbstick l down`  |
| `gamepad button thumbstick r left`  | `gamepad button thumbstick r right` |
| `gamepad button thumbstick r up`    | `gamepad button thumbstick r down`  |
| `gamepad button thumbstick l click` | `gamepad button thumbstick r click` |
| `gamepad button unknown`            |

&nbsp;

| Gamepad axis                      |                                   |
|-----------------------------------|-----------------------------------|
| `gamepad axis trigger l`          | `gamepad axis trigger r`          |
| `gamepad axis thumbstick l up`    | `gamepad axis thumbstick l down`  |
| `gamepad axis thumbstick l left`  | `gamepad axis thumbstick l right` |
| `gamepad axis thumbstick r up`    | `gamepad axis thumbstick r down`  |
| `gamepad axis thumbstick r left`  | `gamepad axis thumbstick r right` |
| `gamepad axis unknown`            |

&nbsp;

&nbsp;

## Keyboard

|Primary   |          |          |
|----------|----------|----------|
| `0`-`9`  | `A`-`Z`  |`F1`-`F24`|

&nbsp;

| Symbols |
|---------|
|<code>&#124;</code> <code>&#59;</code> <code>&#61;</code> <code>&#44;</code> <code>&#45;</code> <code>&#46;</code> <code>&#47;</code> <code>&#39;</code> <code>&#91;</code> <code>&#92;</code> <code>&#93;</code> <code>&#35;</code> <code>&#96;</code>|

&nbsp;

|Numpad        |            |
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

|Miscellaneous            |                         |
|-------------------------|-------------------------|
|`clear`                  |`help`                   |
|`menu`<sup>1</sup>       |`scroll lock`            |
|`capslock`               |`numlock`                |
|`left meta`<sup>2</sup>  |`right meta`<sup>2</sup> |

<sub><sup>1</sup>a.k.a. Apps<br>
<sup>2</sup>a.k.a. Windows, Command (Mac), Search (Chrome OS)</sub>