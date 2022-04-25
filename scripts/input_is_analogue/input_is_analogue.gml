/// @param verb/array
/// @param [playerIndex]

function input_is_analogue(_verb, _player_index = 0)
{
    __INPUT_VERIFY_PLAYER_INDEX
    
    if (is_array(_verb))
    {
        var _i = 0;
        repeat(array_length(_verb))
        {
            if (input_is_analogue(_verb[_i], _player_index)) return true;
            ++_i;
        }
        
        return false;
    }
    
    __INPUT_GET_VERB_STRUCT
    
    return _verb_struct.analogue;
}