// Feather disable all

/// @param device
/// @param ignoreArray
/// @param allowArray

function __InputClassRebindingHandler(_device, _ignoreArray, _allowArray) constructor
{
    __device = _device;
    
    __createTime = current_time;
    
    //Convert ignore array into a struct for faster look-up later
    if (is_struct(_ignoreArray))
    {
        //Legacy support for 10.0.6 and older
        var _ignoreStruct = _ignoreArray;
    }
    else if (is_undefined(_ignoreArray))
    {
        //Pass through an empty struct
        var _ignoreStruct = {};
    }
    else if (not is_array(_ignoreArray))
    {
        __InputError($"Rebinding ignore data must be an array or `undefined` (was \"{typeof(_ignoreArray)}\")");
    }
    else
    {
        var _ignoreStruct = {};
        var _i = 0;
        repeat(array_length(_ignoreArray))
        {
            var _binding = _ignoreArray[_i];
            
            //Convert letters into bindings
            if (is_string(_binding))
            {
                _binding = ord(_binding);
            }
            
            _ignoreStruct[$ string(_binding)] = true;
            ++_i;
        }
    }
    
    //Convert allow array into a struct for faster look-up later
    if (is_struct(_allowArray))
    {
        //Legacy support for 10.0.6 and older
        var _allowStruct = _allowArray;
    }
    else if (is_undefined(_allowArray))
    {
        //Pass through `undefined` to signify "anything goes"
        var _allowStruct = undefined;
    }
    else if (not is_array(_allowArray))
    {
        __InputError($"Rebinding allow data must be an array or `undefined` (was \"{typeof(_allowArray)}\")");
    }
    else
    {
        var _allowStruct = {};
        var _i = 0;
        repeat(array_length(_allowArray))
        {
            var _binding = _allowArray[_i];
            
            //Convert letters into bindings
            if (is_string(_binding))
            {
                _binding = ord(_binding);
            }
            
            _allowStruct[$ string(_binding)] = true;
            ++_i;
        }
    }
    
    __rebindingWait         = true;
    __rebindingResult       = undefined;
    __rebindingIgnoreStruct = _ignoreStruct;
    __rebindingAllowStruct  = _allowStruct;
    
    static __Update = function()
    {
        //Timeout
        if (__createTime - current_time > INPUT_REBIND_TIMEOUT)
        {
            InputDeviceSetRebinding(__device, false);
            return;
        }
        
        var _binding = __InputBindingScan(__device, __rebindingIgnoreStruct, __rebindingAllowStruct);
        if (__rebindingWait)
        {
            if (_binding == undefined) __rebindingWait = false;
        }
        else
        {
            if (_binding != undefined)
            {
                __rebindingResult = _binding;
                __rebindingWait = true;
            }
        }
    }
}