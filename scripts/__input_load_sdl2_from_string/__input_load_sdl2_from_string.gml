function __input_load_sdl2_from_string(_string)
{
    __INPUT_GLOBAL_STATIC_LOCAL  //Set static _global
    
    if (!__INPUT_SILENT) __input_trace("Loading SDL2 database from string \"", _string, "\"");
    
    var _result;
    if (_global.__use_legacy_strings)
    {
        //Ensure the buffer has a null terminator
        var _buffer = buffer_create(string_byte_length(_string) + 1, buffer_fixed, 1);
        buffer_write(_buffer, buffer_string, _string);
        buffer_seek(_buffer, buffer_seek_start, 0);
    
        _result = __input_load_sdl2_from_buffer_legacy(_buffer);
    
        buffer_delete(_buffer);
    }
    else
    {
        //Simply use string functionality
        _result = __input_load_sdl2_from_string_internal(_string);
    }
    
    return _result;
}