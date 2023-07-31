// Feather disable all
/// @desc    Sets the function to call when a player hotswaps their device
///          Set the callback to <undefined> to not call a function at all
/// @param   callback

function input_hotswap_params_set(_callback)
{
    __INPUT_GLOBAL_STATIC_LOCAL  //Set static _global
    
    if (!is_method(_callback) && !(is_numeric(_callback) && script_exists(_callback)) && !is_undefined(_callback))
    {
        __input_error("Hotswap callback must be a function, a script, or <undefined>");
    }
    
    _global.__hotswap_callback = _callback;
}
