// Feather disable all

/// Returns the movement in the x-axis for the player's cursor in the coordinate space of your
/// choosing. If no coordinate space is provided then this function will use the coordinate space
/// set by `InputCursorSetCoordSpace()` (which is room-space by default in turn).
/// 
/// @param [playerIndex=0]
/// @param [coordSpace]

function InputCursorDX(_playerIndex = 0, _coordSpace = undefined)
{
    static _system      = __InputCursorSystem();
    static _playerArray = _system.__playerArray;
    
    __INPUT_VALIDATE_PLAYER_INDEX
    
    with(_playerArray[_playerIndex])
    {
        return __InputCursorTransformCoordinate(__x - __prevX, __y - __prevY, _system.__coordSpace, _coordSpace ?? _system.__coordSpace).x;
    }
}