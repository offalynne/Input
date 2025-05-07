// Feather disable all

/// Sets the position of the player's cursor in the global coordinate space, as set by
/// `INPUT_CURSOR_PRIMARY_COORD_SPACE`.
/// 
/// @param x
/// @param y
/// @param [playerIndex=0]
/// @param [relative=false]

function InputCursorSet(_x, _y, _playerIndex = 0, _relative = false)
{
    static _playerArray = __InputCursorSystem().__playerArray;
    
    __INPUT_VALIDATE_PLAYER_INDEX
    
    with(_playerArray[_playerIndex])
    {
        if (_relative)
        {
            __x += _x;
            __y += _y;
        }
        else
        {
            __x = _x;
            __y = _y;
        }
    }
}