// Feather disable all
/// @desc    Returns the multiplayer parameters set by input_join_params_set()

function input_join_params_get()
{
    __INPUT_GLOBAL_STATIC_LOCAL  //Set static _global
    
    static _result = {};
    _result.min_players    = _global.__join_player_min;
    _result.max_players    = _global.__join_player_max;
    _result.leave_verb     = _global.__join_leave_verb;
    _result.abort_callback = _global.__join_abort_callback;
    _result.drop_down      = _global.__join_drop_down;
    return _result;
}
