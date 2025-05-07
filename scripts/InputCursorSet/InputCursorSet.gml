// Feather disable all

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