// Feather disable all

/// Returns if a verb is newly considered a "long hold" based on the hold duration, measured in
/// frames.
/// 
/// @param {Enum.INPUT_VERB,Real} verbIndex
/// @param {Real} [playerIndex=0]
/// @param {Real} [duration]

function InputLongPressed(_verbIndex, _playerIndex = 0, _duration = INPUT_LONG_DEFAULT_DELAY)
{
    static _system      = __InputSystem();
    static _playerArray = __InputSystemPlayerArray();
    
    __INPUT_VALIDATE_PLAYER_INDEX
    
    with(_playerArray[_playerIndex].__verbStateArray[_verbIndex])
    {
        return (__held && ((_system.__frame - __pressFrame) == _duration));
    }
}