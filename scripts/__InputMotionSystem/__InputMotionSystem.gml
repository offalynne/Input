// Feather disable all

InputPlugInRegisterName("InputMotion",,, __InputMotionSystem);
function __InputMotionSystem()
{
    static _system = undefined;
    if (_system != undefined) return _system;
    
    _system = {};
    with(_system)
    {
        __deviceMap   = ds_map_create();
        __deviceArray = [];
        
        if (InputMotionSupportedByPlatform())
        {
            //Only initialize callbacks if this platform actually supports gyro and motion
            
            InputPlugInRegisterCallback(INPUT_PLUG_IN_CALLBACK.GAMEPAD_CONNECTED, undefined, function(_device)
            {
                var _struct = new __InputMotionClass(_device);
                __deviceMap[? _device] = _struct;
                array_push(__deviceArray, _struct);
            });
            
            InputPlugInRegisterCallback(INPUT_PLUG_IN_CALLBACK.GAMEPAD_DISCONNECTED, undefined, function(_device, _actuallyDisconnected)
            {
                ds_map_delete(__deviceMap, _device);
                
                var _i = 0;
                repeat(array_length(__deviceArray))
                {
                    if (__deviceArray[_i].__device == _device)
                    {
                        array_delete(__deviceArray, _i, 1);
                    }
                    else
                    {
                        ++_i;
                    }
                }
            });
            
            InputPlugInRegisterCallback(INPUT_PLUG_IN_CALLBACK.UPDATE, undefined, function()
            {
                array_foreach(__deviceArray, function(_element, _index)
                {
                    _element.__Update();
                });
            });
        }
    }
    
    return _system;
}