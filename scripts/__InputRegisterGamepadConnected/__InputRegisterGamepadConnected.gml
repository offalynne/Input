// Feather disable all

function __InputRegisterGamepadConnected()
{
    __InputPlugInRegisterCallbackInternal(INPUT_PLUG_IN_CALLBACK.GAMEPAD_CONNECTED, 0, function(_device)
    {
        static _gamepadArray = __gamepadArray;
        
        __InputTrace("Gamepad ", _device, " connected");
        
        var _gamepad = new __InputClassGamepad(_device);
        _gamepadArray[@ _device] = _gamepad;
        
        __InputGamepadDiscover(_gamepad);
    });
}