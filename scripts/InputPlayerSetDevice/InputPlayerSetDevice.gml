// Feather disable all

/// Sets the device for a player. This can be one of the following:
/// - `INPUT_NO_DEVICE`
/// - `INPUT_GENERIC_DEVICE`
/// - `INPUT_KBM`
/// - `INPUT_TOUCH`
/// - A native GameMaker gamepad index
/// 
/// A "generic device" is intended for use with plug-ins. Generic devices will not collect any
/// player input themselves and `InputPlugInVerbSet()` or `InputPlugInVerbStateRead()` should
/// be used to set verb state instead.
/// 
/// @param {Real} device
/// @param {Real} [playerIndex=0]

function InputPlayerSetDevice(_device, _playerIndex = 0)
{
    static _system = __InputSystem();
    static _playerArray = __InputSystemPlayerArray();
    
    __INPUT_VALIDATE_PLAYER_INDEX
    
    if (_system.__hotswap)
    {
        if ((_playerIndex != 0) && (_device != INPUT_NO_DEVICE))
        {
            __InputError($"Cannot set player {_playerIndex} device to {_device}, hotswap mode is enabled");
        }
    }
    
    if (INPUT_ON_PS5 && INPUT_PS5_SINGLE_USER)
    {
        if ((_device != INPUT_NO_DEVICE) && (_device != INPUT_GENERIC_DEVICE) && (_device != 0))
        {
            //Player 0 must have no device or device 0 (or a generic device if the developer is doing something custom)
            __InputTrace($"Warning! Cannot set device {_device} for player 0 due to `INPUT_PS5_SINGLE_USER`");
            return;
        }
        else if ((_playerIndex != 0) && (_device != INPUT_NO_DEVICE))
        {
            //No other players can have a device
            _device = INPUT_NO_DEVICE;
            __InputTrace($"Warning! Player {_playerIndex} cannot have a device due to `INPUT_PS5_SINGLE_USER`");
        }
    }
    
    var _oldDevice = _playerArray[_playerIndex].__device;
    
    //Don't do any work if the device hasn't changed
    if (_oldDevice == _device) return;
    
    __InputPlugInExecuteCallbacks(INPUT_PLUG_IN_CALLBACK.PLAYER_DEVICE_CHANGED, _playerIndex, _oldDevice, _device);
}