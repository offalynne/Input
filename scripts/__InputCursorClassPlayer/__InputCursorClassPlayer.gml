// Feather disable all

/// @param playerIndex

function __InputCursorClassPlayer(_playerIndex) constructor
{
    __playerIndex = _playerIndex;
    
    __speed = __INPUT_CURSOR_DEFAULT_SPEED;
    
    __x  = 0;
    __y  = 0;
    __dX = 0;
    __dY = 0;
    
    static __Update = function()
    {
        var _nextX = __x;
        var _nextY = __y;
        var _playerIndex = __playerIndex;
        
        var _useCluster = false;
        
        if (InputPlayerUsingKbm(_playerIndex))
        {
            if (not INPUT_CURSOR_MOUSE_CONTROL)
            {
                _useCluster = true;
            }
            else
            {
                _nextX = InputMouseRoomX();
                _nextY = InputMouseRoomY();
            }
        }
        else if (InputPlayerUsingGamepad(_playerIndex))
        {
            _useCluster = true;
        }
        
        if (_useCluster)
        {
            _nextX += __speed*InputX(INPUT_CURSOR_CLUSTER, _playerIndex);
            _nextY += __speed*InputY(INPUT_CURSOR_CLUSTER, _playerIndex);
        }
        
        __dX = _nextX - __x;
        __dY = _nextY - __y;
        
        __x = _nextX;
        __y = _nextY;
    }
}