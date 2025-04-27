// Feather disable all

/// @param callbackType
/// @param priority
/// @param method

function __InputPlugInRegisterCallbackInternal(_callbackType, _priority, _method)
{
    static _callbackArray = __InputSystemCallbackArray();
    
    var _array = _callbackArray[_callbackType];
    array_push(_array, {
        __priority: _priority,
        __method:   _method,
    });
    
    array_sort(_array, function(_a, _b)
    {
        return sign(_b.__priority - _a.__priority);
    });
}