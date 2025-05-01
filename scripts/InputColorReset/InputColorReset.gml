// Feather disable all

/// Resets the color of a player's gamepad to whatever the system default is.
/// 
/// @param {Real} [playerIndex=0]

function InputColorReset(_playerIndex = 0)
{
     static _playerArray = __InputColorSystem().__playerArray;
    
    __INPUT_VALIDATE_PLAYER_INDEX
     
     _playerArray[_playerIndex].__SetColor(undefined);
}