// Feather disable all

/// Returns whether the verb is "active" i.e. a button is being held down, an analogue stick has
/// been moved etc.  This is a boolean `true` or `false` state; to return an analogue value please
/// use `InputValue()`.
/// 
/// @param {Enum.INPUT_VERB,Real} verbIndex
/// @param {Real} [playerIndex=0]

function InputCheck(_verbIndex, _playerIndex = 0)
{
    static _playerArray = __InputSystemPlayerArray();
    
    __INPUT_VALIDATE_PLAYER_INDEX
    
    return _playerArray[_playerIndex].__verbStateArray[_verbIndex].__held;
}