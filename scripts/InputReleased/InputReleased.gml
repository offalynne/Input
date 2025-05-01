// Feather disable all

/// Returns whether a verb has been newly deactivated in the most recent update loop.
/// 
/// @param {Enum.INPUT_VERB,Real} verb
/// @param {Real} [playerIndex=0]

function InputReleased(_verb, _playerIndex = 0)
{
    static _playerArray = __InputSystemPlayerArray();
    
    __INPUT_VALIDATE_PLAYER_INDEX
    
    with(_playerArray[_playerIndex].__verbStateArray[_verb])
    {
        return (__prevHeld && (not __held));
    }
}