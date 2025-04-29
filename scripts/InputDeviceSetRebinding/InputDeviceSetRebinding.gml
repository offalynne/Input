// Feather disable all

/// Sets rebinding state for a device. The device will be scanned for all input. Discovered
/// bindings can be returned by calling `InputDeviceGetRebindingResult()`. Only gamepads and
/// keyboard and mouse (`INPUT_KBM`) devices can be scanned. Bindings to explicitly ignore and
/// allow can be set up by passing arrays into the optional `ignoreArray` and `allowArray`
/// parameters.
/// 
/// N.B. Input from a device that is being scanned will continue as normal. To prevent input
///      leaking to e.g. interface navigation you should be careful to check against
///      `InputDeviceGetRebinding()` where appropriate.
/// 
/// @param {Real} device
/// @param {Bool} state
/// @param {Bool} [ignoreArray]
/// @param {Bool} [allowArray]

function InputDeviceSetRebinding(_device, _state, _ignoreArray = undefined, _allowArray = undefined)
{
    static _rebindingMap   = __InputSystem().__rebindingMap;
    static _rebindingArray = __InputSystem().__rebindingArray;
    
    if ((_device != INPUT_KBM) && (_device < 0))
    {
        return;
    }
    
    if (_state)
    {
        if (not ds_map_exists(_rebindingMap, _device))
        {
            InputVerbConsumeAll(InputDeviceGetPlayer(_device));
            
            var _handler = new __InputClassRebindingHandler(_device, _ignoreArray, _allowArray);
            _rebindingMap[? _device] = _handler;
            array_push(_rebindingArray, _handler);
        }
    }
    else
    {
        if (ds_map_exists(_rebindingMap, _device))
        {
            ds_map_delete(_rebindingMap, _device);
            
            var _i = 0;
            repeat(array_length(_rebindingArray))
            {
                if (_rebindingArray[_i].__device == _device)
                {
                    array_delete(_rebindingArray, _i, 1);
                }
                else
                {
                    ++_i;
                }
            }
        }
    }
}