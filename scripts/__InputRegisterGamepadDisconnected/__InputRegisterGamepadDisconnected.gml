// Feather disable all

function __InputRegisterGamepadDisconnected()
{
    __InputPlugInRegisterCallbackInternal(INPUT_PLUG_IN_CALLBACK.GAMEPAD_DISCONNECTED, 0, function(_device, _actuallyDisconnected)
    {
        static _gamepadArray = __gamepadArray;
        
        if (_gamepadArray[_device] != undefined)
        {
            if (_actuallyDisconnected)
            {
                __InputTrace("Gamepad ", _device, " disconnected");
                _gamepadArray[@ _device] = undefined;
            }
            else
            {
                __InputTrace("Gamepad ", _device, " blocked");
                _gamepadArray[_device].__blocked = true;
            }
        }
    });
}