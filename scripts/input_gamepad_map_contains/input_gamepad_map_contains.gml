// Feather disable all
/// @desc    Returns if the indicated buttons/axes are mapped for the current gamepad
/// @param   gamepadIndex
/// @param   {Constant.GamepadAxis|Constant.GamepadButton} GMconstant/array

function input_gamepad_map_contains(_index, _gm)
{
    __INPUT_GLOBAL_STATIC_LOCAL  //Set static _global
    
    if ((_index == undefined)
    ||  (_index < 0)
    ||  (_index >= array_length(_global.__gamepads)))
    {
        return false;
    }
    
    var _gamepad = _global.__gamepads[_index];
    if (!is_struct(_gamepad)) return false;
    
    if not (is_array(_gm)) _gm = [_gm];    
    
    var _i = 0;
    repeat(array_length(_gm))
    {
        if ((input_gamepad_constant_get_name(_gm[_i]) == "unknown")
        ||  (_gamepad.__mapping_gm_to_raw[$ _gm[_i]] == undefined))
        {
            return false;
        }
        
        ++_i;
    }
    
    return true;
}
