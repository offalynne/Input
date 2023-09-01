// Feather disable all

/// @desc    Checks if the given key is currently activated. Uses GameMaker's native key constants (int)
/// @param   binding

function input_keyboard_check(_binding)
{
    __INPUT_GLOBAL_STATIC_LOCAL  //Set static _global
    
    if (!_global.__keyboard_allowed) 
    {
        return false;
    }
    
    return keyboard_check(_binding);
}
