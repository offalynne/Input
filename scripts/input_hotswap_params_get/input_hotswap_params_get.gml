/// @desc    Returns the hotswap parameters set by input_hotswap_params_set()

function input_hotswap_params_get()
{
    __INPUT_GLOBAL_STATIC_LOCAL  //Set static _global
    
    static _result = {};
    _result.callback = _global.__hotswap_callback;
    return _result;
}