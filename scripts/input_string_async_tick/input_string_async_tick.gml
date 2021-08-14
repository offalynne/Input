function input_string_async_tick(){

    //Use in async dialog event only
    if ((event_number != (__INPUT_ON_WEB ? 0 : ev_dialog_async)))   
    {
        __input_error("Async tick in invalid event (", object_get_name(object_index), ", ", event_type, ", ", event_number, ")");
        exit;
    }
    else
    {
        if ((global.__input_async_id != undefined) && (async_load != undefined))
        {
            if ((async_load[? "id"] == global.__input_async_id) && (async_load[? "status"] != undefined))
            {
                //Report results
                var _result = async_load[? "result"];
                if (global.__input_async_allow_empty || _result != undefined && string(_result) != "")
                {
                    input_string_set(string(_result));
                }
                
                global.__input_async_id = undefined;
            }
            
            //Waiting for status
        }
    }
}