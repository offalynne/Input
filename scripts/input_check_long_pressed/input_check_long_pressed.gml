/// @desc    Returns a boolean indicating whether the given verb has crossed the long-hold threshold this frame
///          The long-hold threshold is defined by INPUT_LONG_DELAY
///          If an array of verbs is given then this function will return <true> if ANY verb has crossed the long-hold threshold this frame
///          If a buffer duration is specified then this function will return <true> if the verb has crossed the long-hold threshold at any point within that timeframe
/// @param   verb/array
/// @param   [playerIndex=0]
/// @param   [bufferDuration=0]

function input_check_long_pressed(_verb, _player_index = 0, _buffer_duration = 0)
{
    __INPUT_GLOBAL_STATIC_LOCAL  //Set static _global
    __INPUT_VERIFY_PLAYER_INDEX
    
    if (is_array(_verb))
    {
        var _i = 0;
        repeat(array_length(_verb))
        {
            if (input_check_long_pressed(_verb[_i], _player_index, _buffer_duration)) return true;
            ++_i;
        }
        
        return false;
    }
    
    __INPUT_GET_VERB_STRUCT
    
    if (_verb_struct.__inactive) return false;
    
    if (_buffer_duration <= 0)
    {
        return ((_global.__cleared)? false : _verb_struct.long_press);
    }
    else
    {
        return ((_verb_struct.long_press_time >= 0) && ((__input_get_time() - _verb_struct.long_press_time) <= _buffer_duration));
    }
}