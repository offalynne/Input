// Feather disable all
/// @desc    Returns how long the current verb was held when released, the units of which is determined by INPUT_TIMER_MILLISECONDS
///          This function returns a value less than 0 if the verb is not active or was not released
/// @param   {any} verb/array
/// @param   [playerIndex=0]

function input_held_time_released(_verb, _player_index = 0)
{
    __INPUT_GLOBAL_STATIC_LOCAL  //Set static _global
    __INPUT_VERIFY_PLAYER_INDEX
    __INPUT_GET_VERB_STRUCT
    
    //Return a negative number if the verb is inactive, cleared, not released
    if (_verb_struct.__inactive || _global.__cleared || !_verb_struct.__release) return -1;
    
    return max(0, (INPUT_TIMER_MILLISECONDS? _global.__previous_current_time : _global.__frame - 1) - _verb_struct.__press_time);
}
