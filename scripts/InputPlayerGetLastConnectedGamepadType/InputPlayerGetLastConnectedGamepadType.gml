// Feather disable all

/// Returns the gamepad type of the currently connected gamepad for a player or, if the player is
/// not using a gamepad, returns the type for the last connected gamepad. If the player hash never
/// used a gamepad, this function will return `undefined`.
/// 
/// Game type will be a member of the INPUT_GAMEPAD_TYPE_* macros:
///  - `INPUT_GAMEPAD_TYPE_UNKNOWN`
///  - `INPUT_GAMEPAD_TYPE_XBOX`
///  - `INPUT_GAMEPAD_TYPE_PS4`
///  - `INPUT_GAMEPAD_TYPE_PS5`
///  - `INPUT_GAMEPAD_TYPE_SWITCH`
///  - `INPUT_GAMEPAD_TYPE_JOYCON_LEFT`
///  - `INPUT_GAMEPAD_TYPE_JOYCON_RIGHT`
/// 
/// @param {Real} [playerIndex=0]

function InputPlayerGetLastConnectedGamepadType(_playerIndex = 0)
{
    static _playerArray = __InputSystemPlayerArray();
    
    __INPUT_VALIDATE_PLAYER_INDEX
    
    return _playerArray[_playerIndex].__lastConnectedGamepadType;
}