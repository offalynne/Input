// Feather disable all

/// Returns the movement in the y-axis for the player's cursor in the coordinate space of your
/// choosing. If no coordinate space is provided then this function will use the coordinate space
/// `INPUT_CURSOR_PRIMARY_COORD_SPACE`.
/// 
/// @param [playerIndex=0]
/// @param [coordSpace]

function InputCursorDY(_playerIndex = 0, _coordSpace = undefined)
{
    static _system      = __InputCursorSystem();
    static _playerArray = _system.__playerArray;
    
    __INPUT_VALIDATE_PLAYER_INDEX
    __INPUT_VALIDATE_CURSOR_CLUSTER
    
    with(_playerArray[_playerIndex])
    {
        return __InputCursorTransformCoordinate(__x - __prevX, __y - __prevY, INPUT_CURSOR_PRIMARY_COORD_SPACE, _coordSpace ?? INPUT_CURSOR_PRIMARY_COORD_SPACE).y;
    }
}