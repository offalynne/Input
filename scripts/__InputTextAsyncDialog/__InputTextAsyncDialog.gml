// Feather disable all

function __InputTextAsyncDialog()
{
    static _system = __InputTextSystem();

    if ((async_load != -1) && (_system.__asyncId != undefined) && (async_load[? "id"] == _system.__asyncId))
    {
        var _result = async_load[? "result"];
        with(_system)
        {
            if (!async_load[? "status"] || (_result == undefined))
            {
                __newStatus = INPUT_TEXT_STATUS.CANCELLED;
            }
            else if (__requestStatus == INPUT_TEXT_STATUS.WAITING)
            {
                __newStatus = INPUT_TEXT_STATUS.CONFIRMED;
                __textAsync = string_copy(_result, 1, __maxLength);
            }
            
            __asyncId = undefined;
        }
    }
}