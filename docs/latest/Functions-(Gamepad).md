# Functions (Gamepad)

---

?> These functions are provided for convenience if you want to implement your own features using Input's SDL implementation. In general, [Player functions](Functions-(Players)) are the intended way to use Input and are preferred.

&nbsp;

&nbsp;

### `input_gamepad_check(gamepadIndex, GMconstant)`

*Returns:* Boolean, if the button/axis is currently activated

|Name          |Datatype|Purpose                                               |
|--------------|--------|------------------------------------------------------|
|`gamepadIndex`|integer |Index of the gamepad to target, using GameMaker's native [gamepad indexes](https://docs2.yoyogames.com/source/_build/3_scripting/4_gml_reference/controls/gamepad%20input/index.html)|
|`GMconstant`  |integer |Button or axis to check, using GameMaker's native [virtual button/axis constants](https://docs2.yoyogames.com/source/_build/3_scripting/4_gml_reference/controls/gamepad%20input/index.html). What physical input this actually checks is determined by Input's own SDL remapping system|

&nbsp;

&nbsp;

### `input_gamepad_check_pressed(gamepadIndex, GMconstant)`

*Returns:* Boolean, if the button/axis is newly activated this frame

|Name          |Datatype                  |Purpose                                               |
|--------------|--------------------------|------------------------------------------------------|
|`gamepadIndex`|integer                   |Index of the gamepad to target, using GameMaker's native [gamepad indexes](https://docs2.yoyogames.com/source/_build/3_scripting/4_gml_reference/controls/gamepad%20input/index.html)|
|`GMconstant`  |integer |Button or axis to check, using GameMaker's native [virtual button/axis constants](https://docs2.yoyogames.com/source/_build/3_scripting/4_gml_reference/controls/gamepad%20input/index.html). What physical input this actually checks is determined by Input's own SDL remapping system|

&nbsp;

&nbsp;

### `input_gamepad_check_released(gamepadIndex, GMconstant)`

*Returns:* Boolean, if the button/axis is newly deactivated this frame

|Name          |Datatype                  |Purpose                                               |
|--------------|--------------------------|------------------------------------------------------|
|`gamepadIndex`|integer                   |Index of the gamepad to target, using GameMaker's native [gamepad indexes](https://docs2.yoyogames.com/source/_build/3_scripting/4_gml_reference/controls/gamepad%20input/index.html)|
|`GMconstant`  |integer |Button or axis to check, using GameMaker's native [virtual button/axis constants](https://docs2.yoyogames.com/source/_build/3_scripting/4_gml_reference/controls/gamepad%20input/index.html). What physical input this actually checks is determined by Input's own SDL remapping system|

&nbsp;

&nbsp;

### `input_gamepad_value(gamepadIndex, GMconstant)`

*Returns:* Real, the analogue value of the input (after applying SDL axis remapping)

|Name          |Datatype                  |Purpose                                               |
|--------------|--------------------------|------------------------------------------------------|
|`gamepadIndex`|integer                   |Index of the gamepad to target, using GameMaker's native [gamepad indexes](https://docs2.yoyogames.com/source/_build/3_scripting/4_gml_reference/controls/gamepad%20input/index.html)|
|`GMconstant`  |integer |Button or axis to check, using GameMaker's native [virtual button/axis constants](https://docs2.yoyogames.com/source/_build/3_scripting/4_gml_reference/controls/gamepad%20input/index.html). What physical input this actually checks is determined by Input's own SDL remapping system|

&nbsp;

&nbsp;

### `input_gamepad_is_connected(gamepadIndex)`

*Returns:* Boolean, whether the given gamepad is connected

|Name          |Datatype|Purpose                                               |
|--------------|--------|-------------------------------------------------------|
|`gamepadIndex`|integer |Index of the gamepad to target, using GameMaker's native [gamepad indexes](https://docs2.yoyogames.com/source/_build/3_scripting/4_gml_reference/controls/gamepad%20input/index.html)|

&nbsp;

&nbsp;

### `input_gamepad_get_button_color(gamepadIndex, GMconstant)`

*Returns:* String, the gamepad input color

