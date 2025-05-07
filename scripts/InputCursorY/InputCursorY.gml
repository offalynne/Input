// Feather disable all

/// Returns the y-position of the player's cursor in the coordinate space of your choosing. If no
/// coordinate space is provided then this function will use the coordinate space set by
/// `InputCursorSetCoordSpace()` (which is room-space by default in turn).
/// 
/// @param [playerIndex=0]
/// @param [coordSpace]

function InputCursorY(_playerIndex = 0, _coordSpace = undefined)
{
    static _system      = __InputCursorSystem();
    static _playerArray = _system.__playerArray;
    
    __INPUT_VALIDATE_PLAYER_INDEX
    
    with(_playerArray[_playerIndex])
    {
        return __InputCursorTransformCoordinate(__x, __y, _system.__coordSpace, _coordSpace ?? _system.__coordSpace).y;
    }
}