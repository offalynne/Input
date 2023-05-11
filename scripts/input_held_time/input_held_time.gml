/// @desc    Returns how long the current verb has been held for, the units of which is determined by INPUT_TIMER_MILLISECONDS
///          This function returns 0 if the verb has been activated on the current frame
///          It will return a value less than 0 if the verb is not active at all
/// @param   verb/array
/// @param   [playerIndex=0]

function input_held_time(_verb, _player_index = 0)
{
    __INPUT_GLOBAL_STATIC_LOCAL  //Set static _global
    __INPUT_VERIFY_PLAYER_INDEX
    __INPUT_GET_VERB_STRUCT
    
    //Return a negative number if the verb is inactive
    if (_verb_struct.__inactive || !_verb_struct.held) return -1;
    
    return (__input_get_time() - _verb_struct.press_time);
}