// Feather disable all

/// Registers a callback to be executed at a suitable time by the library. The callback type
/// should be a member of the INPUT_PLUG_IN_CALLBACK enum. The method that you specify will be
/// handed parameters, though what parameters specifically depends on the callback type:
///
/// .COLLECT: No parameters
///
/// .UPDATE: No parameters
///
/// .GAMEPAD_DISCONNECTED: Device index, Actually disconnected
/// 
/// .GAMEPAD_CONNECTED: Device index
/// 
/// .PLAYER_DEVICE_CHANGED: Player index, Old device index, New device index
/// 
/// .COLLECT_PLAYER: Player index
/// 
/// .UPDATE_PLAYER: Player index
/// 
/// .LOSE_FOCUS: No parameters
/// 
/// .GAIN_FOCUS: No parameters
/// 
/// You may also specify a callback priority. Because many callbacks can be registered to any
/// particular callback type, and because code order might matter in some situations, it is useful
/// to be able to control what order callbacks are executed. Native library code always has a
/// priority of 0 and plug-ins cannot use a priority of 0. Higher priorities are executed first.
/// 
/// @param {Enum.INPUT_PLUG_IN_CALLBACK,Real} callbackType
/// @param {Real} [priority=-1]
/// @param {Method} method

function InputPlugInRegisterCallback(_callbackType, _priority = -1, _method)
{
    if (_priority == 0)
    {
        __InputError("Cannot use priority 0 for plug-ins");
    }
    
    __InputPlugInRegisterCallbackInternal(_callbackType, _priority, _method);
}