// Feather disable all

/// Limits the player's cursor within a circle. The coordinates of the circle are in pixels in the
/// primary coordinate space, `INPUT_CURSOR_PRIMARY_COORD_SPACE`.
/// 
/// @param x
/// @param y
/// @param radisu
/// @param [playerIndex=0]

function InputCursorLimitCircle(_x, _y, _radius, _playerIndex = 0)
{
    static _playerArray = __InputCursorSystem().__playerArray;
    
    __INPUT_VALIDATE_PLAYER_INDEX
    
    with(_playerArray[_playerIndex])
    {
        __limitType   = INPUT_CURSOR_LIMIT_CIRCLE;
        __limitX      = _x;
        __limitY      = _y;
        __limitRadius = _radius;
        
        __Limit();
    }
}