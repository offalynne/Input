// Feather disable all

/// @param device
/// @param ignoreStruct
/// @param allowStruct

function __InputClassRebindingHandler(_device, _ignoreStruct, _allowStruct) constructor
{
    __device = _device;
    
    __createTime = current_time;
    
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