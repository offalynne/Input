// Feather disable all

/// @param {Real} device
/// @param {Real} type

function InputPlugInGamepadSetType(_device, _type)
{
    static _gamepadArray     = __InputSystem().__gamepadArray;
    static _genericReadArray = __InputSystem().__genericReadArray;
    
    if ((_device < 0) || (_device >= array_length(_gamepadArray))) return;
    
    var _deviceStruct = _gamepadArray[_device];
    if (_deviceStruct == undefined) return; //Device doesn't exist
    
    _deviceStruct.__type = _type;
}