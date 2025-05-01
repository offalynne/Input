// Feather disable all

/// "Consumes" a verb, causing it to be immediately deactivated and return a value of zero until
/// the verb is retriggered (e.g. by released a keyboard key and pressed it again). This helpful
/// when navigating menus to prevent multiple inputs.
/// 
/// @param {Enum.INPUT_VERB,Real} verbIndex
/// @param {Real} [playerIndex=0]

function InputVerbConsume(_verbIndex, _playerIndex = 0)
{
    static _playerArray = __InputSystemPlayerArray();
    
    __INPUT_VALIDATE_PLAYER_INDEX
    
    with(_playerArray[_playerIndex])
    {
        if (array_get_index(__consumedArray, __verbStateArray[_verbIndex]) < 0)
        {
            array_push(__consumedArray, __verbStateArray[_verbIndex]);
        }
        
        with(__verbStateArray[_verbIndex])
        {
            __prevHeld   = false;
            __held       = false;
            __valueRaw   = 0;
            __valueClamp = 0;
            __pressFrame = -infinity;
        }
    }
}