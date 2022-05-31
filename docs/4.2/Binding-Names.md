# Binding Names

---

A list of possible return strings for [`input_binding_get_name`](Functions-(Bindings)#input_binding_get_namebinding). Keyboard bindings not covered by these specific output strings, such as letters with diacritics and non-Latin characters in general, fall back to the string a given keyboard key produces via [`keyboard_lastchar`](https://manual.yoyogames.com/GameMaker_Language/GML_Reference/Game_Input/Keyboard_Input/keyboard_lastchar.htm).

## Pointer
<!-- tabs:start -->
#### **Mouse Button**
|                       |                       |
|-----------------------|-----------------------|
| `mouse button left`   | `mouse button right`  |
| `mouse button back`   | `mouse button forward`|
| `mouse button middle` | `mouse button unknown`|
#### **Mouse Wheel**
|                       |                       |
|-----------------------|-----------------------|
| `mouse wheel up`      | `mouse wheel down`    |
#### **Touchscreen**
|                     |
|---------------------|
| `touchscreen press` |
<!-- tabs:end -->

## Gamepad

|                              |                              |
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
| `gamepad paddle 1`           | `gamepad paddle 2`           |
| `gamepad paddle 3`           | `gamepad paddle 4`           |
| `gamepad touchpad click`     | `gamepad unknown`            |

?> For labels specific to gamepad type, see [Button Labels by Gamepad Type](Gamepad-Button-Labels).

&nbsp;

&nbsp;

## Keyboard

<!-- tabs:start -->
#### **Primary**
|          |          |          |
|----------|----------|----------|
| `0`-`9`  | `A`-`Z`  |`F1`-`F32`|
#### **Symbols**
|         |
|---------|
|<code>&#124;</code> <code>&#59;</code> <code>&#61;</code> <code>&#44;</code> <code>&#45;</code> <code>&#46;</code> <code>&#47;</code> <code>&#39;</code> <code>&#91;</code> <code>&#92;</code> <code>&#93;</code> <code>&#35;</code> <code>&#96;</code>|
#### **Numpad**
|              |            |
|--------------|------------|
| `numpad 0-9` | `numpad .` |
| `numpad /`   | `numpad *` |
| `numpad -`   | `numpad +` |
#### **Command**
|                |                |
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
#### **Miscellaneous**
|                          |                          |
|--------------------------|--------------------------|
| `clear`                  | `help`                   |
| `menu`<sup>1</sup>       | `scroll lock`            |
| `caps lock`              | `num lock`               |
| `left meta`<sup>2</sup>  | `right meta`<sup>2</sup> |

<sup>1</sup> <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" viewBox="0 0 16 16"><path d="M3 6.5a.5.5 0 0 1 .5-.5h5a.5.5 0 0 1 0 1h-5a.5.5 0 0 1-.5-.5zm0 3a.5.5 0 0 1 .5-.5h5a.5.5 0 0 1 0 1h-5a.5.5 0 0 1-.5-.5zm.5 2.5a.5.5 0 0 0 0 1h5a.5.5 0 0 0 0-1h-5z"></path><path d="M2 0a2 2 0 0 0-2 2v12a2 2 0 0 0 2 2h12a2 2 0 0 0 2-2V2a2 2 0 0 0-2-2H2zm12 1a1 1 0 0 1 1 1v1H1V2a1 1 0 0 1 1-1h12zm1 3v10a1 1 0 0 1-1 1h-2V4h3zm-4 0v11H2a1 1 0 0 1-1-1V4h10z"></path>
</svg> Apps (Windows)<br>
<sup>2</sup> 
<svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="" viewBox="0 0 16 16"><path d="M6.555 1.375 0 2.237v5.45h6.555V1.375zM0 13.795l6.555.933V8.313H0v5.482zm7.278-5.4.026 6.378L16 16V8.395H7.278zM16 0 7.33 1.244v6.414H16V0z"></path>
</svg> Windows, <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-command" viewBox="0 0 16 16"><path d="M3.5 2A1.5 1.5 0 0 1 5 3.5V5H3.5a1.5 1.5 0 1 1 0-3zM6 5V3.5A2.5 2.5 0 1 0 3.5 6H5v4H3.5A2.5 2.5 0 1 0 6 12.5V11h4v1.5a2.5 2.5 0 1 0 2.5-2.5H11V6h1.5A2.5 2.5 0 1 0 10 3.5V5H6zm4 1v4H6V6h4zm1-1V3.5A1.5 1.5 0 1 1 12.5 5H11zm0 6h1.5a1.5 1.5 0 1 1-1.5 1.5V11zm-6 0v1.5A1.5 1.5 0 1 1 3.5 11H5z"></path></svg> Command (MacOS), <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-search" viewBox="0 0 16 16">
  <path d="M11.742 10.344a6.5 6.5 0 1 0-1.397 1.398h-.001c.03.04.062.078.098.115l3.85 3.85a1 1 0 0 0 1.415-1.414l-3.85-3.85a1.007 1.007 0 0 0-.115-.1zM12 6.5a5.5 5.5 0 1 1-11 0 5.5 5.5 0 0 1 11 0z"/>
</svg> Search (ChromeOS)
<!-- tabs:end -->
