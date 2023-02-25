/// @desc    Returns the hotswap parameters set by input_hotswap_params_set()

function input_hotswap_params_get()
{
    __INPUT_GLOBAL_STATIC
    
    static _result = {};
    _result.callback = global.__input_hotswap_callback;
    return _result;
}