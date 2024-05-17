// Feather disable all
function __input_load_sdl2_from_string(_string)
{
    __INPUT_GLOBAL_STATIC_LOCAL  //Set static _global
    
    if (!__INPUT_SILENT) __input_trace("Loading SDL2 database from string \"", _string, "\"");    

    return __input_load_sdl2_from_string_internal(_string);
}
