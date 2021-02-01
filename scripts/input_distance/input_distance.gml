/// @param leftVerb
/// @param rightVerb
/// @param upVerb
/// @param downVerb
/// @param [playerIndex]
/// @param [minThreshold]
/// @param [maxThreshold]

function input_distance()
{
    var _verb_l        = argument[0];
    var _verb_r        = argument[1];
    var _verb_u        = argument[2];
    var _verb_d        = argument[3];
    var _player_index  = ((argument_count > 4) && (argument[4] != undefined))? argument[4] : 0;
    var _min_threshold = ((argument_count > 5) && (argument[5] != undefined))? argument[5] : INPUT_DEFAULT_MIN_THRESHOLD;
    var _max_threshold = ((argument_count > 6) && (argument[6] != undefined))? argument[6] : INPUT_DEFAULT_MAX_THRESHOLD;
    
    if (_player_index < 0)
    {
        __input_error("Invalid player index provided (", _player_index, ")");
        return undefined;
    }
    
    if (_player_index >= INPUT_MAX_PLAYERS)
    {
        __input_error("Player index too large (", _player_index, " vs. ", INPUT_MAX_PLAYERS, ")\nIncrease INPUT_MAX_PLAYERS to support more players");
        return undefined;
    }
    
    var _player_verbs_struct = global.__input_players[_player_index].verbs;
    
    var _verb_struct_l = _player_verbs_struct[$ _verb_l];
    var _verb_struct_r = _player_verbs_struct[$ _verb_r];
    var _verb_struct_u = _player_verbs_struct[$ _verb_u];
    var _verb_struct_d = _player_verbs_struct[$ _verb_d];
    
    if (!is_struct(_verb_struct_l)) __input_error("Left verb not recognised (", _verb_l, ")");
    if (!is_struct(_verb_struct_r)) __input_error("Right verb not recognised (", _verb_r, ")");
    if (!is_struct(_verb_struct_u)) __input_error("Up verb not recognised (", _verb_u, ")");
    if (!is_struct(_verb_struct_d)) __input_error("Down verb not recognised (", _verb_d, ")");
    
    var _value_l = _verb_struct_l.consumed? 0.0 : _verb_struct_l.raw;
    var _value_r = _verb_struct_r.consumed? 0.0 : _verb_struct_r.raw;
    var _value_u = _verb_struct_u.consumed? 0.0 : _verb_struct_u.raw;
    var _value_d = _verb_struct_d.consumed? 0.0 : _verb_struct_d.raw;
    
    if (((_value_l > 0.0) && !_verb_struct_l.raw_analogue)
    ||  ((_value_r > 0.0) && !_verb_struct_r.raw_analogue)
    ||  ((_value_u > 0.0) && !_verb_struct_u.raw_analogue)
    ||  ((_value_d > 0.0) && !_verb_struct_d.raw_analogue))
    {
        if (_verb_struct_u.raw_analogue) _value_u = 0.0;
        if (_verb_struct_d.raw_analogue) _value_d = 0.0;
        if (_verb_struct_l.raw_analogue) _value_l = 0.0;
        if (_verb_struct_r.raw_analogue) _value_r = 0.0;
    }
    
    var _dx = _value_r - _value_l;
    var _dy = _value_d - _value_u;
    var _d = sqrt(_dx*_dx + _dy*_dy);
    _d = clamp((_d - _min_threshold) / (_max_threshold - _min_threshold), 0.0, 1.0);
        
    return _d;
}