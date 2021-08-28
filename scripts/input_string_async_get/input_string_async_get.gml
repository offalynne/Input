/// @param prompt
/// @param [string]
/// @param [allowEmpty]

function input_string_async_get(_prompt, _string = global.__input_string, _allow_empty = false)
{
    //Warn dialog platform suitability
    var _source = input_platform_text_source();
    if (_source != "async")   __input_trace("Async dialog is not suitable for use on the current platform");
    if (_source == "virtual") __input_trace("Consider showing the virtual keyboard for non-modal text input instead");
       
    //Issue modal request when not awaiting response
    if (global.__input_async_id != undefined)
    {
        __input_trace("Async string get prompt refused: waiting for callback ID \"", global.__input_async_id, "\"");
        return false;
    }
    else
    {
        global.__input_async_id           = get_string_async(_prompt, (os_type == os_switch ? string_copy(_string, 1, 500) : _string));
        global.__input_string_predialogue = input_string_get();
        global.__input_async_allow_empty  = _allow_empty;
        return true;
    }
}
