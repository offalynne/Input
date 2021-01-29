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
        
        var _type = _column_array[0];
        
        var _x = 1;
        repeat(array_length(_column_array) - 1)
        {
            var _tag = _column_array[_x];
            
            if (string_length(_tag) == 8)
            {
                //_tag = string_copy(_tag, 3, 2) + string_copy(_tag, 1, 2) + string_copy(_tag, 7, 2) + string_copy(_tag, 5, 2);
                global.__input_type_dictionary[$ _tag] = _type;
                
                __input_trace("\"", _tag, "\" = \"", _type, "\"");
                
                _count++;
            }
            else if (string_length(_raw_tag) > 0)
            {
                __input_trace("Warning! Gamepad GUID \"", _raw_tag, "\" from type CSV cannot be parsed");
            }
            
            ++_x;
        }
        
        ++_y;
    }
    
    __input_trace(_count, " controller type definitions found");
    __input_trace("Loaded in ", (get_timer() - _t)/1000, "ms");
    
    
    
    
    
    var _buffer = buffer_load("controllertypes old.csv");
    var _string = buffer_read(_buffer, buffer_text);
    buffer_delete(_buffer);
    
    var _count = 0;
    var _row_array = __input_csv_to_array(_string, "\t", "\"");
    
    var _y = 1;
    repeat(array_length(_row_array) - 1)
    {
        var _column_array = _row_array[_y];
        if (array_length(_column_array) == 3)
        {
            var _type    = _column_array[0];
            var _vendor  = _column_array[1];
            var _product = _column_array[2];
            
            var _raw_tag = _vendor + _product;
            _tag = string_copy(_raw_tag, 3, 2) + string_copy(_raw_tag, 1, 2) + string_copy(_raw_tag, 7, 2) + string_copy(_raw_tag, 5, 2);
            
            if (variable_struct_exists(global.__input_type_dictionary, _tag))
            {
                if (_type != global.__input_type_dictionary[$ _tag])
                {
                    __input_trace("Conflict for \"", _tag, "\", new type = ", global.__input_type_dictionary[$ _tag], ", old type = ", _type);
                }
            }
            else
            {
                global.__input_type_dictionary[$ _tag] = _type;
            }
        }
        
        ++_y;
    }
    
    
    var _top_level = [];
    var _dict = {};
    var _tags = variable_struct_get_names(global.__input_type_dictionary);
    
    var _i = 0;
    repeat(array_length(_tags))
    {
        var _tag = _tags[_i];
        var _type = global.__input_type_dictionary[$ _tag];
        
        var _array = _dict[$ _type];
        if (!is_array(_array))
        {
            _array = [_type];
            array_push(_top_level, _array);
            _dict[$ _type] = _array;
        }
        
        array_push(_array, _tag);
        __input_trace("Pushing \"", _tag, "\" as \"", _type, "\"");
        
        ++_i;
    }
    
    array_sort(_top_level, function(_a, _b)
    {
        var _string_a = _a[0];
        var _string_b = _b[0];
        var _length_a = string_length(_string_a);
        var _length_b = string_length(_string_b);
        
        var _i = 0;
        do
        {
            ++_i;
            var _diff = ord(string_char_at(_string_a, _i)) - ord(string_char_at(_string_b, _i));
        }
        until ((_diff != 0) || (_i > _length_a) || (_i > _length_b));
        
        if (_diff == 0)
        {
            return sign(_length_a - _length_b);
        }
        else
        {
            return _diff;
        }
    });
    
    clipboard_set_text(snap_to_csv(_top_level, ",", "\""));
    
    
    
    return true;
}