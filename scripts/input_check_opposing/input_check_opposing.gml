// Feather disable all
/// @desc    Returns the sign of the result of the negative and positive active verbs
/// @param   verbNegative
/// @param   verbPositive
/// @param   [playerIndex=0]
/// @param   [mostRecent]

function input_check_opposing(_verb_negative, _verb_positive, _player_index = 0, _most_recent = INPUT_DEFAULT_OPPOSING_MOST_RECENT)
{
    __INPUT_GLOBAL_STATIC_LOCAL  //Set static _global
    
    var _held_n = input_check(_verb_negative, _player_index);
    var _held_p = input_check(_verb_positive, _player_index);
    
    //Neither
    if (!_held_n && !_held_p) return 0;
    
    //Both
    if (_held_n && _held_p && !_most_recent) return 0;
        
    //Exclusive
    if (!_held_p) return (_held_n? -1 : 0);
    if (!_held_n) return (_held_p?  1 : 0);
    
    //Grab player verb struct
    var _player_verbs_struct = _global.__players[_player_index].__verb_state_dict;
    var _verb_struct_n = _player_verbs_struct[$ _verb_negative];
    var _verb_struct_p = _player_verbs_struct[$ _verb_positive];

    //Most recent
    if (_verb_struct_n.__press_time > _verb_struct_p.__press_time)
    {
        return (_held_n? -1 : 0);
    }
    else
    {
        return (_held_p? 1 : 0);
    }
    
    __input_error("Opposing check unhandled");
}
