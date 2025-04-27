//The default vibration strength. This value can be changed later by using input_vibrate_set_strength()
#macro INPUT_VIBRATION_DEFAULT_STRENGTH  1.0

//Joy-Con vibration motors can be a bit, uh, intense
//This value allows you to reduce the strength of vibration relative to other devices
#macro INPUT_VIBRATION_JOYCON_STRENGTH  0.4

//As of runtime 2024.8, the vibration side gamepads for native PS4/PS5 builds is reversed. This
//means vibrating the left side in code will vibrate the right side on the actual gamepad. As far
//as we can tell, this is a bug in the GameMaker runtime. Setting this macro to `true` fixes this
//problem. When (if) this issue is addressed in a bug fix, this macro should be set to `false`.
#macro INPUT_FIX_PS_NATIVE_VIBRATION_SIDE  true