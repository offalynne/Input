// Feather disable all
/// @desc    Returns the current source mode, a member of the INPUT_SOURCE_MODE enum

function input_source_mode_get()
{
    __INPUT_GLOBAL_STATIC_LOCAL  //Set static _global
    
    return _global.__source_mode;
}
