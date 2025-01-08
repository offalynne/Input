// Feather disable all

/// Returns the index of the first player that has been assigned a gamepad as their device. If no
/// such player can be found then this function returns `undefined`. If the optional parameter
/// `ignoreDisconnected` is set to `true` (the default) then players who are been assigned a
/// gamepad will be ignored if that gamepad is disconnected. If this parameter is set to `false` 
/// then players with an assigned but disconnected device may be returned.
/// 
/// @param {Bool} [ignoreDisconnected=true]

function InputDeviceGetPlayerUsingGamepad(_ignoreDisconnected = true)
{
    static _playerArray = __InputSystemPlayerArray();
    
    var _playerIndex = 0;
    repeat(INPUT_MAX_PLAYERS)
    {
        if (((not _ignoreDisconnected) || InputPlayerIsConnected(_playerIndex)) && InputDeviceIsGamepad(_playerArray[_playerIndex].__device))
        {
            return _playerIndex;
        }
        
        ++_playerIndex;
    }
    
    return undefined;
}