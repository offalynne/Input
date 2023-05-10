function __input_load_sdl2_from_file(_filename)
{
    __INPUT_GLOBAL_STATIC_LOCAL  //Set static _global
    
    if (!__INPUT_SILENT)__input_trace("Loading SDL2 database from \"", _filename, "\"");
    
    var _buffer = buffer_load(_filename);
    if (_buffer < 0)
    {
        show_message("Could not load external SDL2 database \"" + string(_filename) + "\"");
        return false;
    }
    
    var _result;
    if (_global.__use_legacy_strings)
    {
        //Ensure the buffer has a null terminator
        buffer_resize(_buffer, buffer_get_size(_buffer) + 1);
    
        _result = __input_load_sdl2_from_buffer_legacy(_buffer);
        
        buffer_delete(_buffer);
    }
    else
    {
        //In case of manual editing, skip UTF-8 BOM
        if ((buffer_get_size(_buffer) >= 4) && ((buffer_peek(_buffer, 0, buffer_u32) & 0xFFFFFF) == 0xBFBBEF))
        {
            buffer_seek(_buffer, buffer_seek_start, 3);
        }
        
        //Read file as text
        var _string = buffer_read(_buffer, buffer_text);
        buffer_delete(_buffer);
        
        _result = __input_load_sdl2_from_string_internal(_string);
    }
    
    return _result;
}
