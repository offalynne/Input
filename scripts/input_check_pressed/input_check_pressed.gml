// Feather disable all
/// @desc    Returns a boolean indicating whether the given verb was newly activated this frame (a button was pressed etc.)
///          If the keyword <all> is used then this function will return <true> if ANY verb whatsoever was newly activated
///          If an array of verbs is given then this function will return <true> if ANY of the verbs in the array were newly activated
///          If a buffer duration is specified then this function will return <true> if the verb has been newly active at any point within that timeframe
/// @param   {any} verb/array
/// @param   [playerIndex=0]
/// @param   [bufferDuration=0]

function input_check_pressed(_verb, _player_index = 0, _buffer_duration = 0)
{
    __INPUT_GLOBAL_STATIC_LOCAL  //Set static _global
    __INPUT_VERIFY_PLAYER_INDEX
    
    if (_verb == all)
    {
        return input_check_pressed(_global.__basic_verb_array, _player_index, _buffer_duration);
    }
    
    if (is_array(_verb))
    {
        var _i = 0;
        repeat(array_length(_verb))
        {
            if (input_check_pressed(_verb[_i], _player_index, _buffer_duration)) return true;
            ++_i;
        }
        
        return false;
    }
    
    __INPUT_GET_VERB_STRUCT
    
    if (_verb_struct.__inactive) return false;
    
    if (_buffer_duration <= 0)
    {
        return ((_global.__cleared)? false : _verb_struct.__press);
    }
    else
    {
        return ((_verb_struct.__press_time >= 0) && ((__input_get_time() - _verb_struct.__press_time) <= _buffer_duration));
    }
}
