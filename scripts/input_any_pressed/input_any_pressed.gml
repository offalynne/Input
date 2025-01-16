// Feather disable all
/// @desc    Returns whether input is detected from any source

function input_any_pressed()
{
    __INPUT_GLOBAL_STATIC_LOCAL  //Set static _global
    
    if (_global.__cleared)
    {
        return false;
    }
    
    return input_source_detect_input(all, false);
}
