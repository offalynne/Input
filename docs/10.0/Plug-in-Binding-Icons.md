# Plug-in: Binding Icons

&nbsp;

The Binding Icons Plug-in allows you to return icons as defined in `__InputIconConfigKeyboard`, `__InputIconConfigNintendo`, `__InputIconConfigPlayStation`, `__InputIconConfigXbox`, and `__InputIconConfigEdgeCases` script assets. These functions will return whatever is defined in the relevant configuration script, be it a string, a sprite, or something else entirely.

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

Sets icon data to return for a particular binding name when the player is using the keyboard and mouse device (`INPUT_KBM`). Use exclusively in `__InputIconConfigKeyboard`.

#### **Example**

```gml
InputIconDefineKeyboard("A", "A");
//...
InputIconDefineKeyboard("9", "9");
//...
InputIconDefineKeyboard(vk_end, "end");
```
<!-- tabs:end -->

&nbsp;

## …IconDefineGamepad

`InputIconDefineGamepad(binding, iconData)`

<!-- tabs:start -->

#### **Description**

**Returns:** N/A (`undefined`)

|Name           |Datatype|Purpose                                             |
|---------------|--------|----------------------------------------------------|
|`binding`      |binding |A (gamepad button constant)[https://manual.gamemaker.io/beta/en/GameMaker_Language/GML_Reference/Game_Input/GamePad_Input/Gamepad_Input.htm] binding to label|
|`iconData`     |any     |The value to return for an empty binding            |

Sets icon data to return for a particular binding name when the player is using a specific gamepad type. For use in `__InputIconConfigNintendo`, `__InputIconConfigPlayStation`, `__InputIconConfigXbox`, and `__InputIconConfigEdgeCases`.

#### **Example**

```gml
InputIconDefineGamepad(INPUT_GAMEPAD_TYPE_XBOX, gp_face1, "A"); //A
//...
InputIconDefineGamepad(INPUT_GAMEPAD_TYPE_XBOX, gp_paddlelb, "P4"); //P4
```
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

Sets icon data to return when a binding is empty. Use exclusively in `__InputIconConfigEdgeCases`.

#### **Example**

```gml
{
    
}
```
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

Sets icon data to return when a binding is unsupported on the target device. Use exclusively in `__InputIconConfigEdgeCases`.

#### **Example**

```gml
{
    
}
```
<!-- tabs:end -->

&nbsp;

## …IconGet

`InputIconGet()`

<!-- tabs:start -->

#### **Description**

**Returns:** Various, the icon identifier defined in the relevant device config

|Name           |Datatype|Purpose                                             |
|---------------|--------|----------------------------------------------------|

Returns 

#### **Example**

```gml
{
    
}
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

Returns 

#### **Example**

```gml
{
    
}
```
<!-- tabs:end -->
