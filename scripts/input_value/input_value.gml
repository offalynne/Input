/// @desc    Returns the analogue value that the verb is currently receiving
///          If the verb is not received analogue input, this function will return either 0 or 1
///          If an array of verbs is provided, this function will return the sum of all verb values
/// @param   verb/array
/// @param   [playerIndex=0]

function input_value(_verb, _player_index = 0)
{
    __INPUT_GLOBAL_STATIC_LOCAL  //Set static _global
    __INPUT_VERIFY_PLAYER_INDEX
    
    if (is_array(_verb))
    {
        var _sum = 0;
        
        var _i = 0;
        repeat(array_length(_verb))
        {
            _sum += input_value(_verb[_i], _player_index);
            ++_i;
        }
        
        return _sum;
    }
    
    __INPUT_GET_VERB_STRUCT
    
    if (_verb_struct.__inactive) return false;
    
    return _verb_struct.value;
}