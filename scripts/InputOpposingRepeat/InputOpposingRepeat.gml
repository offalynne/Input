// Feather disable all

/// Returns the sign of the result of the negative and positive active verbs on a repeating pulse.
/// This function will return `0` between pulses and `-1` or `+1` on the pulse. If both verbs are
/// active, this function will return `0`. The `delay` and `predelay` parameters are measured in
/// frames.
/// 
/// @param {Enum.INPUT_VERB,Real} verbNegative
/// @param {Enum.INPUT_VERB,Real} verbPositive
/// @param {Real} [playerIndex=0]
/// @param {Real} [delay]
/// @param {Real} [predelay]

function InputOpposingRepeat(_verbNeg, _verbPos, _playerIndex = 0, _delay = INPUT_REPEAT_DEFAULT_DELAY, _predelay = INPUT_REPEAT_DEFAULT_PREDELAY)
{
    __INPUT_VALIDATE_PLAYER_INDEX
    
    if (InputCheck(_verbNeg, _playerIndex))
    {
        if (InputCheck(_verbPos, _playerIndex)) return 0;
        
        return -1*InputRepeat(_verbNeg, _playerIndex, _delay, _predelay);
    }
    else if (InputCheck(_verbPos, _playerIndex))
    {
        return InputRepeat(_verbPos, _playerIndex, _delay, _predelay);
    }
    
    return 0;
}
