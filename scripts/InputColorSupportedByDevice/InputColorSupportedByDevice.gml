// Feather disable all

/// Returns whether a player's device color will *probably* reflect the color set for the player.
/// This can only ever be approximate as many factors influence whether color changing on a gamepad
/// will work properly.
/// 
/// @param {Real} [playerIndex=0]

function InputColorSupportedByDevice(_playerIndex = 0)
{
     static _playerArray = __InputColorSystem().__playerArray;
    
    __INPUT_VALIDATE_PLAYER_INDEX
     
     return _playerArray[_playerIndex].__SupportedByDevice();
}