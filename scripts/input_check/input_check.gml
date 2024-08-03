// Feather disable all
/// @desc    Returns a boolean indicating whether the given verb is currently active (a button is being held etc.)
///          If the keyword <all> is used then this function will return <true> if ANY verb whatsoever is active
///          If an array of verbs is given then this function will return <true> if ANY of the verbs in the array are active
///          If a buffer duration is specified then this function will return <true> if the verb has been active at any point within that timeframe
/// @param   {any} verb/array
/// @param   [playerIndex=0]
/// @param   [bufferDuration=0]

function input_check(_verb, _player_index = 0, _buffer_duration = 0)
{
    __INPUT_GLOBAL_STATIC_LOCAL  //Set static _global
    __INPUT_VERIFY_PLAYER_INDEX
    
    if (_verb == all)
    {
        return input_check(_global.__basic_verb_array, _player_index, _buffer_duration);
    }
    
    if (is_array(_verb))
    {
        var _i = 0;
        repeat(array_length(_verb))
        {
            if (input_check(_verb[_i], _player_index, _buffer_duration)) return true;
            ++_i;
        }
        
        return false;
    }
    
    __INPUT_GET_VERB_STRUCT
    
    if (_verb_struct.__inactive) return false;
    
    if (_buffer_duration <= 0)
    {
        return _verb_struct.__held;
    }
    else
    {
        return ((_verb_struct.__held_time >= 0) && ((__input_get_time() - _verb_struct.__held_time) <= _buffer_duration));
    }
}
