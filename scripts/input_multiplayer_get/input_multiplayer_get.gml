function input_multiplayer_get()
{
    __input_initialize();
    
    static _result = {};
    _result.min       = global.__input_multiplayer_min;
    _result.max       = global.__input_multiplayer_max;
    _result.drop_down = global.__input_multiplayer_drop_down;
    return _result;
}