// Feather disable all

function __InputTextHandleStatus()
{
    if (__newStatus == undefined) return;

    if (__newStatus == INPUT_TEXT_STATUS.STOPPED)
    {
        if (INPUT_ON_MOBILE) keyboard_virtual_hide();
    }
                
    if (__newStatus != INPUT_TEXT_STATUS.WAITING)
    {
        if (is_method(__callback))
        {
            __callback();
        }
                    
        __callback = undefined;
    }
                
    __requestStatus = __newStatus;                
    __newStatus = undefined;
}