// Feather disable all

/// Returns whether the player has their input set as blocked.
/// 
/// @param {Real} [playerIndex=0]

function InputPlayerGetBlocked(_playerIndex = 0)
{
    static _playerArray = __InputSystemPlayerArray();
    return _playerArray[_playerIndex].__blocked;
}