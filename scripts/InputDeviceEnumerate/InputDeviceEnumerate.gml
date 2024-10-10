// Feather disable all

/// Returns an array of all valid devices that can be used on the platform. If `includeGenericDevice`
/// is set to `true` then `INPUT_GENERIC_DEVICE` will be included in the returned array,
/// otherwise `INPUT_GENERIC_DEVICE` will be ignored.
/// 
/// @param {Bool} [includeGenericDevice=false]

function InputDeviceEnumerate(_includeGenericDevice = false)
{
    static _system = __InputSystem();
    static _array  = [];
    
    array_resize(_array, 0);
    
    if (not INPUT_BAN_GAMEPADS)
    {
        var _gamepadCount = gamepad_get_device_count();
        
        if ((not INPUT_ON_WEB) && (INPUT_ON_MACOS || ((not _system.__usingSteamworks) && INPUT_ON_WINDOWS) || (_system.__usingSteamworks && INPUT_ON_LINUX)))
        {
            //Search last-to-first on platforms with low-index virtual controllers (Steam Input, ViGEm)
            //We want real devices to take priority over virtual ones where possible to avoid thrashing
            var _sortOrder = -1;
            var _device = _gamepadCount - 1;
        }
        else
        {
            var _sortOrder = 1;
            var _device = 0;
        }
        
        repeat(_gamepadCount)
        {
            if (InputDeviceIsConnected(_device)) array_push(_array, _device);
            _device += _sortOrder;
        }
    }
    
    if (not INPUT_BAN_KBM) array_push(_array, INPUT_KBM);
    if (not INPUT_BAN_TOUCH) array_push(_array, INPUT_TOUCH);
    if (_includeGenericDevice) array_push(_array, INPUT_GENERIC_DEVICE);
    
    return _array;
}