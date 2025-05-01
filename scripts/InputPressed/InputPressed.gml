// Feather disable all

/// Returns whether a verb has been newly actived in the most recent update loop.
/// 
/// @param {Enum.INPUT_VERB,Real} verb
/// @param {Real} [playerIndex=0]

function InputPressed(_verb, _playerIndex = 0)
{
    static _playerArray = __InputSystemPlayerArray();
    
    __INPUT_VALIDATE_PLAYER_INDEX
    
    with(_playerArray[_playerIndex].__verbStateArray[_verb])
    {
        return ((not __prevHeld) && __held);
    }
}