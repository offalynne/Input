/// @param verb/array
/// @param [playerIndex]

function input_value(_verb, _player_index = 0)
{
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