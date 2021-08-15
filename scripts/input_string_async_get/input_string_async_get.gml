//param prompt
//param string
//param allow_empty
function input_string_async_get(_prompt, _string = global.__input_string, _allow_empty = global.__input_async_allow_empty)
{
    if (global.__input_async_id != undefined)
    {
        __input_trace("Async string get prompt refused: waiting for callback ID \"", global.__input_async_id, "\"");
        return false;
    }
    else
    {
        global.__input_async_allow_empty = _allow_empty;
        global.__input_async_id = get_string_async(_prompt, _string);
        return true;
    }
}