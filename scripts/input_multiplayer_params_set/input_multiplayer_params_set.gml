/// @desc    Sets the multiplayer parameters, typically for use with the JOIN source mode
/// @param   min
/// @param   max
/// @param   [dropDown=true]
/// @param   [allowAbort=true]

function input_multiplayer_params_set(_min, _max, _drop_down = true, _allow_abort = true)
{
    __input_initialize();
    
    if (_max < 1)
    {
        __input_error("Invalid maximum player count provided (", _max, ")");
        return undefined;
    }
    
    if (_max > INPUT_MAX_PLAYERS)
    {
        __input_error("Maximum player count too large (", _max, " must not be greater than ", INPUT_MAX_PLAYERS, ")\nIncrease INPUT_MAX_PLAYERS to support more players");
        return undefined;
    }
    
    if (_min < 1)
    {
        __input_error("Invalid minimum player count provided (", _min, ")");
        return undefined;
    }
    
    if (_min > _max)
    {
        __input_error("Minimum player count larger than maximum (", _min, " must be less than ", _max, ")");
        return undefined;
    }
    
    global.__input_multiplayer_min         = _min;
    global.__input_multiplayer_max         = _max;
    global.__input_multiplayer_drop_down   = _drop_down;
    global.__input_multiplayer_allow_abort = _allow_abort;
}