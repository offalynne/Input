function __input_trace()
{
    if (__INPUT_SILENT && argument0) return; //Suppressed and not forced
    
    var _string = "";
    var _i = 1;
    repeat(argument_count - 1)
    {
        _string += string(argument[_i]);
        ++_i;
    }
    
    show_debug_message("Input: " + _string);
    
    if (__INPUT_EXTERNAL_DEBUG_LOG)
    {
        var _file = file_text_open_append(_global.__debug_log);
        file_text_write_string(_file, _string);
        file_text_writeln(_file);
        file_text_close(_file);
    }
}