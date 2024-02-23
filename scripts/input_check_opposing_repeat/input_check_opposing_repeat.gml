// Feather disable all
/// @desc    Returns the sign of the result of the negative and positive active verbs as re-triggered by a repeater behaviour
///          This function will not return <true> on the same frame a verb is activated (unless predelay is set to 0)
///          You'll probably want to combine this function with input_check_opposing_pressed()
/// @param   verbNegative
/// @param   verbPositive
/// @param   [playerIndex=0]
/// @param   [mostRecent]
/// @param   [delay]
/// @param   [predelay]

function input_check_opposing_repeat(_verb_negative, _verb_positive, _player_index = 0, _most_recent = INPUT_DEFAULT_OPPOSING_MOST_RECENT, _delay = INPUT_REPEAT_DEFAULT_DELAY, _predelay = INPUT_REPEAT_DEFAULT_PREDELAY)
{
    __INPUT_GLOBAL_STATIC_LOCAL  //Set static _global
    
    var _held_n = input_check(_verb_negative, _player_index);
    var _held_p = input_check(_verb_positive, _player_index);

    //Neither held
    if (!_held_n && !_held_p) return 0;

    //Both held
    if (_held_n && _held_p && !_most_recent) return 0;
    
    var _repeat_n = input_check_repeat(_verb_negative, _player_index, _delay, _predelay);
    var _repeat_p = input_check_repeat(_verb_positive, _player_index, _delay, _predelay);
    
    //Neither repeat
    if (!_repeat_n  && !_repeat_p) return 0;
    
    //Exclusive
    if (!_held_p) return ((_repeat_n && !input_check(_verb_positive, _player_index, _delay + _predelay))? -1 : 0);
    if (!_held_n) return ((_repeat_p && !input_check(_verb_negative, _player_index, _delay + _predelay))?  1 : 0);
    
    //Grab player verb struct
    var _player_verbs_struct = _global.__players[_player_index].__verb_state_dict;
    var _verb_struct_n = _player_verbs_struct[$ _verb_negative];
    var _verb_struct_p = _player_verbs_struct[$ _verb_positive];

    //Most recent
    if (_verb_struct_n.__press_time > _verb_struct_p.__press_time)
    {
        return (_repeat_n && !(input_check_pressed(_verb_positive, _player_index, _delay + _predelay))? -1 : 0);
    }
    else
    {
        return (_repeat_p && !(input_check_pressed(_verb_positive, _player_index, _delay + _predelay))? 1 : 0);
    }
    
    __input_error("Repeat opposing check unhandled");
}
