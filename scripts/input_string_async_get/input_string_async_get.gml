/// @param prompt
/// @param [string]
/// @param [allowEmpty]

function input_string_async_get(_prompt, _string = global.__input_string, _allow_empty = false)
{
    if (os_type == os_linux || os_type == os_ios || os_type == os_tvos)
    {
        __input_error("Due to up-stream integration problems, input_string_async_get() is unsupported on Linux, iOS, and tvOS.");
        return false;
    }
    
    if (!__INPUT_ON_CONSOLE) __input_trace("Async dialogue not reccomended off of console platforms");
    if (__INPUT_ON_MOBILE)   __input_trace("Consider showing the virtual keyboard for non-modal text input instead");
       
    //Issue modal request when not awaiting response
    if (global.__input_async_id != undefined)
    {
        __input_trace("Async string get prompt refused: waiting for callback ID \"", global.__input_async_id, "\"");
        return false;
    }
    else
    {      
        global.__input_async_id           = get_string_async(_prompt, _string);
        global.__input_string_predialogue = input_string_get();
        global.__input_async_allow_empty  = _allow_empty;
        return true;
    }
}
