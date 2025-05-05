// Feather disable all
/// @desc    Returns last pressed verb from among the array of verbs provided
///          If no verb array is provided, all defined verbs will be check instead
/// @param   [verbArray=all]
/// @param   [playerIndex=0]
/// @param   [ignoreInactive=false]

function input_check_press_last(_verb_array = all, _player_index = 0, _ignore_inactive = false)
{
    __INPUT_GLOBAL_STATIC_LOCAL  //Set static _global
    __INPUT_VERIFY_PLAYER_INDEX
    
    var _verbs_struct = _global.__players[_player_index].__verb_state_dict;
    if (!is_array(_verb_array)) _verb_array = _global.__basic_verb_array;
    
    var _max_time = -1;
    var _max_verb = undefined;
    var _i = 0;
    repeat(array_length(_verb_array))
    {
        var _verb = _verb_array[_i];
        var _verb_struct = _verbs_struct[$ _verb];

        if (is_struct(_verb_struct))
        {
            if ((_verb_struct.__press_time > _max_time)
            &&  (!_ignore_inactive || !_verb_struct.__inactive))
            {
                _max_time = _verb_struct.__press_time;
                _max_verb = _verb;
            }
        }
        
        ++_i;
    }
    
    return _max_verb;
}
