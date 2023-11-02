// Feather disable all
/// @desc    Returns the analogue value of the given input (after applying SDL axis remapping)
/// @param   gamepadIndex
/// @param   GMconstant

function input_gamepad_value(_index, _gm)
{
    __INPUT_GLOBAL_STATIC_LOCAL  //Set static _global
    
    if (!_global.__game_input_allowed || !_global.__gamepad_allowed)
    {
        return 0.0;
    }
    
    return __input_gamepad_value_internal(_index, _gm);
}
