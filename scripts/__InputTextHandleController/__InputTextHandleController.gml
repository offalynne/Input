// Feather disable all

function __InputTextHandleController()
{
    if (!instance_exists(__InputTextAsyncController) && (__steamAsyncRequest || (__asyncId != undefined)))
    {
        if (GM_build_type == "run")
        {
            __InputError("__InputTextAsyncController has been destroyed\nPlease ensure that __InputTextAsyncController is never destroyed");
        }
        else
        {
            __InputTrace("Warning! __InputTextAsyncController has been destroyed. Please ensure that __InputTextAsyncController is never destroyed");
        }
                
        __steamAsyncRequest = false;
        __asyncId = undefined;
    }
}