/// @desc    Returns a boolean indicating whether the given verb crossed a threshold this frame
///          If an array of verbs is given then this function will return <true> if ANY verb crossed a threshold
/// @param   verb/array
/// @param   tapDuration
/// @param   [tapThreshold=1]
/// @param   [playerIndex=0]

function input_check_tapped(_verb, _tap_duration, _tap_threshold = 1, _player_index = 0)
{
    __INPUT_VERIFY_PLAYER_INDEX
    
    if (is_array(_verb))
    {
        var _i = 0;
        repeat(array_length(_verb))
        {
            if (input_check_tapped(_verb[_i], _tap_threshold, _player_index)) return true;
            ++_i;
        }
        
        return false;
    }
    
    __INPUT_GET_VERB_STRUCT
    
    if (_verb_struct.__inactive || global.__input_cleared || !_verb_struct.held) return false;

    return ((_tap_duration >= (__input_get_time() - _verb_struct.press_time)) 
         && (_tap_threshold > _verb_struct.previous_value)
         && (_tap_threshold <= _verb_struct.value));
}
