// Feather disable all

/// Returns whether a player has been assigned a gamepad as their device.
/// 
/// @param {Real} [playerIndex=0]

function InputPlayerUsingGamepad(_playerIndex = 0)
{
    static _playerArray = __InputSystemPlayerArray();
    return InputDeviceIsGamepad(_playerArray[_playerIndex].__device);
}