// Feather disable all

/// Manually collects player input from devices. Should only be called when
/// `INPUT_UPDATE_AFTER_COLLECT` is set to `false`.

function InputManualUpdate()
{
    if (INPUT_UPDATE_AFTER_COLLECT)
    {
        __InputError("Cannot call InputManualUpdate(), INPUT_UPDATE_AFTER_COLLECT must be set to `false` (=", INPUT_UPDATE_AFTER_COLLECT, ")");
    }
    
    __InputPlugInExecuteCallbacks(INPUT_PLUG_IN_CALLBACK.UPDATE);
}