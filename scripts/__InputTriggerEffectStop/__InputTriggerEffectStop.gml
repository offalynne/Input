// Feather disable all

/// @param [device=all]

function __InputTriggerEffectStop(_device = undefined)
{
    static _deviceMap = __InputTriggerEffectSystem().__deviceMap;
    
    if (_device == undefined)
    {
        var _deviceArray = InputDeviceEnumerate(false);
        
        var _i = 0;
        repeat(array_length(_deviceArray))
        {
            _device = _deviceArray[_i];
            if (_device >= 0)
            {
                __InputTriggerEffectStop(_device);
            }
            
            ++_i;
        }
        
        return;
    }
    
    //Ignore anything that's not a gamepad
    if (_device < 0) return;
    
    with(_deviceMap[? _device])
    {
        __Apply(gp_shoulderlb, new __InputTriggerEffectClassOff(), 0);
        __Apply(gp_shoulderrb, new __InputTriggerEffectClassOff(), 0);
    }
}
