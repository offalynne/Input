// Feather disable all

/// Returns whether a player is inactive i.e. has not pressed a button on their device. The
/// `duration` parameter is measured in milliseconds and specifies the timeout duration.
/// 
/// @param {Real} [duration=500]
/// @param {Real} [playerIndex=0]

function InputPlayerGetInactive(_duration = 500, _playerIndex = 0)
{
    static _playerArray = __InputSystemPlayerArray();
    
    __INPUT_VALIDATE_PLAYER_INDEX
    
    return (current_time - _playerArray[_playerIndex].__lastInputTime > _duration);
}