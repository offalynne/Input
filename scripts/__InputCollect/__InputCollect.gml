// Feather disable all

/// Abstracted function call for all raw verb collection. This ensures that no matter where verb
/// collection is happening, plug-ins are always initialized immediately prior.

function __InputCollect()
{
    //Initialize all the plug-ins. It's important to do this before any callbacks get executed so that
    //plug-ins are aware of Input's overall state as soon as possible. The easiest place to do this is
    //right before the first .COLLECT event occurs.
    static _once = (function()
    {
        static _system = __InputSystem();
        with(_system)
        {
            __InputTrace("Initializing ", array_length(__plugInArray), " plug-in(s)");
            __plugInsInitializeState = 1;
            
            var _i = 0;
            repeat(array_length(__plugInArray))
            {
                __plugInArray[_i].__Initialize();
                ++_i;
            }
            
            __InputTrace("Plug-in initialization complete");
            __plugInsInitializeState = 2;
        }
    })();
    
    __InputPlugInExecuteCallbacks(INPUT_PLUG_IN_CALLBACK.COLLECT);
    if (INPUT_UPDATE_AFTER_COLLECT) __InputPlugInExecuteCallbacks(INPUT_PLUG_IN_CALLBACK.UPDATE);
}