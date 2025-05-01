// Feather disable all

/// Returns the analogue value of a verb i.e. how far a trigger has been depressed, how far a
/// thumbstick has been moved. A button will return either `0` or `1`.
/// 
/// @param {Enum.INPUT_VERB,Real} verb
/// @param {Real} [playerIndex=0]

function InputValue(_verb, _playerIndex = 0)
{
    static _playerArray = __InputSystemPlayerArray();
    
    __INPUT_VALIDATE_PLAYER_INDEX
    
    return _playerArray[_playerIndex].__verbStateArray[_verb].__valueClamp;
}