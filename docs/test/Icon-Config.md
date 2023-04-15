# Icon Config

&nbsp;

`__input_config_icons()` holds code that defines what values [`input_verb_get_icon()`](Functions-(Verbs)?id=input_verb_get_iconverb-playerindex-alternate-profilename) and [`input_binding_get_icon()`](Functions-(Binding-Access)?id=input_binding_get_iconbinding-playerindex)should return for specific bindings for specific [types of gamepad](Functions-(Players)?id=input_player_get_gamepad_typeplayerindex-binding). This script never needs to be directly called in your code, but the script and the struct it contains must be present in a project for Input to work.

For more information on how to customise `__input_config_icons()`, please see information relating to [`input_icons()`](Functions-(Other)?id=input_iconscategoryname), the function used throughout this script.

?> You should edit this script to customise Input for your own purposes.

&nbsp;

## input_icons()

`input_icons(categoryName)`

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