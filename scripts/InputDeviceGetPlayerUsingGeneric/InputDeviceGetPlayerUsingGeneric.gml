// Feather disable all

/// Returns the index of the first player that has been assigned a generic device. If no such
/// player can be found then this function returns `undefined`.

function InputDeviceGetPlayerUsingGeneric()
{
    static _playerArray = __InputSystemPlayerArray();
    
    var _playerIndex = 0;
    repeat(INPUT_MAX_PLAYERS)
    {
        if (_playerArray[_playerIndex].__device == INPUT_GENERIC_DEVICE)
        {
            return _playerIndex;
        }
        
        ++_playerIndex;
    }
    
    return undefined;
}