/// @desc    Sets the function to call when a player hotswaps their device
///          Set the callback to <undefined> to not call a function at all
/// @param   callback

function input_hotswap_params_set(_callback)
{
    __input_initialize();
    
    if (!is_method(_callback) && !(is_numeric(_callback) && script_exists(_callback)) && !is_undefined(_callback))
    {
        __input_error("Hotswap callback must be a function, a script, or <undefined>");
    }
    
    global.__input_hotswap_callback = _callback;
}