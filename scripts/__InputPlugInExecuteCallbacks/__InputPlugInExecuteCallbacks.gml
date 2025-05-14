// Feather disable all

/// @param callbackType
/// @param [param0=undefined]
/// @param [param1=undefined]
/// @param [param2=undefined]
/// @param [param3=undefined]
/// @param [param4=undefined]
/// @param [param5=undefined]

function __InputPlugInExecuteCallbacks(_callbackType, _param0 = undefined, _param1 = undefined, _param2 = undefined, _param3 = undefined, _param4 = undefined, _param5 = undefined)
{
    static _system        = __InputSystem();
    static _callbackArray = __InputSystemCallbackArray();
    
    var _prevCallback = _system.__plugInCurrentCallback;
    _system.__plugInCurrentCallback = _callbackType;
    
    var _array = _callbackArray[_callbackType];
    var _i = 0;
    repeat(array_length(_array))
    {
        _array[_i].__method(_param0, _param1, _param2, _param3, _param4, _param5);
        ++_i;
    }
    
    _system.__plugInCurrentCallback = _prevCallback;
}