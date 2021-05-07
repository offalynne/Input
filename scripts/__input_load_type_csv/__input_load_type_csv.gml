function __input_load_type_csv(_filename)
{
    var _t = get_timer();
    
    __input_trace("Loading controller type CSV from \"", _filename, "\"");
    
    var _buffer = buffer_load(_filename);
    var _string = buffer_read(_buffer, buffer_text);
    buffer_delete(_buffer);
    
    var _count = 0;
    var _row_array = __input_csv_to_array(_string, ",", "\"");
    
    var _y = 0;
    repeat(array_length(_row_array))
    {
        var _column_array = _row_array[_y];
        var _raw_type = _column_array[0];
        
        var _x = 1;
        repeat(array_length(_column_array) - 1)
        {
            var _tag = _column_array[_x];
            global.__input_raw_type_dictionary[$ _tag] = _raw_type;
            _count++;
            
            ++_x;
        }
        
        ++_y;
    }
    
    __input_trace(_count, " controller type definitions found");
    __input_trace("Loaded in ", (get_timer() - _t)/1000, "ms");
    
    return true;
}
