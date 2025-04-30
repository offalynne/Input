// Feather disable all

/// @param {Real} device

function InputPlugInGamepadNullifyAllMappings(_device)
{
    var _readArray = __InputGamepadGetReadArray(_device);
    if (_readArray == undefined) return;
    
    var _i = 0;
    repeat(array_length(_readArray))
    {
        _readArray[@ _i] = function() { return 0 };
        ++_i;
    }
}