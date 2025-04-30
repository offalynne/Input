// Feather disable all

/// @param {Real} device
/// @param {Constant.GamepadButton} gpConstant

function InputPlugInGamepadNullifyMapping(_device, _gpConstant)
{
    var _readArray = __InputGamepadGetReadArray(_device);
    if (_readArray == undefined) return;
    
    _readArray[@ _gpConstant - INPUT_GAMEPAD_BINDING_MIN] = function() { return 0 };
}