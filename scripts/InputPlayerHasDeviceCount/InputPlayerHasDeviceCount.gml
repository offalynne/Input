// Feather disable all

/// Returns the total number of players who have a device set (i.e. not INPUT_NO_DEVICE). This
/// is **not** the same as counting the number of connected players as a player might have been
/// assigned a device but that device is no longer connected.

function InputPlayerHasDeviceCount()
{
    static _playerArray = __InputSystemPlayerArray();
    
    var _count = 0;
    
    var _i = 0;
    repeat(INPUT_MAX_PLAYERS)
    {
        _count += (_playerArray[_i].__device != INPUT_NO_DEVICE);
        ++_i;
    }
    
    return _count;
}