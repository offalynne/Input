/// @desc    Returns the sign of the result of the negative and positive newly active verbs
/// @param   verbNegative
/// @param   verbPositive
/// @param   [playerIndex=0]
/// @param   [mostRecent=false]

function input_check_opposing_pressed(_verb_negative, _verb_positive, _player_index = 0, _most_recent = false)
{
    if (_most_recent)
    {
        return (input_check_pressed(_verb_positive, _player_index) - input_check_pressed(_verb_negative, _player_index));
    }
    else
    {
        var _pressed_n = input_check_pressed(_verb_negative, _player_index);
        var _pressed_p = input_check_pressed(_verb_positive, _player_index);

        if (!_pressed_n && !_pressed_p) return 0;
        
        var _held_n = input_check(_verb_negative, _player_index);
        var _held_p = input_check(_verb_positive, _player_index);

        return ((_pressed_p * !_held_n) - (_pressed_n * !_held_p));
    }
}