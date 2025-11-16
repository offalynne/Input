// Feather disable all

/// Returns the current vibration magnitude set for a player's gamepad. If the player is not using
/// a gamepad, the gamepad is disconnected, or vibration is not supported on the gamepad then this
/// function will return `0`.
/// 
/// Please note that the returned value is based on the average vibration magnitude of the left and
/// right motor magnitudes and, due to the physical hardware, the returned value may not correspond
/// precisely to the vibration being felt at the time.
/// 
/// @param {Real} [playedIndex=0]

function InputVibrateGetMagnitude(_playerIndex = 0)
{
    static _deviceMap = __InputVibrateSystem().__deviceMap;
    
    __INPUT_VALIDATE_PLAYER_INDEX
    
    if (InputPlayerIsConnected(_playerIndex) && InputPlayerUsingGamepad(_playerIndex))
    {
        with(_deviceMap[? InputPlayerGetDevice(_playerIndex)])
        {
            return __supported? 0.5*(__left + __right) : 0;
        }
    }
    
    return 0;
}