// Feather disable all

/// @param [playerIndex=0]
/// @param [coordSpace]

function InputCursorX(_playerIndex = 0, _coordSpace = undefined)
{
    static _playerArray = __InputCursorSystem().__playerArray;
    
    __INPUT_VALIDATE_PLAYER_INDEX
    
    return _playerArray[_playerIndex].__x;
}