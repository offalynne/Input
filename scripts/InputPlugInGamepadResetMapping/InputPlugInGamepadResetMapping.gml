// Feather disable all

/// @param {Real} device
/// @param {Constant.GamepadButton} gpConstant

function InputPlugInGamepadResetMapping(_device, _gpConstant)
{
    static _genericReadArray = __InputSystem().__genericReadArray;
    
    var _readArray = __InputGamepadGetReadArray(_device);
    if (_readArray == undefined) return;
    
    _readArray[@ _gpConstant - INPUT_GAMEPAD_BINDING_MIN] = variable_clone(_genericReadArray[_gpConstant - INPUT_GAMEPAD_BINDING_MIN]);
}