// Feather disable all

/// Sets the hotswapping state. If set to `true` then all players other than player 0 will have
/// their device set to `INPUT_NO_DEVICE`. When hotswap is enabled, the library will wait until
/// player 0's current device reports that has been inactive for a short period of time. Once
/// player 0's device is inactive then the library will search for activity on any other connected
/// device. If activity is found then that device will be assigned the player 0.
/// 
/// You may specify a function to call when a hotswap occurs by calling `InputSetHotswapCallback()`.
/// 
/// N.B. Hotswap is not available on mobile devices.
/// 
/// @param {Bool} state

function InputSetHotswap(_state)
{
    static _system = __InputSystem();
    
    if (INPUT_BAN_HOTSWAP) return;
    
    with(_system)
    {
        if (_state == __hotswap) return;
        
        if (_state)
        {
            __hotswap = true;
            
            var _i = 1;
            repeat(INPUT_MAX_PLAYERS-1)
            {
                InputPlayerSetDevice(INPUT_NO_DEVICE, _i);
                ++_i;
            }
        }
        else
        {
            __hotswap = false;
        }
    }
}