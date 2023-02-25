/// @desc    Returns the current source mode, a member of the INPUT_SOURCE_MODE enum

function input_source_mode_get()
{
    static _global = _input_state();
    
    return global.__input_source_mode;
}