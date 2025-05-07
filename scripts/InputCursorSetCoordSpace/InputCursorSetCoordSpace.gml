// Feather disable all

/// Sets the global coordinate space. The provided coordinates space should be one of the
/// `INPUT_CURSOR_*_SPACE` macros:
/// 
/// - `INPUT_CURSOR_ROOM_SPACE`
/// - `INPUT_CURSOR_GUI_SPACE`
/// - `INPUT_CURSOR_DEVICE_SPACE`
/// 
/// @param coordSpace

function InputCursorSetCoordSpace(_newCoordSpace)
{
    static _system = __InputCursorSystem();
    static _playerArray = _system.__playerArray;
    
    if (_system.__coordSpace == _coordSpace) return;
    
    var _oldCoordSpace = _system.__coordSpace;
    _system.__coordSpace = _newCoordSpace;
    
    var _i = 0;
    repeat(INPUT_MAX_PLAYERS)
    {
        with(_playerArray[_i])
        {
            var _result = __InputCursorTransformCoordinate(__x, __y, _oldCoordSpace, _newCoordSpace);
            __x = _result.x;
            __y = _result.y;
            
            var _result = __InputCursorTransformCoordinate(__prevX, __prevY, _oldCoordSpace, _newCoordSpace);
            __prevX = _result.x;
            __prevY = _result.y;
        }
        
        ++_i;
    }
}