// Feather disable all

/// Returns the color that has been set for a player's gamepad. This function can return
/// `undefined` which indicates that no color has been set, or that the color has been reset.
/// 
/// @param {Real} [playerIndex=0]

function InputColorGet(_playerIndex = 0)
{
     static _playerArray = __InputColorSystem().__playerArray;
    
    __INPUT_VALIDATE_PLAYER_INDEX
     
     return _playerArray[_playerIndex].__color;
}