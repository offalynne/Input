function input_string_dialog_async_event()
{
    if ((event_number != (__INPUT_ON_WEB ? 0 : ev_dialog_async)))   
    {
        //Use in async dialog event only
        __input_error("Async dialogue used in invalid event (", object_get_name(object_index), ", ", event_type, ", ", event_number, ")");
    }
    else
    {
        if ((global.__input_async_id != undefined) && (async_load != undefined)
        && (async_load[? "id"] == global.__input_async_id) && (async_load[? "status"] != undefined))
        {
            //Report results
            var _result = string(async_load[? "result"]);
            if (!global.__input_async_allow_empty && ((_result == undefined) || (string(_result) == "")))
            {
                _result = global.__input_string_predialogue;
            }
            
            input_string_set(_result);
            global.__input_async_id = undefined;
            if (os_type == os_uwp) keyboard_string = "";
        }
    }
  
    //Waiting for status
}
