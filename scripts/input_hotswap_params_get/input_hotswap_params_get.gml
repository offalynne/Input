/// @desc    Returns the hotswap parameters set by input_hotswap_params_set()

function input_hotswap_params_get()
{
    __input_initialize();
    
    static _result = {};
    _result.callback = global.__input_hotswap_callback;
    return _result;
}