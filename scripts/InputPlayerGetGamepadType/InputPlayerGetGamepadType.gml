// Feather disable all

/// Returns the gamepad type of the currently connected gamepad for a player. If the player is not
/// currently using a gamepad, this function will return `undefined`.
/// 
/// Game type will be a member of the `INPUT_GAMEPAD_TYPE_*` macros:
///  - `INPUT_GAMEPAD_TYPE_UNKNOWN`
///  - `INPUT_GAMEPAD_TYPE_XBOX`
///  - `INPUT_GAMEPAD_TYPE_PS4`
///  - `INPUT_GAMEPAD_TYPE_PS5`
///  - `INPUT_GAMEPAD_TYPE_SWITCH`
///  - `INPUT_GAMEPAD_TYPE_JOYCON_LEFT`
///  - `INPUT_GAMEPAD_TYPE_JOYCON_RIGHT`
/// 
/// @param {Real} [playerIndex=0]

function InputPlayerGetGamepadType(_playerIndex = 0)
{
    __INPUT_VALIDATE_PLAYER_INDEX
    
    return InputDeviceGetGamepadType(InputPlayerGetDevice(_playerIndex));
}