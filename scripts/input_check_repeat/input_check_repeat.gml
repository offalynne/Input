// Feather disable all
/// @desc    Returns if the verb has been re-triggered by a repeater behaviour
///          This function will not return <true> on the same frame a verb is activated (unless predelay is set to 0)
///          You'll probably want to combine this function with input_check_pressed().
/// @param   verb
/// @param   [playerIndex=0]
/// @param   [delay]
/// @param   [predelay]

function input_check_repeat(_verb, _player_index = 0, _delay = INPUT_REPEAT_DEFAULT_DELAY, _predelay = INPUT_REPEAT_DEFAULT_PREDELAY)
{
    __INPUT_GLOBAL_STATIC_LOCAL  //Set static _global
    __INPUT_VERIFY_PLAYER_INDEX
    __INPUT_GET_VERB_STRUCT
    
    if (_global.__cleared || _verb_struct.__inactive || !_verb_struct.__held) return false;
    
    var _time = __input_get_time() - _verb_struct.__press_time - _predelay;
    if (_time < 0) return false;
    
    var _prev_time = __input_get_previous_time() - _verb_struct.__press_time - _predelay;
    return (floor(_time / _delay) > floor(_prev_time / _delay));
}
