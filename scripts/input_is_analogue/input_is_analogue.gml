// Feather disable all
/// @desc    Returns whether the given verb is currently received analogue input (e.g. from a gamepad thumbstick)
///          If an array of verbs is provided, this function will return <true> if ANY of the verbs have analogue input
/// @param   {any} verb/array
/// @param   [playerIndex=0]

function input_is_analogue(_verb, _player_index = 0)
{
    __INPUT_GLOBAL_STATIC_LOCAL  //Set static _global
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
    
    return _verb_struct.__analogue;
}
