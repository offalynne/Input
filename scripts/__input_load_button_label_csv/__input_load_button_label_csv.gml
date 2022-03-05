function __input_load_button_label_csv(_filename)
{
    var _t = get_timer();
    
    __input_trace("Loading button label CSV from \"", _filename, "\"");
    
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
        
        var _button_struct = {};
        global.__input_button_label_dictionary[$ _type] = _button_struct;
        
        var _x = 1;
        repeat(array_length(_column_array) - 1)
        {
            var _cell_string = _column_array[_x];
            
            if (string_count(":", _cell_string) != 1)
            {
                __input_trace("Could not parse button label definition \"", _cell_string, "\" for controller type \"", _type, "\"");
            }
            else
            {
                var _colon_index = string_pos(":", _cell_string);
                var _button = string_copy(_cell_string, 1, _colon_index-1);
                var _label = string_copy(_cell_string, _colon_index+1, string_length(_cell_string) - _colon_index);
                _button_struct[$ _button] = _label;
            }
            
            _count++;
            
            ++_x;
        }
        
        ++_y;
    }
    
    if (__INPUT_ON_CONSOLE)
    {
        //Remove 'back' label on PS4, PS5, Switch JoyCons
        var _override_types = ["PS4Controller", "PS5Controller", "SwitchJoyConLeft", "SwitchJoyConRight"];
        var _label_dict_entry = undefined;
        
        var _i = 0;        
        repeat(array_length(_override_types))
        {            
            _label_dict_entry = global.__input_button_label_dictionary[$ _override_types[_i]];
            if (is_struct(_label_dict_entry)) variable_struct_remove(_label_dict_entry, "back");
            ++_i;
        }
    }
    
    __input_trace(_count, " button label definitions found");
    __input_trace("Loaded in ", (get_timer() - _t)/1000, "ms");
    
    return true;
}
