// Feather disable all

/// Manually collects player input from devices. Should only be called when `INPUT_COLLECT_MODE`
/// is set to 2.

function InputManualCollect()
{
    if (INPUT_COLLECT_MODE != 2)
    {
        __InputError("Cannot call InputManualCollect(), INPUT_COLLECT_MODE must be set to 2 (=", INPUT_COLLECT_MODE, ")");
    }
    
    __InputCollect();
}