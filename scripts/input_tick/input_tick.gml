/// @param [ignoreWarning=false]

function input_tick(_ignore_warning = false)
{
    if (global.__input_time_source != undefined)
    {
        if (!_ignore_warning) __input_error("Good news! In GMS2022.5 and later you don't need to manually call input_tick()\nPlease remove input_tick(); Input will still behave normally");
        return;
    }
    
    return __input_system_tick();
}
