// Feather disable all

/// Returns a repeating boolean pulse whilst a verb is active. This is useful for rapidly scrolling
/// through longs menu when using digital input. The `delay` and `predelay` parameters are measured
/// in frames.
/// 
/// @param {Enum.INPUT_VERB,Real} verbIndex
/// @param {Real} [playerIndex=0]
/// @param {Real} [delay]
/// @param {Real} [predelay]

function InputRepeat(_verbIndex, _playerIndex = 0, _delay = INPUT_REPEAT_DEFAULT_DELAY, _predelay = INPUT_REPEAT_DEFAULT_PREDELAY)
{
    static _system      = __InputSystem();
    static _playerArray = __InputSystemPlayerArray();
    
    __INPUT_VALIDATE_PLAYER_INDEX
    
    with(_playerArray[_playerIndex].__verbStateArray[_verbIndex])
    {
        if (not __held) return false;
        
        var _time = _system.__frame - __pressFrame;
        if (_time == 0) return true;
        
        _time -= _predelay;
        if (_time < 0) return false;
        
        return (floor(_time / _delay) > floor((_time - 1) / _delay));
    }
}
