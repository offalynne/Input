// Feather disable all

/// Sets the color of a player's gamepad. If the player disconnects and reconnects a gamepad
/// (including changing gamepad) then the select color will be applied to their new gamepad.
/// 
/// @param {Constant.Colour} color
/// @param {Real} [playerIndex=0]

function InputColorSet(_color, _playerIndex = 0)
{
     static _playerArray = __InputColorSystem().__playerArray;
    
    __INPUT_VALIDATE_PLAYER_INDEX
     
     _playerArray[_playerIndex].__SetColor(_color);
}