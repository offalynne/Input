// Feather disable all

/// Returns the total number of connected players.

function InputPlayerConnectedCount()
{
    static _playerArray = __InputSystemPlayerArray();
    
    var _count = 0;
    
    var _i = 0;
    repeat(INPUT_MAX_PLAYERS)
    {
        var _status = _playerArray[_i].__status;
        if ((_status == INPUT_PLAYER_STATUS.NEWLY_CONNECTED) || (_status == INPUT_PLAYER_STATUS.CONNECTED))
        {
            ++_count;
        }
        
        ++_i;
    }
    
    return _count;
}