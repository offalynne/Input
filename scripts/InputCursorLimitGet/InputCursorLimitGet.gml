// Feather disable all

/// Returns the parameters of the limit placed on a player's cursor as a struct. The struct
/// contains the following member variables:
/// 
/// - `.type`
/// - `.x`
/// - `.y`
/// - `.radius`
/// - `.left`
/// - `.top`
/// - `.right`
/// - `.bottom`
/// - `.margin`
/// 
/// @param [playerIndex=0]

function InputCursorLimitGet(_playerIndex = 0)
{
    static _playerArray = __InputCursorSystem().__playerArray;
    
    __INPUT_VALIDATE_PLAYER_INDEX
    
    static _result = {
        type:   INPUT_CURSOR_LIMIT_NONE,
        x:      0,
        y:      0,
        radius: 0,
        left:   0,
        top:    0,
        right:  0,
        bottom: 0,
        margin: 0,
    };
    
    with(_playerArray[_playerIndex])
    {
        if (__limitType == INPUT_CURSOR_LIMIT_CIRCLE)
        {
            _result.type   = INPUT_CURSOR_LIMIT_CIRCLE;
            _result.x      = __limitX;
            _result.y      = __limitY;
            _result.radius = __limitRadius;
            _result.left   = undefined;
            _result.top    = undefined;
            _result.right  = undefined;
            _result.bottom = undefined;
            _result.margin = undefined;
        }
        else if (__limitType == INPUT_CURSOR_LIMIT_BOUNDARY)
        {
            _result.type   = INPUT_CURSOR_LIMIT_BOUNDARY;
            _result.x      = undefined;
            _result.y      = undefined;
            _result.radius = undefined;
            _result.left   = undefined;
            _result.top    = undefined;
            _result.right  = undefined;
            _result.bottom = undefined;
            _result.margin = __limitMargin;
        }
        else if (__limitType == INPUT_CURSOR_LIMIT_AABB)
        {
            _result.type   = INPUT_CURSOR_LIMIT_AABB;
            _result.x      = undefined;
            _result.y      = undefined;
            _result.radius = undefined;
            _result.left   = __limitLeft;
            _result.top    = __limitTop;
            _result.right  = __limitRight;
            _result.bottom = __limitBottom;
            _result.margin = undefined;
        }
        else //if (__limitType == INPUT_CURSOR_LIMIT_NONE)
        {
            _result.type   = INPUT_CURSOR_LIMIT_NONE;
            _result.x      = undefined;
            _result.y      = undefined;
            _result.radius = undefined;
            _result.left   = undefined;
            _result.top    = undefined;
            _result.right  = undefined;
            _result.bottom = undefined;
            _result.margin = undefined;
        }
    }
    
    return _result;
}