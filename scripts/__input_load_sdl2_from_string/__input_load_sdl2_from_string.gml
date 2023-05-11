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