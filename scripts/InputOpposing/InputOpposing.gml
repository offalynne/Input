// Feather disable all

/// Returns the sign of the result of the negative and positive active verbs. If `mostRecent` is
/// set to `true` then the most recently pressed verb is preferenced, otherwise `0` is returned if
/// both verbs are active.
/// 
/// @param {Enum.INPUT_VERB,Real} verbNegative
/// @param {Enum.INPUT_VERB,Real} verbPositive
/// @param {Real} [playerIndex=0]
/// @param {Real} [mostRecent]

function InputOpposing(_verbNeg, _verbPos, _playerIndex = 0, _mostRecent = INPUT_OPPOSING_DEFAULT_MOST_RECENT)
{
    static _playerArray = __InputSystemPlayerArray();
    
    __INPUT_VALIDATE_PLAYER_INDEX
    
    var _heldNeg = InputCheck(_verbNeg, _playerIndex);
    var _heldPos = InputCheck(_verbPos, _playerIndex);
    
    //Neither
    if ((not _heldNeg) && (not _heldPos)) return 0;
    
    //Both
    if (_heldNeg && _heldPos && (not _mostRecent)) return 0;
        
    //Exclusive
    if (not _heldPos) return (_heldNeg? -1 : 0);
    if (not _heldNeg) return (_heldPos?  1 : 0);
    
    with(_playerArray[_playerIndex])
    {
        //Grab player verb struct
        var _verbStructNeg = __verbStateArray[_verbNeg];
        var _verbStructPos = __verbStateArray[_verbPos];
        
        //Most recent
        if (_verbStructNeg.__pressFrame > _verbStructPos.__pressFrame)
        {
            return (_heldNeg? -1 : 0);
        }
        else
        {
            return (_heldPos? 1 : 0);
        }
    }
    
    __InputError("Opposing check unhandled");
}
