# Input Sources

&nbsp;

Input can manage input from three fundamental sources - keyboards, mice, and gamepads. You can refer to these sources in code by using the `INPUT_KEYBOARD`, `INPUT_MOUSE` or `INPUT_GAMEPAD[n]` constants.

?> `INPUT_GAMEPAD` is an array and you'll need to use standard array syntax to access individual gamepads (i.e. `INPUT_GAMEPAD[0]` is the 0th gamepad).

If `INPUT_ASSIGN_KEYBOARD_AND_MOUSE_TOGETHER` is set to `true` then the keyboard and the mouse will be considered as a single device: `INPUT_KEYBOARD` and `INPUT_MOUSE` will be interchangeable.

A player can have any number of sources assigned to them. Each player must be assigned at least one input source for physical button presses (etc.) to be interpretted by Input and then passed to your game code. Whilst a player may have any number of sources assigned to them, by far and away the most common use case is for a player to be assigned either the keyboard and mouse or a gamepad.