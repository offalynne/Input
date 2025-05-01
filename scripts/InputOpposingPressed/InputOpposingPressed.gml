// Feather disable all

/// Returns the sign of the result of the negative and positive verbs when pressed. This means this
/// function will only return `-1` or `+1` when a verb has been pressed during the previous update
/// loop. If `mostRecent` is set to `true` then the most recently pressed verb is preferenced,
/// otherwise `0` is returned if both verbs were pressed at the same time.
/// 
/// @param {Enum.INPUT_VERB,Real} verbNegative
/// @param {Enum.INPUT_VERB,Real} verbPositive
/// @param {Real} [playerIndex=0]
/// @param {Real} [mostRecent]

function InputOpposingPressed(_verbNeg, _verbPos, _playerIndex = 0, _mostRecent = INPUT_OPPOSING_DEFAULT_MOST_RECENT)
{
    __INPUT_VALIDATE_PLAYER_INDEX
    
    var _pressedNeg = InputPressed(_verbNeg, _playerIndex);
    var _pressedPos = InputPressed(_verbPos, _playerIndex);

    if (_mostRecent)
    {
        var _value = 0;
        
        if (_pressedPos) _value++;
        if (_pressedNeg) _value--;
        
        return _value;
    }
    else
    {
        if (!_pressedNeg && !_pressedPos) return 0;
        
        if (_pressedPos && (not InputCheck(_verbNeg, _playerIndex))) return  1;
        if (_pressedNeg && (not InputCheck(_verbNeg, _playerIndex))) return -1;
        
        return 0;
    }
}
