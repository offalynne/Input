// Feather disable all

function __InputTextAsyncSteam()
{
    static _system = __InputTextSystem();

    if (_system.__steamAsyncRequest && (async_load[? "event_type"] == "gamepad_text_input_dismissed"))
    {
        var _submitted = async_load[? "submitted"];        
        with(_system)
        {
            if (!_submitted)
            {
                __newStatus = INPUT_TEXT_STATUS.CANCELLED;
            }
            else if (__requestStatus == INPUT_TEXT_STATUS.WAITING)
            {
                __newStatus = INPUT_TEXT_STATUS.CONFIRMED;
                __textAsync = string_copy(steam_get_entered_gamepad_text_input(), 1, __maxLength);
            }
            
            __steamAsyncRequest = false;
        }
    }
}