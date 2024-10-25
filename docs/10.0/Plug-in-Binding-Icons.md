# Plug-in: Binding Icons

&nbsp;

The Binding Icons Plug-in allows you to return icons as defined in device icon config scripts. These functions will return whatever is defined in the relevant configuration script, be it a string, a sprite, or something else entirely.

&nbsp;

## …IconDefineKeyboard

`InputIconDefineKeyboard(binding, iconData)`

<!-- tabs:start -->

#### **Description**

**Returns:** N/A (`undefined`)

|Name           |Datatype|Purpose                                 |
|---------------|--------|----------------------------------------|
|`binding`      |binding |A character string, [virtual key constant](https://manual.gamemaker.io/beta/en/GameMaker_Language/GML_Reference/Game_Input/Keyboard_Input/Keyboard_Input.htm), or [mouse button constant](https://manual.gamemaker.io/lts/en/GameMaker_Language/GML_Reference/Game_Input/Mouse_Input/mouse_check_button.htm) to label|
|`iconData`     |any     |The value to return for an empty binding|

Sets icon data to return for a particular binding name when the player is using the keyboard and mouse device (`INPUT_KBM`). Use in `__InputIconConfigKeyboard` config script.

<!-- tabs:end -->

&nbsp;

## …IconDefineGamepad

`InputIconDefineGamepad(binding, iconData)`

<!-- tabs:start -->

#### **Description**

**Returns:** N/A (`undefined`)

|Name           |Datatype|Purpose                                             |
|---------------|--------|----------------------------------------------------|
|`binding`      |binding |A [gamepad button constant](https://manual.gamemaker.io/beta/en/GameMaker_Language/GML_Reference/Game_Input/GamePad_Input/Gamepad_Input.htm) binding to label|
|`iconData`     |any     |The value to return for an empty binding            |

Sets icon data to return for a particular binding name when the player is using a specific gamepad type. Use in `__InputIconConfigNintendo`, `__InputIconConfigPlayStation`, `__InputIconConfigXbox`, and `__InputIconConfigEdgeCases` config scripts.

<!-- tabs:end -->

&nbsp;

## …IconDefineEmpty

`InputIconDefineEmpty(iconData)`

<!-- tabs:start -->

#### **Description**

**Returns:** N/A (`undefined`)

|Name           |Datatype|Purpose                                             |
|---------------|--------|----------------------------------------------------|
|`iconData`     |any     |The value to return for an empty binding            |

Sets icon data to return when a binding is empty. Use in `__InputIconConfigEdgeCases` config script.

<!-- tabs:end -->

&nbsp;

## …IconDefineUnsupported

`InputIconDefineUnsupported(iconData)`

<!-- tabs:start -->

#### **Description**

**Returns:** N/A (`undefined`)

|Name           |Datatype|Purpose                                             |
|---------------|--------|----------------------------------------------------|
|`iconData`     |any     |The value to return for an unsupported binding      |

Sets icon data to return when a binding is unsupported on the target device. Use in `__InputIconConfigEdgeCases` config script.

<!-- tabs:end -->

&nbsp;

## …IconGet

`InputIconGet()`

<!-- tabs:start -->

#### **Description**

**Returns:** Various, the icon identifier defined in the relevant device config

|Name           |Datatype|Purpose                                             |
|---------------|--------|----------------------------------------------------|
|`verbIndex`    |integer |Verb to target                                      |
|`[alternate]`  |integer |Which alternate binding to target. If not specified, index 0 is used|
|`[playerIndex]`|intger  |Player to target. If not specified, player 0 is used|

Returns the icon data for the binding, as set by one of the `InputIconDefine*()` functions. The icon data that is returned will correlate with the player's current device and gamepad type.

#### **Example**

```gml
//Assume icons are a sprite index
draw_sprite(InputIconGet(INPUT_VERB.SHOOT), 0, room_width/2 + 5, 10);

//Text prompt label
draw_set_halign(fa_right);
draw_text(room_width/2 - 5, 10, "To shoot, press ")
```
<!-- tabs:end -->

&nbsp;

## …IconGetDirect

`InputIconGetDirect()`

<!-- tabs:start -->

#### **Description**

**Returns:** Various, the icon identifier defined in the relevant device config

|Name           |Datatype|Purpose                                             |
|---------------|--------|----------------------------------------------------|
|`binding`      |any     |Binding to check                                    |
|`forGamepad`   |boolean |Whether to include gamepad bindings                 |
|`gamepadType`  |intger  |What type of gamepad to returnt he binding name for |

Returns the icon data associated with a binding for a particular gamepad type, or the keyboard and mouse device (`INPUT_KBM`) if `forGamepad` is set to `false`.

#### **Example**

```gml
//Show an icon for Xbox and PlayStation gamepads. Assume icons are a sprite index
draw_sprite(InputIconGetDirect(INPUT_VERB.SHOOT, true, INPUT_GAMEPAD_TYPE_XBOX), 0, room_width/2 + 10, 10);
draw_sprite(InputIconGetDirect(INPUT_VERB.SHOOT, true, INPUT_GAMEPAD_TYPE_PS5 ), 0, room_width/2 + 25, 10);

//Text prompt label
draw_set_halign(fa_right);
draw_text(room_width/2 - 5, 10, "To shoot, press ")
```
<!-- tabs:end -->
