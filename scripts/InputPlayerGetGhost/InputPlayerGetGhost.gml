// Feather disable all

/// Returns whether a player is set as a ghost by `InputPlayerSetGhost()`.
/// 
/// @param {Real} [playerIndex=0]

function InputPlayerGetGhost(_playerIndex = 0)
{
    static _playerArray = __InputSystemPlayerArray();
    
    __INPUT_VALIDATE_PLAYER_INDEX
    
    return _playerArray[_playerIndex].__ghost;
}