// Feather disable all

/// @param {Real} device
/// @param {Constant.GamepadButton} gpConstant
/// @param {Method} method

function InputPlugInGamepadSetMapping(_device, _gpConstant, _method)
{
    var _readArray = __InputGamepadGetReadArray(_device);
    if (_readArray == undefined) return;
    
    _readArray[@ _gpConstant - INPUT_GAMEPAD_BINDING_MIN] = _method;
}