// Feather disable all

/// Limits the player's cursor within an axis-aligned bounding box. The coordinates of the bounding
/// box are in pixels in the primary coordinate space, `INPUT_CURSOR_PRIMARY_COORD_SPACE`.
/// 
/// @param left
/// @param top
/// @param right
/// @param bottom
/// @param [playerIndex=0]

function InputCursorLimitAABB(_left, _top, _right, _bottom, _playerIndex = 0)
{
    static _playerArray = __InputCursorSystem().__playerArray;
    
    __INPUT_VALIDATE_PLAYER_INDEX
    
    with(_playerArray[_playerIndex])
    {
        __limitType   = INPUT_CURSOR_LIMIT_AABB;
        __limitLeft   = _left;
        __limitTop    = _top;
        __limitRight  = _right;
        __limitBottom = _bottom;
        
        __Limit();
    }
}