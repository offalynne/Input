/// @desc    Sets the .JOIN source mode parameters
///          
///          The leave verb allows a player to cancel the INPUT_SOURCE_MODE.JOIN source mode
///          (a.k.a. multiplayer source assignment). If you want to prevent a player from leaving
///          the session then set the leave verb to <undefined>
///          
///          The abort callback is executed when a player tries to abort the INPUT_SOURCE_MODE.JOIN
///          source mode. The callback should be set to a function or script to allow players to
///          abort the .JOIN source mode. If you wish to prevent players from aborting source
///          assignment for whatever reason then set the abort callback to <undefined>
/// 
///          You can set whether players should drop down into empty slots by setting the <dropDown>
///          argument to <true> or <false>. You may want to prevent dropping down when reassigning
///          sources during gameplay where you want player state to persist
///          
/// @param   min
/// @param   max
/// @param   leaveVerb
/// @param   abortCallback
/// @param   [dropDown=true]

function input_join_params_set(_min, _max, _leave_verb, _abort_callback, _drop_down = true)
{
    __INPUT_GLOBAL_STATIC_LOCAL  //Set static _global
    
    if (argument_count < 4)
    {
        __input_error("input_join_params_set() must be given at least 4 arguments");
    }
    
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
    
    if (!is_string(_leave_verb) && !is_undefined(_leave_verb))
    {
        __input_error("Multiplayer leave verb must be a string or <undefined>");
    }
    
    if (!is_method(_abort_callback) && !(is_numeric(_abort_callback) && script_exists(_abort_callback)) && !is_undefined(_abort_callback))
    {
        __input_error("Multiplayer abort callback must be a function, a script, or <undefined>");
    }
    
    _global.__join_player_min     = _min;
    _global.__join_player_max     = _max;
    _global.__join_leave_verb     = _leave_verb;
    _global.__join_abort_callback = _abort_callback;
    _global.__join_drop_down      = _drop_down;
}