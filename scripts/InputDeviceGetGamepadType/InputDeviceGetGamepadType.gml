// Feather disable all

/// Returns the type of gamepad that a device represents. If the device is not connected or isn't
/// a gamepad to begin with then this function returns INPUT_GAMEPAD_TYPE_NO_GAMEPAD. Otherwise,
/// this function will return a member of the `INPUT_GAMEPAD_TYPE_*` macros:
///  - `INPUT_GAMEPAD_TYPE_UNKNOWN`
///  - `INPUT_GAMEPAD_TYPE_XBOX`
///  - `INPUT_GAMEPAD_TYPE_PS4`
///  - `INPUT_GAMEPAD_TYPE_PS5`
///  - `INPUT_GAMEPAD_TYPE_SWITCH`
///  - `INPUT_GAMEPAD_TYPE_JOYCON_LEFT`
///  - `INPUT_GAMEPAD_TYPE_JOYCON_RIGHT`
/// 
/// @param {Real} device

function InputDeviceGetGamepadType(_device)
{
    static _gamepadArray = __InputSystem().__gamepadArray;
    
    if (_device < 0) return INPUT_GAMEPAD_TYPE_NO_GAMEPAD;
    
    return InputDeviceIsConnected(_device)? _gamepadArray[_device].__type : INPUT_GAMEPAD_TYPE_NO_GAMEPAD;
}