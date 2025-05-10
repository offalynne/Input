// Feather disable all

/// Limits the player's cursor inside the visible portion of the game window. You may also specify
/// a margin around the edge of the game window, measured in pixels (in the primary coordinate
/// space).
/// 
/// @param [margin=0]
/// @param [playerIndex=0]

function InputCursorLimitBoundary(_margin = 0, _playerIndex = 0)
{
    static _playerArray = __InputCursorSystem().__playerArray;
    
    __INPUT_VALIDATE_PLAYER_INDEX
    
    with(_playerArray[_playerIndex])
    {
        __limitType   = INPUT_CURSOR_LIMIT_BOUNDARY;
        __limitMargin = _margin;
        
        __Limit();
    }
}