function __InputTextAsyncDialog()
{
    static _system = __InputTextSystem();

    if ((async_load != -1) && (_system.__asyncId != undefined) && (async_load[? "id"] == _system.__asyncId))
    {
        var _result = async_load[? "result"];
        var _status = async_load[? "status"];
        with(_system)
        {
            if (!_status || (_result == undefined))
            {
                __requestStatus = INPUT_TEXT_REQUEST_STATUS.CANCELLED;
            }
            else
            {
                __requestStatus = INPUT_TEXT_REQUEST_STATUS.CONFIRMED;
                __textAsync = string_copy(_result, 1, __maxLength);
            }

            __Callback();
            __asyncId = undefined;
        }
    }
}