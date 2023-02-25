/// @desc    Returns the current source mode, a member of the INPUT_SOURCE_MODE enum

function input_source_mode_get()
{
    __INPUT_GLOBAL_STATIC
    
    return global.__input_source_mode;
}