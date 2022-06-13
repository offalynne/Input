/// @param [ignoreWarning=false]

function input_tick(_ignore_warning = false)
{
    if (!_ignore_warning && (global.__input_time_source != undefined))
    {
        __input_error("Good news! In GMS2022.5 and later you don't need to manually call input_tick()\nPlease remove input_tick(); Input will still behave normally");
    }
    
    return __input_system_tick();
}
