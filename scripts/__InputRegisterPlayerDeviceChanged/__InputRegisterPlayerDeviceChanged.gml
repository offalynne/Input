// Feather disable all

function __InputRegisterPlayerDeviceChanged()
{
    __InputPlugInRegisterCallbackInternal(INPUT_PLUG_IN_CALLBACK.PLAYER_DEVICE_CHANGED, 0, function(_playerIndex, _oldDevice, _device)
    {
        static _playerArray        = __InputSystemPlayerArray();
        static _deviceMap          = __InputSystem().__deviceMap;
        static _virtualButtonArray = __InputSystem().__virtualButtonArray;
        
        with(_playerArray[_playerIndex])
        {
            //Unset the device for the player previously using it
            if ((_device != INPUT_NO_DEVICE) && (_device != INPUT_GENERIC_DEVICE))
            {
                var _oldPlayerIndex = _deviceMap[? _device];
                if (_oldPlayerIndex != undefined)
                {
                    with(_playerArray[_oldPlayerIndex])
                    {
                        __device = INPUT_NO_DEVICE;
                        
                        //Immediately update status
                        __UpdateStatus();
                    }
                }
            }
        
            if (_oldDevice == INPUT_NO_DEVICE)
            {
                //Set a new valid device, set our input time so we don't get thrashing when hotswapping
                __lastInputTime = current_time;
            }
            else
            {
                //Clear virtual buttons when setting touch device
                if (_oldDevice == INPUT_TOUCH)
                {
                    var _i = 0;
                    repeat(array_length(_virtualButtonArray))
                    {
                        _virtualButtonArray[_i].__ClearState();
                        ++_i;
                    }
                }
                
                //Remove the old block from the device usage map
                ds_map_delete(_deviceMap, _oldDevice);
            }
            
            __device = _device;
            
            //Immediately update status
            __UpdateStatus();
            
            //Block other players from using this device
            if ((_device != INPUT_NO_DEVICE) && (_device != INPUT_GENERIC_DEVICE))
            {
                _deviceMap[? _device] = _playerIndex;
            }
        }
    });
}