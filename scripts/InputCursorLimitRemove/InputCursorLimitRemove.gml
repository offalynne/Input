// Feather disable all

/// Removes any limits placed on a player's cursor.
/// 
/// @param [playerIndex=0]

function InputCursorLimitRemove(_playerIndex = 0)
{
    static _playerArray = __InputCursorSystem().__playerArray;
    
    __INPUT_VALIDATE_PLAYER_INDEX
    
    with(_playerArray[_playerIndex])
    {
        __limitType = INPUT_CURSOR_LIMIT_NONE;
    }
}