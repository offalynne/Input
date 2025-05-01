// Feather disable all

/// Returns the most recently pressed verb that is still active from among the array of verbs
/// provided. If no verb array is provided (or the value `-1` is used in place of an array), all
/// defined verbs will be checked instead. If no verb in the array is active, this function returns
/// `undefined`.
/// 
/// @param {Enum.INPUT_VERB,Real,Array} [verbIndexArray=all]
/// @param {Real} [playerIndex=0]

function InputMostRecent(_verbIndexArray = -1, _playerIndex = 0)
{
    static _system            = __InputSystem();
    static _playerArray       = __InputSystemPlayerArray();
    static _verbDefIndexArray = _system.__verbDefIndexArray;
    
    __INPUT_VALIDATE_PLAYER_INDEX
    
    //Convert `-1` to the array of all verb definitions
    if (is_numeric(_verbIndexArray) && (_verbIndexArray == -1))
    {
        _verbIndexArray = _verbDefIndexArray;
    }
    
    with(_playerArray[_playerIndex])
    {
        var _maxTime = -1;
        var _maxVerb = undefined;
        
        var _i = 0;
        repeat(array_length(_verbDefIndexArray))
        {
            var _verbIndex = _verbDefIndexArray[_i];
            
            var _verbState = __verbStateArray[_verbIndex];
            if (_verbState.__held && (_verbState.__pressFrame > _maxTime))
            {
                _maxTime = _verbState.__pressFrame;
                _maxVerb = _verbIndex;
            }
            
            ++_i;
        }
        
        return _maxVerb;
    }
}