// Feather disable all

function __InputRegisterCollect()
{
    __InputPlugInRegisterCallbackInternal(INPUT_PLUG_IN_CALLBACK.COLLECT, 0, function()
    {
        static _playerArray = __InputSystemPlayerArray();
        
        //Collect raw verb values from players' devices
        var _i = 0;
        repeat(INPUT_MAX_PLAYERS)
        {
            __InputPlugInExecuteCallbacks(INPUT_PLUG_IN_CALLBACK.COLLECT_PLAYER, _i);
            ++_i;
        }
    });
}