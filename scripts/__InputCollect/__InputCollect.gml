// Feather disable all

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
            __InputTrace($"Initializing {array_length(__plugInArray)} plug-in(s)");
            __plugInsInitializing = true;
            
            var _i = 0;
            repeat(array_length(__plugInArray))
            {
                __plugInArray[_i].__Initialize();
                ++_i;
            }
            
            __InputTrace($"Plug-in initialization complete");
            __plugInsInitializing = false;
        }
    })();
    
    __InputPlugInExecuteCallbacks(INPUT_PLUG_IN_CALLBACK.COLLECT);
    if (INPUT_UPDATE_AFTER_COLLECT) __InputPlugInExecuteCallbacks(INPUT_PLUG_IN_CALLBACK.UPDATE);
}