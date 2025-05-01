// Feather disable all

function __InputRegisterUpdatePlayer()
{
    __InputPlugInRegisterCallbackInternal(INPUT_PLUG_IN_CALLBACK.UPDATE_PLAYER, 0, function(_playerIndex)
    {
        static _system      = __InputSystem();
        static _playerArray = __InputSystemPlayerArray();
        static _verbCount   = _system.__verbCount;
        
        with(_playerArray[_playerIndex])
        {
            var _systemFrame = _system.__frame;
            
            var _verbStateArray  = __verbStateArray;
            var _valueRawArray   = __valueRawArray;
            var _valueClampArray = __valueClampArray;
            
            /////////////////////////
            //                     //
            //  Verb State Update  //
            //                     //
            /////////////////////////
             
            //Detect pressed/held/released state based on values that the virtual button has outputted
            var _i = 0;
            repeat(_verbCount)
            {
                with(_verbStateArray[_i])
                {
                    __prevHeld = __held;
                
                    __valueRaw   = _valueRawArray[_i];
                    __valueClamp = _valueClampArray[_i];
                
                    if (__valueClamp > 0)
                    {
                        __anyHardwareInput = true;
                    
                        __held = true;
                        if (not __prevHeld) __pressFrame = _systemFrame;
                    }
                    else
                    {
                        __held = false;
                    }
                }
            
                ++_i;
            }
        }
    });
}