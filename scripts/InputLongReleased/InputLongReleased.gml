// Feather disable all

/// Returns if a verb has been released but previously was held for longer than the specified
/// duration, measured in frames.
/// 
/// @param {Enum.INPUT_VERB,Real} verbIndex
/// @param {Real} [playerIndex=0]
/// @param {Real} [duration]

function InputLongReleased(_verbIndex, _playerIndex = 0, _duration = INPUT_LONG_DEFALT_DELAY)
{
    static _system      = __InputSystem();
    static _playerArray = __InputSystemPlayerArray();
    
    with(_playerArray[_playerIndex].__verbStateArray[_verbIndex])
    {
        return (__prevHeld && (not __held) && ((_system.__frame - __pressFrame) >= _duration));
    }
}