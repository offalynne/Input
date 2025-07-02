// Feather disable all

/// Returns the y-position of the player's cursor in the coordinate space of your choosing. If no
/// coordinate space is provided then this function will use the coordinate space set by
/// `INPUT_CURSOR_PRIMARY_COORD_SPACE`.
/// 
/// @param [playerIndex=0]
/// @param [coordSpace]

function InputCursorY(_playerIndex = 0, _coordSpace = undefined)
{
    static _system      = __InputCursorSystem();
    static _playerArray = _system.__playerArray;
    
    __INPUT_VALIDATE_PLAYER_INDEX
    __INPUT_VALIDATE_CURSOR_CLUSTER
    
    with(_playerArray[_playerIndex])
    {
        return __InputCursorTransformCoordinate(__x, __y, INPUT_CURSOR_PRIMARY_COORD_SPACE, _coordSpace ?? INPUT_CURSOR_PRIMARY_COORD_SPACE).y;
    }
}