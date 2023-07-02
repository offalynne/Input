# Icon Config

&nbsp;

`__input_config_icons()` holds code that defines what values [`input_verb_get_icon()`](Functions-(Further-Verbs)) and [`input_binding_get_icon()`](Functions-(Icons)?id=binding_get_icon) should return for specific bindings for specific [types of gamepad](Functions-(Gamepad)?id=gamepad_get_type). `__input_config_icons()` itself never needs to be directly called in your code, but the script and the struct it contains must be present in a project for Input to work.

?> You should edit `__input_config_icons()` to customise Input for your own purposes.

!> Functions on this page should only be called in the [`__input_config_icons()`](Configuration?id=icons) script.

&nbsp;

## …_icon_empty

`input_icon_empty(icon)`

**Returns:** N/A (`undefined`)

|Name  |Datatype|Purpose                                                                           |
|------|--------|----------------------------------------------------------------------------------|
|`icon`|any     |The value to return for an empty binding (typically the result of an unbound verb)|

&nbsp;

## …_icon_not_a_binding

`input_icon_not_a_binding(icon)`

**Returns:** N/A (`undefined`)

|Name  |Datatype|Purpose                                                                                |
|------|--------|---------------------------------------------------------------------------------------|
|`icon`|any     |The value to return for an invalid binding (typically the result of some sort of error)|

&nbsp;

&nbsp;

---------------

The next two functions define "icon handlers" that Input uses to interpret what to return for each possible binding. These functions must be used with what's called a [fluent interface](https://en.wikipedia.org/wiki/Fluent_interface). In practical terms, this means that `__input_config_icons()` should contain code that looks like this:

```
input_icons(INPUT_GAMEPAD_TYPE_XBOX_ONE)
.add("gamepad face south", "A")
.add("gamepad face east",  "B")
.add("gamepad face west",  "X")
.add("gamepad face north", "Y")
//etc.
```

In the above code, each call to the `.add()` method adds a new icon to the `INPUT_GAMEPAD_TYPE_XBOX_ONE` icon category.

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

&nbsp;

## …_icons_gamepad

`input_icons_gamepad(gamepadType)`

**Returns:** Struct, a gamepad icon handler

|Name         |Datatype|Purpose                                        |
|-------------|--------|-----------------------------------------------|
|`gamepadType`|string  |[Gamepad type](Library-Constants#gamepad-types)|

Calling the `.add()` method on the struct returned by this function allows you to define icons for different gamepad types.

The `gamepadType` value should be an Input [gamepad type constant](Library-Constants?id=gamepad-types).

?> Setting `INPUT_GAMEPAD_EXTENDED_TYPES` in the `__input_config_gamepads()` configuration to `true` will add the following gamepad types which can be referenced by string: `"steam deck"`, `"steam controller"`, `"8bitdo"`, `"mfi"`, `"luna"`, `"stadia"`, `"vcs modern"`, `"vcs classic"`, `"ouya"`, `"dreamcast"`, `"n64"`, `"saturn"`, `"snes"`, `"super famicom"`

&nbsp;

## …_icons_keyboard_and_mouse

`input_icons_keyboard_and_mouse()`

**Returns:** Struct, a keyboard and mouse icon handler

|Name|Datatype|Purpose|
|----|--------|-------|
|None|        |       |

Calling the `.add()` method on the struct returned by this function allows you to define icons for keyboard and mouse bindings.

?> The binding name should be a value from Input's internal list of [binding names](Binding-Names).