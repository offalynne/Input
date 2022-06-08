/// @desc    Returns the multiplayer parameters set by input_multiplayer_params_set()

function input_multiplayer_params_get()
{
    __input_initialize();
    
    static _result = {};
    _result.min_players = global.__input_multiplayer_min;
    _result.max_players = global.__input_multiplayer_max;
    _result.drop_down   = global.__input_multiplayer_drop_down;
    return _result;
}