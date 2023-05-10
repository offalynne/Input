function __input_load_sdl2_from_file(_filename)
{
    if (!__INPUT_SILENT) __input_trace("Loading SDL2 database from \"", _filename, "\"");
    
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
