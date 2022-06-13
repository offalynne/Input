/// @return JSON string that encodes the struct/array nested data
/// 
/// @param struct/array          The data to be encoded. Can contain structs, arrays, strings, and numbers.   N.B. Will not encode ds_list, ds_map etc.
/// @param [pretty]              (bool) Whether to format the string to be human readable. Defaults to <false>
/// @param [alphabetizeStructs]  (bool) Sorts struct variable names is ascending alphabetical order as per ds_list_sort(). Defaults to <false>
/// 
/// @jujuadams 2020-09-13

function __input_snap_to_json()
{
    var _ds          = argument[0];
    var _pretty      = ((argument_count > 1) && (argument[1] != undefined))? argument[1] : false;
    var _alphabetise = ((argument_count > 2) && (argument[2] != undefined))? argument[2] : false;
    
    return (new __input_snap_to_json_parser(_ds, _pretty, _alphabetise)).result;
}

function __input_snap_to_json_parser(_ds, _pretty, _alphabetise) constructor
{
    root        = _ds;
    pretty      = _pretty;
    alphabetise = _alphabetise;
    
    result = "";
    buffer = buffer_create(1024, buffer_grow, 1);
    indent = "";
    
    static parse_struct = function(_struct)
    {
        var _names = variable_struct_get_names(_struct);
        var _count = array_length(_names);
        var _i = 0;
        
        if (alphabetise)
        {
            var _list = ds_list_create();
            
            repeat(_count)
            {
                _list[| _i] = _names[_i];
                ++_i;
            }
            
            ds_list_sort(_list, true);
            
            var _i = 0;
            repeat(_count)
            {
                _names[@ _i] = _list[| _i];
                ++_i;
            }
            
            ds_list_destroy(_list);
            var _i = 0;
        }
        
        if (pretty)
        {
            if (_count > 0)
            {
                buffer_write(buffer, buffer_text, "{\n");
                indent += "    ";
                
                var _written = false;
                repeat(_count)
                {
                    var _name = _names[_i];
                    value = variable_struct_get(_struct, _name);
                    
                    if (!is_method(value))
                    {
                        if (is_struct(_name) || is_array(_name))
                        {
                            show_error("Key type \"" + typeof(_name) + "\" not supported\n ", false);
                            _name = string(ptr(_name));
                        }
                        
                        buffer_write(buffer, buffer_text, indent + "\"");
                        buffer_write(buffer, buffer_text, string(_name));
                        buffer_write(buffer, buffer_text, "\" : ");
                        
                        write_value();
                        
                        buffer_write(buffer, buffer_text, ",\n");
                        _written = true;
                    }
                    
                    ++_i;
                }
                
                indent = string_copy(indent, 1, string_length(indent) - 4);
                if (_written) buffer_seek(buffer, buffer_seek_relative, -2);
                buffer_write(buffer, buffer_text, "\n" + indent + "}");
            }
            else
            {
                buffer_write(buffer, buffer_text, "{}");
            }
        }
        else
        {
            buffer_write(buffer, buffer_text, "{");
            
            var _written = false;
            repeat(_count)
            {
                var _name = _names[_i];
                value = variable_struct_get(_struct, _name);
                
                if (!is_method(value))
                {
                    if (is_struct(_name) || is_array(_name))
                    {
                        show_error("Key type \"" + typeof(_name) + "\" not supported\n ", false);
                        _name = string(ptr(_name));
                    }
                    
                    buffer_write(buffer, buffer_text, "\"");
                    buffer_write(buffer, buffer_text, string(_name));
                    buffer_write(buffer, buffer_text, "\":");
                    
                    write_value();
                    
                    buffer_write(buffer, buffer_text, ",");
                    _written = true;
                }
                
                ++_i;
            }
            
            if (_written) buffer_seek(buffer, buffer_seek_relative, -1);
            buffer_write(buffer, buffer_text, "}");
        }
    }
    
    
    
    static parse_array = function(_array)
    {
    
        var _count = array_length(_array);
        var _i = 0;
        
        if (pretty)
        {
            if (_count > 0)
            {
                buffer_write(buffer, buffer_text, "[\n");
                indent += "    ";
                
                repeat(_count)
                {
                    value = _array[_i];
                    
                    buffer_write(buffer, buffer_text, indent);
                    write_value();
                    buffer_write(buffer, buffer_text, ",\n");
                    
                    ++_i;
                }
                
                indent = string_copy(indent, 1, string_length(indent) - 4);
                buffer_seek(buffer, buffer_seek_relative, -2);
                buffer_write(buffer, buffer_text, "\n" + indent + "]");
            }
            else
            {
                buffer_write(buffer, buffer_text, "[]");
            }
        }
        else
        {
            buffer_write(buffer, buffer_text, "[");
            
            repeat(_count)
            {
                value = _array[_i];
                
                write_value();
                buffer_write(buffer, buffer_text, ",");
                
                ++_i;
            }
            
            if (_count > 0) buffer_seek(buffer, buffer_seek_relative, -1);
            buffer_write(buffer, buffer_text, "]");
        }
    }
    
    
    
    static write_value = function()
    {
        if (is_struct(value))
        {
            parse_struct(value);
        }
        else if (is_array(value))
        {
            parse_array(value);
        }
        else if (is_string(value))
        {
            //Sanitise strings
            value = string_replace_all(value, "\\", "\\\\");
            value = string_replace_all(value, "\n", "\\n");
            value = string_replace_all(value, "\r", "\\r");
            value = string_replace_all(value, "\t", "\\t");
            value = string_replace_all(value, "\"", "\\\"");
            
            buffer_write(buffer, buffer_text, "\"");
            buffer_write(buffer, buffer_text, value);
            buffer_write(buffer, buffer_text, "\"");
        }
        else if (is_undefined(value))
        {
            buffer_write(buffer, buffer_text, "null");
        }
        else if (is_bool(value))
        {
            buffer_write(buffer, buffer_text, value? "true" : "false");
        }
        else if (is_real(value))
        {
            //Strip off trailing zeroes, and if necessary, the decimal point too
            value = string_format(value, 0, 10);
            
            var _length = string_length(value);
            var _i = _length;
            repeat(_length)
            {
                if (string_char_at(value, _i) != "0") break;
                --_i;
            }
            
            if (string_char_at(value, _i) == ".") _i--;
            
            value = string_delete(value, _i + 1, _length - _i);
            
            buffer_write(buffer, buffer_text, value);
        }
        else if (is_method(value))
        {
            buffer_write(buffer, buffer_text, "null");
        }
        else
        {
            buffer_write(buffer, buffer_text, string(value));
        }
    }
    
    
    
    if (is_struct(root))
    {
        parse_struct(root);
    }
    else if (is_array(root))
    {
        parse_array(root);
    }
    else
    {
        show_error("Value not struct or array. Returning empty string\n ", false);
    }
    
    
    
    buffer_seek(buffer, buffer_seek_start, 0);
    result = buffer_read(buffer, buffer_string);
    buffer_delete(buffer);
}