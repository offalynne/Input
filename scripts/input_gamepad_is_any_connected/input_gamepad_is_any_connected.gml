// Feather disable all
/// @desc    Returns whether any (non-blocked) gamepad is connected

function input_gamepad_is_any_connected()
{
    __INPUT_GLOBAL_STATIC_LOCAL  //Set static _global
    
    var _i = 0;
    repeat(array_length(_global.__gamepads))
    {
        if (input_gamepad_is_connected(_i)) return true;
        ++_i;
    }
    
    return false;
}
