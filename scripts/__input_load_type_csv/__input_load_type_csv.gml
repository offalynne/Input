function __input_load_type_csv(_filename)
{
    var _t = get_timer();
    
    __input_trace("Loading controller type CSV from \"", _filename, "\"");
    
    var _buffer = buffer_load(_filename);
    var _string = buffer_read(_buffer, buffer_text);
    buffer_delete(_buffer);
    
    var _row_array = __input_csv_to_array(_string, "\t", "\"");
    
    var _y = 1;
    repeat(array_length(_row_array) - 1)
    {
        var _column_array = _row_array[_y];
        var _type    = _column_array[0];
        var _vendor  = _column_array[1];
        var _product = _column_array[2];
        
        global.__input_type_dictionary[$ _vendor + _product] = _type;
        
        ++_y;
    }
    
    __input_trace(array_length(_row_array), " controller type definitions found");
    __input_trace("Loaded in ", (get_timer() - _t)/1000, "ms");
    
    return true;
}