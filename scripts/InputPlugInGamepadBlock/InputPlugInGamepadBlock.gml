// Feather disable all

/// Forces a gamepad to be blocked. This is helpful for plug-ins that are designed to filter out
/// bad or unwanted gamepads. Calling this function will execute the `.GAMEPAD_DISCONNECTED`
/// callback with the second parameter set to `false`.
/// 
/// @param {Real} device

function InputPlugInGamepadBlock(_device)
{
    if (_device < 0)
    {
        __InputError("Cannot block device ", _device, " (can only block gamepads)");
    }
    
    if (InputDeviceIsConnected(_device))
    {
        __InputPlugInExecuteCallbacks(INPUT_PLUG_IN_CALLBACK.GAMEPAD_DISCONNECTED, _device, false);
    }
}