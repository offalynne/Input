// Feather disable all

/// Returns whether the player has their input set as blocked.
/// 
/// @param {Real} [playerIndex=0]

function InputPlayerGetBlocked(_playerIndex = 0)
{
    static _playerArray = __InputSystemPlayerArray();
    
    __INPUT_VALIDATE_PLAYER_INDEX
    
    return _playerArray[_playerIndex].__blocked;
}