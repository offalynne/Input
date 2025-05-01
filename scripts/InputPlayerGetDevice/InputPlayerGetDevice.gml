// Feather disable all

/// Returns the device assigned to a player. This can be one of the following:
/// - `INPUT_NO_DEVICE`
/// - `INPUT_GENERIC_DEVICE`
/// - `INPUT_KBM`
/// - `INPUT_TOUCH`
/// - A native GameMaker gamepad index
/// 
/// @param {Real} [playerIndex=0]

function InputPlayerGetDevice(_playerIndex = 0)
{
    static _playerArray = __InputSystemPlayerArray();
    
    __INPUT_VALIDATE_PLAYER_INDEX
    
    return _playerArray[_playerIndex].__device;
}