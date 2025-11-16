// Feather disable all

/// Returns whether vibration is *probably* supported for the device assigned to a player. This
/// can only ever be approximate as many factors influence whether vibration will work properly.
/// 
/// @param {Real} [playedIndex=0]

function InputVibrateGetSupported(_playerIndex = 0)
{
    static _deviceMap = __InputVibrateSystem().__deviceMap;
    
    if (InputPlayerIsConnected(_playerIndex) && InputPlayerUsingGamepad(_playerIndex))
    {
        with(_deviceMap[? InputPlayerGetDevice(_playerIndex)])
        {
            return __supported;
        }
    }
    
    return false;
}