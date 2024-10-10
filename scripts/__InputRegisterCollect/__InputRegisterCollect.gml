// Feather disable all

function __InputRegisterCollect()
{
    __InputPlugInRegisterCallbackInternal(INPUT_PLUG_IN_CALLBACK.COLLECT, 0, function()
    {
        static _playerArray = __InputSystemPlayerArray();
        
        //Update player verb states
        var _i = 0;
        repeat(INPUT_MAX_PLAYERS)
        {
            _playerArray[_i].__Collect();
            ++_i;
        }
    });
}