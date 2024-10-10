// Feather disable all

__InputPlugInExecuteCallbacks(INPUT_PLUG_IN_CALLBACK.COLLECT);

if (INPUT_UPDATE_AFTER_COLLECT)
{
    __InputPlugInExecuteCallbacks(INPUT_PLUG_IN_CALLBACK.UPDATE);
}