// Feather disable all

/// Returns whether a player has been assigned INPUT_KBM as their device.
/// 
/// @param {Real} [playerIndex=0]

function InputPlayerUsingKbm(_playerIndex = 0)
{
    static _playerArray = __InputSystemPlayerArray();
    
    __INPUT_VALIDATE_PLAYER_INDEX
    
    return (_playerArray[_playerIndex].__device == INPUT_KBM);
}