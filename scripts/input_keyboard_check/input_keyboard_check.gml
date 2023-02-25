/// @desc    Checks if the given key is currently activated. Uses GameMaker's native key constants (int)
/// @param   binding

function input_keyboard_check(_binding)
{
    if (!_global.__keyboard_allowed) 
    {
        return false;
    }
    
    return keyboard_check(_binding);
}
