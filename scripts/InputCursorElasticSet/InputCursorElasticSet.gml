// Feather disable all

/// @param x
/// @param y
/// @param strength
/// @param [playerIndex=0]
/// @param [moveCursor=true[

function InputCursorElasticSet(_x, _y, _strength, _playerIndex = 0, _moveCursor = true)
{
    static _playerArray = __InputCursorSystem().__playerArray;
    
    __INPUT_VALIDATE_PLAYER_INDEX
    
    with(_playerArray[_playerIndex])
    {
        if (_moveCursor && (__elasticX != undefined) && (__elasticY != undefined))
        {
            __x += __elasticX - _x;
            __y += __elasticY - _y;
        }
        
        __elasticX        = _x;
        __elasticY        = _y;
        __elasticStrength = _strength;
    }
}