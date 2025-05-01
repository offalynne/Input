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
    static _playerArray = __InputSystemPlayerArray();
    
    __INPUT_VALIDATE_PLAYER_INDEX
    
    var _oldDevice = _playerArray[_playerIndex].__device;
    
    //Don't do any work if the device hasn't changed
    if (_oldDevice == _device) return;
    
    __InputPlugInExecuteCallbacks(INPUT_PLUG_IN_CALLBACK.PLAYER_DEVICE_CHANGED, _playerIndex, _oldDevice, _device);
}