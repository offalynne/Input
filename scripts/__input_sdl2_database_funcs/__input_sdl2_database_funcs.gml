function __input_load_sdl2_from_file(_filename)
{
    __input_trace("Loading SDL2 database from \"", _filename, "\"");
    
    var _buffer = buffer_load(_filename);
    if (_buffer < 0)
    {
        show_message("Could not load external SDL2 database \"" + string(_filename) + "\"");
        return false;
    }
    
    //Ensure the buffer has a null terminator
    buffer_resize(_buffer, buffer_get_size(_buffer) + 1);
    
    var _result = __input_load_sdl2_from_buffer(_buffer);
    
    buffer_delete(_buffer);
    
    return _result;
}





function __input_load_sdl2_from_string(_string)
{
    __input_trace("Loading SDL2 database from string \"", _string, "\"");
    
    //Ensure the buffer has a null terminator
    var _buffer = buffer_create(string_byte_length(_string) + 1, buffer_fixed, 1);
    buffer_write(_buffer, buffer_string, _string);
    buffer_seek(_buffer, buffer_seek_start, 0);
    
    var _result = __input_load_sdl2_from_buffer(_buffer);
    
    buffer_delete(_buffer);
    
    return _result;
}





function __input_load_sdl2_from_buffer(_buffer)
{
    var _t = get_timer();
    
    __input_trace("Unpacking SDL2 buffer...");
    
    var _cell_delimiter = ",";
    var _string_delimiter = "\"";
    
    #region Break down the input database into a 2D array
    
    var _size = buffer_get_size(_buffer);
    
    var _cell_delimiter_ord      = ord(_cell_delimiter);
    var _string_delimiter_double = _string_delimiter + _string_delimiter;
    var _string_delimiter_ord    = ord(_string_delimiter);
    
    var _root_array = [];
    var _row_array  = undefined;
    
    var _newline     = false;
    var _read        = false;
    var _word_start  = 0;
    var _in_string   = false;
    var _string_cell = false;
    
    repeat(_size)
    {
        var _value = buffer_read(_buffer, buffer_u8);
        
        if (_value == _string_delimiter_ord)
        {
            _in_string = !_in_string;
            if (_in_string) _string_cell = true;
        }
        else
        {
            if (_value == 0)
            {
                if (_in_string) _string_cell = true;
                _in_string = false;
                
                var _prev_value = buffer_peek(_buffer, buffer_tell(_buffer)-2, buffer_u8);
                if ((_prev_value != _cell_delimiter_ord) && (_prev_value != 10) && (_prev_value != 13))
                {
                    _read = true;
                }
            }
            
            if (!_in_string)
            {
                if ((_value == 10) || (_value == 13))
                {
                    var _prev_value = buffer_peek(_buffer, buffer_tell(_buffer)-2, buffer_u8);
                    if ((_prev_value != 10) && (_prev_value != 13))
                    {
                        _newline = true;
                        if (_prev_value != _cell_delimiter_ord)
                        {
                            _read = true;
                        }
                        else
                        {
                            ++_word_start;
                        }
                    }
                    else
                    {
                        ++_word_start;
                    }
                }
            
                if (_read || (_value == _cell_delimiter_ord))
                {
                    _read = false;
                
                    var _tell = buffer_tell(_buffer);
                    var _old_value = buffer_peek(_buffer, _tell-1, buffer_u8);
                    buffer_poke(_buffer, _tell-1, buffer_u8, 0x00);
                    buffer_seek(_buffer, buffer_seek_start, _word_start);
                    var _string = buffer_read(_buffer, buffer_string);
                    buffer_poke(_buffer, _tell-1, buffer_u8, _old_value);
                    
                    if (_string_cell)
                    {
                        if ((string_byte_at(_string, 1) == _string_delimiter_ord)
                        &&  (string_byte_at(_string, string_byte_length(_string)) == _string_delimiter_ord))
                        {
                            _string = string_copy(_string, 2, string_length(_string)-2); //Trim off leading/trailing quote marks
                        }
                    }
                    
                    _string = string_replace_all(_string, _string_delimiter_double, _string_delimiter); //Replace double quotes with single quotes
                    
                    if (_row_array == undefined)
                    {
                        _row_array = [];
                        _root_array[@ array_length(_root_array)] = _row_array;
                    }
                    
                    _row_array[@ array_length(_row_array)] = _string;
                
                    _string_cell = false;
                    _word_start = _tell;
                }
            
                if (_newline)
                {
                    _newline = false;
                    _row_array = undefined;
                }
            }
        }
    }
    
    #endregion
    
    var _total_count          = 0;
    var _platform_count       = 0;
    var _db_by_guid           = global.__input_sdl2_database.by_guid;
    var _db_by_vendor_product = global.__input_sdl2_database.by_vendor_product;
    var _db_by_description    = global.__input_sdl2_database.by_description;
    
    var _y = 0;
    repeat(array_length(_root_array))
    {
        var _row_array = _root_array[_y];
        if (is_array(_row_array))
        {
            //Ignore comments
            if (string_pos("#", _row_array[0]) <= 0)
            {
                ++_total_count;
                
                var _guid = _row_array[0];
                
                //Identify this definition's vendor+product and description names
                var _result = __input_gamepad_guid_parse(_guid, false, true);
                var _vendor_product = _result.vendor + _result.product;
                var _description    = _result.description;
                
                //Find what platform this definition is for by searching through the row's values
                //We do this backwards for the sake of efficiency since platform is usually tacked on the end
                var _platform = undefined;
                var _x = array_length(_row_array)-1;
                repeat(array_length(_row_array))
                {
                    var _lower = string_lower(_row_array[_x]);
                    if (_lower == "platform:windows" ) { _platform = os_windows; break; }
                    if (_lower == "platform:mac"     ) { _platform = os_macosx;  break; }
                    if (_lower == "platform:macos"   ) { _platform = os_macosx;  break; }
                    if (_lower == "platform:macosx"  ) { _platform = os_macosx;  break; }
                    if (_lower == "platform:mac os"  ) { _platform = os_macosx;  break; }
                    if (_lower == "platform:mac os x") { _platform = os_macosx;  break; }
                    if (_lower == "platform:linux"   ) { _platform = os_linux;   break; }
                    if (_lower == "platform:android" ) { _platform = os_android; break; }
                    if (_lower == "platform:ios"     ) { _platform = os_ios;     break; }
                    --_x;
                }
                
                //If we didn't find a platform for the definition then show a warning message for it
                if (_platform == undefined) __input_trace("Warning! Platform not found for ", _row_array);
                
                //We ignore any definition that has a platform that's different to our current platform
                if ((_platform == undefined) || (_platform == os_type))
                {
                    ++_platform_count;
                    
                    if (_description != "")
                    {
                        //Add this definition to the GUID-description struct
                        var _description_array = _db_by_description[$ _description];
                        if (!is_array(_description_array))
                        {
                            _description_array = [];
                            _db_by_description[$ _description] = _description_array;
                        }
                        
                        //Push the definition into the GUID-description array
                        _description_array[@ array_length(_description_array)] = _row_array;
                    }                    
                    else if (_vendor_product != "")
                    {
                        //Add this definition to the "by vendor+product" struct
                        var _vp_array = _db_by_vendor_product[$ _vendor_product];
                        if (!is_array(_vp_array))
                        {
                            _vp_array = [];
                            _db_by_vendor_product[$ _vendor_product] = _vp_array;
                        }
                        
                        //Push the definition into the vendor+product array
                        _vp_array[@ array_length(_vp_array)] = _row_array;
                    }
                    
                    if (variable_struct_exists(_db_by_guid, _guid))
                    {
                        //We have a GUID collision then it's probably the user overwriting
                        __input_trace("Warning! Overwriting GUID \"", _guid, "\" with ", _row_array, " (old=", _db_by_guid[$ _guid], ")");
                    }
                    
                    //Add this definition by GUID to our by-GUID database
                    _db_by_guid[$ _guid] = _row_array;
                }
            }
        }
        
        ++_y;
    }
    
    __input_trace(_total_count, " controller definitions found, of which ", _platform_count, " are active for this platform");
    __input_trace("Loaded in ", (get_timer() - _t)/1000, "ms");
    
    return true;
}
