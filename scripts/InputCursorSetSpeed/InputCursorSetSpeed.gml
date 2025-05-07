// Feather disable all

/// @param speed
/// @param [playerIndex=0]

function InputCursorSetSpeed(_speed, _playerIndex = 0)
{
    static _playerArray = __InputCursorSystem().__playerArray;
    
    __INPUT_VALIDATE_PLAYER_INDEX
    
    _playerArray[_playerIndex].__speed = _speed;
}