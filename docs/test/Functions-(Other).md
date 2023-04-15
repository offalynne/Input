# Functions (Other)

&nbsp;

## …tick

`input_tick()`

<!-- tabs:start -->

#### **Description**

**Returns:** N/A (`undefined`)

|Name|Datatype|Purpose|
|----|--------|-------|
|None|        |       |

!> If you're using Input 5 on versions of GameMaker **before** 2022.5 (May 2022) then you'll need to call `input_tick()` in the Begin Step event of a persistent instance. This function handles all things Input behind the scenes, it is important to call `input_tick()` once (and only once) each step of your game. A good way to do this is by making `obj_input_manager` [persistent](https://manual.yoyogames.com/#t=The_Asset_Editors%2FObjects.htm), and placing one instance in your first room.

#### **Example**

```gml
//TODO lol
```

<!-- tabs:end -->

&nbsp;

## …axis_threshold_set

`input_axis_threshold_set(axis, min, max, [playerIndex])`

<!-- tabs:start -->

#### **Description**

**Returns:** A struct with two member variables, `mini` and `maxi`, containing the minimum and maximum thresholds

|Name           |Datatype|Purpose                                             |
|---------------|--------|----------------------------------------------------|
|`axis`         |real    |[Gamepad axis](https://manual.yoyogames.com/#t=GameMaker_Language%2FGML_Reference%2FGame_Input%2FGamePad_Input%2FGamepad_Input.htm) to target|
|`min`          |real    |Minimum threshold value                             |
|`max`          |real    |Maximum threshold value                             |
|`[playerIndex]`|integer |Player to target. If not specified, player 0 is used|

#### **Example**

```gml
//TODO lol
```

<!-- tabs:end -->

&nbsp;

## …axis_threshold_get

`input_axis_threshold_get(axis, [playerIndex])`

<!-- tabs:start -->

#### **Description**

**Returns:** A struct with two member variables, `.mini` and `.maxi`, containing the minimum and maximum thresholds

|Name           |Datatype|Purpose                                             |
|---------------|--------|----------------------------------------------------|
|`axis`         |real    |[Gamepad axis](https://manual.yoyogames.com/#t=GameMaker_Language%2FGML_Reference%2FGame_Input%2FGamePad_Input%2FGamepad_Input.htm) to target|
|`[playerIndex]`|integer |Player to target. If not specified, player 0 is used|

If the axis does not have a threshold definition (as set by `input_axis_threshold_set()`) when this function is called then a new definition is created using `INPUT_DEFAULT_MIN_THRESHOLD` and `INPUT_DEFAULT_MAX_THRESHOLD`.

#### **Example**

```gml
//TODO lol
```

<!-- tabs:end -->

&nbsp;

## …clear_momentary

`input_clear_momentary(state)`

<!-- tabs:start -->

#### **Description**

**Returns:** N/A (`undefined`)

|Name   |Datatype|Purpose       |
|-------|--------|--------------|
|`state`|boolean |Whether to clear all momentary input|

Clears momentary (pressed/released) input and connection checkers. This covers verbs as well as keyboard/mouse/gamepad direct checkers. Useful for [fixed timestep patterns](https://gafferongames.com/post/fix_your_timestep/) where momentary checks should only be handled for one cycle (for example [iota](https://github.com/JujuAdams/iota)).

#### **Example**

```gml
//TODO lol
```

<!-- tabs:end -->

&nbsp;


## …ignore_key_add

`input_ignore_key_add(key)`

<!-- tabs:start -->

#### **Description**

**Returns:** N/A (`undefined`)

|Name |Datatype|Purpose                                                                                                                 |
|-----|--------|------------------------------------------------------------------------------------------------------------------------|
|`key`|integer |[Key](https://manual.yoyogames.com/#t=GameMaker_Language%252FGML_Reference%252FGame_Input%252FKeyboard_Input%252FKeyboard_Input.htm) to add|

Adds a keyboard key to be ignored by Input. This will affect binding detection, but any existing bindings set up to scan for this key will still work to prevent players from getting themselves into a position where the game doesn't work (!).

**Please note** that the list of ignored keys may already be populated depending on what value is set for `INPUT_IGNORE_RESERVED_KEYS_LEVEL`. Please read the [`Configuration`](Configuration) page for more information.

#### **Example**

```gml
//TODO lol
```

<!-- tabs:end -->

&nbsp;

## …ignore_key_remove

`input_ignore_key_remove(key)`

<!-- tabs:start -->

#### **Description**

**Returns:** N/A (`undefined`)

|Name |Datatype|Purpose                                                                                                                    |
|-----|--------|---------------------------------------------------------------------------------------------------------------------------|
|`key`|integer |[Key](https://manual.yoyogames.com/#t=GameMaker_Language%252FGML_Reference%252FGame_Input%252FKeyboard_Input%252FKeyboard_Input.htm) to remove|

Removes a keyboard key from the ignore list.

#### **Example**

```gml
//TODO lol
```

<!-- tabs:end -->

&nbsp;

## …icons

`input_icons(categoryName)`

<!-- tabs:start -->

#### **Description**

**Returns:** N/A (`undefined`)

|Name                           |Datatype|Purpose                                                |
|-------------------------------|--------|-------------------------------------------------------|
|`gamepadType` or `categoryName`|string  |[Gamepad type](Library-Constants#gamepad-types) or special case to access. See below|

This function is used to define icons that [`input_binding_get_icon()`](Functions-(Binding-Access)?id=input_binding_get_iconbinding-playerindex) can return. This function should only be called in the [`__input_config_icons()`](Configuration?id=icons) script.

Icon category names can be a [gamepad type constant](Library-Constants#gamepad-types) that Input returns, or one of the following special cases:

|Category Name         |Occurrance                                                       |
|----------------------|-----------------------------------------------------------------|
|`"not a binding"`     |A non-binding is evaluated                                       |
|`"unknown"`           |An unrecognised binding is evaluated                             |
|`"gamepad fallback"`  |Binding is for a gamepad with an unrecognised or unsupported type|
|`"keyboard and mouse"`|Binding is for a keyboard key or mouse button                    |

&nbsp;

`input_icons()` must be used with what's called a [fluent interface](https://en.wikipedia.org/wiki/Fluent_interface). In practical terms, this means that `__input_config_icons()` should contain code that looks like this:

```
input_icons(INPUT_GAMEPAD_TYPE_XBOX_ONE)
.add("gamepad face south", "A")
.add("gamepad face east",  "B")
.add("gamepad face west",  "X")
.add("gamepad face north", "Y")
//etc.
```

Each call to the `.add()` method adds a new icon to the `INPUT_GAMEPAD_TYPE_XBOX_ONE` icon category.

!> Note that none of these lines terminate in a semicolon `;`. This is very important to ensure that the fluent interface works properly.

The first argument for the `.add()` method is a [binding name](Binding-Names), the second argument is the value to return as the icon for that binding. In the example above, the string `"A"` is being returned for the south-positioned gamepad button for an Xbox One controller. We might very well use sprites instead of strings:

```
input_icons(INPUT_GAMEPAD_TYPE_XBOX_ONE)
.add("gamepad face south", spr_xboxone_a)
.add("gamepad face east",  spr_xboxone_b)
.add("gamepad face west",  spr_xboxone_x)
.add("gamepad face north", spr_xboxone_y)
//etc.
```

?> Setting `INPUT_GAMEPAD_EXTENDED_TYPES` in the `__input_config_gamepads()` configuration to `true` will add the following gamepad types which can be referenced by string: `"steam deck"`, `"steam controller"`, `"8bitdo"`, `"mfi"`, `"luna"`, `"stadia"`, `"vcs modern"`, `"vcs classic"`, `"ouya"`, `"dreamcast"`, `"n64"`, `"saturn"`, `"snes"`, `"super famicom"`

#### **Example**

```gml
//TODO lol
```

<!-- tabs:end -->

&nbsp;

## …window_has_focus

`input_window_has_focus()`

<!-- tabs:start -->

#### **Description**

**Returns:** Boolean, whether the game window is in focus

|Name|Datatype|Purpose|
|----|--------|-------|
|None|        |       |

!> This function only works on desktop (Windows, MacOS, Linux) platforms.

#### **Example**

```gml
//TODO lol
```

<!-- tabs:end -->
