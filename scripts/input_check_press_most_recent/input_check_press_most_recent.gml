/// @desc    Returns the most recently pressed verb from among the array of verbs provided
///          If no verb array is provided, all defined verbs will be check instead
/// @param   [verbArray=all]
/// @param   [playerIndex=0]

function input_check_press_most_recent(_verb_array = all, _player_index = 0)
{
    __INPUT_VERIFY_PLAYER_INDEX
    
    var _verbs_struct = global.__input_players[_player_index].__verb_state_dict;
    if (!is_array(_verb_array)) _verb_array = global.__input_basic_verb_array;
    
    var _max_time = -1;
    var _max_verb = undefined;
    var _i = 0;
    repeat(array_length(_verb_array))
    {
        var _verb = _verb_array[_i];
        var _verb_struct = _verbs_struct[$ _verb];
        
        if ((_verb_struct.press_time > _max_time) && input_check(_verb, _player_index))
        {
            _max_time = _verb_struct.press_time;
            _max_verb = _verb;
        }
        
        ++_i;
    }
    
    return _max_verb;
}