|Name          |Datatype                  |Purpose                                               |
|--------------|--------------------------|------------------------------------------------------|
|`gamepadIndex`|integer                   |Index of the gamepad to target, using GameMaker's native [gamepad indexes](https://docs2.yoyogames.com/source/_build/3_scripting/4_gml_reference/controls/gamepad%20input/index.html)|
|`GMconstant`  |integer |Button or axis to check, using GameMaker's native [virtual button/axis constants](https://docs2.yoyogames.com/source/_build/3_scripting/4_gml_reference/controls/gamepad%20input/index.html). What physical input this actually checks is determined by Input's own SDL remapping system|

Results are returned for gamepads with a standard button color scheme. PS5 and Switch controller inputs for example will always return `unknown`. In addition, controls that are not color coded, for example Xbox shoulder buttons and GameCube X and Y buttons will return `unknown`. 

valid 

|Results |
|:-------|
|`red` `green` `blue` `yellow` `pink`|

!> If you wish to use this function in production for drawing, you will need to specify [color values](https://manual.yoyogames.com/GameMaker_Language/GML_Reference/Drawing/Colour_And_Alpha/Colour_And_Alpha.htm) to match the returned string that suit your game's presentation needs and to meet appropriate [contrast specifications](https://webaim.org/resources/contrastchecker/) relative to your other graphics. Do not rely on color alone for button prompts.

&nbsp;

&nbsp;

### `input_gamepad_get_button_label(gamepadIndex, GMconstant)`

*Returns:* String, the gamepad input label

|Name          |Datatype                  |Purpose                                               |
|--------------|--------------------------|------------------------------------------------------|
|`gamepadIndex`|integer                   |Index of the gamepad to target, using GameMaker's native [gamepad indexes](https://docs2.yoyogames.com/source/_build/3_scripting/4_gml_reference/controls/gamepad%20input/index.html)|
|`GMconstant`  |integer |Button or axis to check, using GameMaker's native [virtual button/axis constants](https://docs2.yoyogames.com/source/_build/3_scripting/4_gml_reference/controls/gamepad%20input/index.html). What physical input this actually checks is determined by Input's own SDL remapping system|

Results are returned for labeled gamepad inputs with a standard name as per brand guidelines. Inputs with no on-device label, no brand-specified name (such as Xbox gamepad thumbsticks), or a label unsuited for use based on context (such as face buttons on single horizontal JoyCons) return `unknown`.

The following are valid strings this function may return besides `unknown`:

|Gamepad input                      |Results|
|:----------------------------------|:------|
|Face&nbsp;buttons                  |`Circle` `Square` `Triangle` `A` `B` `C` `D` `E` `F` `O` `U` `X` `Y` `Z` `I` `II`|
|Shoulders&nbsp;&amp;&nbsp;triggers |`L` `R` `L1` `R1` `L2` `R2` `LB` `RB` `LT` `RT` `SL` `SR` `ZL` `ZR`|
|Thumbsticks                        |`L3` `R3`|
|Meta&nbsp;buttons                  |`Select` `Start` `-` `+` `Back` `View` `Menu` `Share` `Options` `Create` `Action` `Credit` `Run` `Home` `Capture` `Mic`|
|Paddles                            |`LG` `RG` `L4` `R4` `L5` `R5` `M1` `M2` `M3` `M4` `P1` `P2` `P3` `P4`|

!> It is reccomended to present players with graphics instead of text for gamepad labels to better match non-textual symbols, as well as to extend support beyond English. In Input this is best accomplished by using [binding name values](https://www.jujuadams.com/Input/#/latest/Binding-Names?id=gamepad) to identify gamepad elements [according to device type](https://www.jujuadams.com/Input/#/latest/Gamepad-Button-Labels). Strings returned by this function are intended only as a development aid.

&nbsp;

&nbsp;

### `input_gamepad_get_description(gamepadIndex)`

*Returns:* String, the name of the gamepad (after SDL remapping)

|Name          |Datatype|Purpose                                               |
|--------------|--------|------------------------------------------------------|
|`gamepadIndex`|integer |Index of the gamepad to target, using GameMaker's native [gamepad indexes](https://docs2.yoyogames.com/source/_build/3_scripting/4_gml_reference/controls/gamepad%20input/index.html)|

&nbsp;

&nbsp;

### `input_gamepad_get_type(gamepadIndex)`

*Returns:* String, the gamepad type (after SDL remapping)

|Name          |Datatype                  |Purpose                                               |
|--------------|--------------------------|------------------------------------------------------|
|`gamepadIndex`|integer                   |Index of the gamepad to target, using GameMaker's native [gamepad indexes](https://docs2.yoyogames.com/source/_build/3_scripting/4_gml_reference/controls/gamepad%20input/index.html)|

[XInput](https://wikipedia.org/wiki/DirectInput#XInput) controllers will typically return `xbox 360` whereas any unrecognised gamepad will return `unknown`. Xbox Series X/S controllers will return `xbox one` owing to similarities across console generations, and that Xbox One gamepads are forwards compatible.

The following are valid strings this function may return besides `unknown`:

|Results   |          |          |
|----------|----------|----------| 
|`switch`  |`switch joycon left` | `switch joycon right`|
|`psx`     |`ps4`     |`ps5`     |
|`xbox 360`|`xbox one`|`saturn`  |
|`snes`    |`n64`     |`gamecube`|

&nbsp;

&nbsp;

### `input_gamepad_get_dpad_style(gamepadIndex)`

*Returns:* String, the style of the gamepad's dpad (after SDL remapping)

|Name          |Datatype                  |Purpose                                               |
|--------------|--------------------------|------------------------------------------------------|
|`gamepadIndex`|integer                   |Index of the gamepad to target, using GameMaker's native [gamepad indexes](https://docs2.yoyogames.com/source/_build/3_scripting/4_gml_reference/controls/gamepad%20input/index.html)|

The following are valid strings this function may return:

|Results    |Gamepad type                                    |Presentation example |
|-----------|------------------------------------------------|:-------------------:|
|`none`     |Switch (single Joy-Con)                         |*N/A*                |
|`arrows`   |Switch (handheld, Pro Controller, dual Joy-Cons)|<img alt="Arrows art example" width="150" src="https://i.imgur.com/V9qOstK.png">  |
|`segments` |PlayStation                                     |<img alt="Segments art example" width="150" src="https://i.imgur.com/Lmaya8O.png">|
|`disc`     |Xbox 360, Saturn                                |<img alt="Disc art example" width="150" src="https://i.imgur.com/IO0DjVQ.png">    |
|`cross`    |Default                                         |<img alt="Cross art example" width="150" src="https://i.imgur.com/b7f8Gnj.png">   |

*Example art courtesy https://thoseawesomeguys.com/prompts ([CC0](https://creativecommons.org/share-your-work/public-domain/cc0))*

&nbsp;

&nbsp;

### `input_gamepad_get_map(gamepadIndex)`

*Returns:* Array of integers, the buttons and axes that are mapped for the given gamepad

|Name          |Datatype|Purpose                                               |
|--------------|--------|------------------------------------------------------|
|`gamepadIndex`|integer |Index of the gamepad to target, using GameMaker's native [gamepad indexes](https://docs2.yoyogames.com/source/_build/3_scripting/4_gml_reference/controls/gamepad%20input/index.html)|

The returned array contains integers that correspond the GameMaker's native [virtual button/axis constants](https://docs2.yoyogames.com/source/_build/3_scripting/4_gml_reference/controls/gamepad%20input/index.html). These values indicate what buttons/axes have been mapped for the target gamepad.

If there is no gamepad connected for the given index, an empty array will be returned. If no mapping was applied to the gamepad (typically due to the gamepad not being covered by the SDL2 database) then all GameMaker constants are returned in the array.

&nbsp;

&nbsp;

### `input_gamepad_constant_get_name(GMconstant)`

*Returns:* String, the human-readable name of the [virtual button/axis constant](https://docs2.yoyogames.com/source/_build/3_scripting/4_gml_reference/controls/gamepad%20input/index.html)

|Name          |Datatype|Purpose                                               |
|--------------|--------|------------------------------------------------------|
|`GMconstant`  |integer |Button or axis to stringify, using GameMaker's native [virtual button/axis constants](https://docs2.yoyogames.com/source/_build/3_scripting/4_gml_reference/controls/gamepad%20input/index.html)|
