// Feather disable all

/// Returns how many frames have elapsed since the verb was last pressed. This function will return
/// `0` on the first frame that the verb was pressed. This function will continue to return values
/// even when the verb is not active.
/// 
/// @param {Enum.INPUT_VERB,Real} verbIndex
/// @param {Real} [playerIndex=0]

function InputDuration(_verbIndex, _playerIndex = 0)
{
    static _system      = __InputSystem();
    static _playerArray = __InputSystemPlayerArray();
    
    __INPUT_VALIDATE_PLAYER_INDEX
    
    with(_playerArray[_playerIndex].__verbStateArray[_verbIndex])
    {
        return (_system.__frame - __pressFrame);
    }
}