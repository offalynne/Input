/// @param verb/array
/// @param [playerIndex]

function input_held_time(_verb, _player_index = 0)
{
    __INPUT_VERIFY_PLAYER_INDEX
    __INPUT_GET_VERB_STRUCT
    
    //Return a negative number if the verb is inactive
    if (_verb_struct.consumed || !_verb_struct.held) return -1;
    
    return (__input_get_time() - _verb_struct.press_time);
}