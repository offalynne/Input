/// @param verbNegative
/// @param verbPositive
/// @param playerIndex=0
/// @param mostRecent=false

function input_value_opposing(_verb_negative, _verb_positive, _player_index = 0, _most_recent = false)
{
    var _opposing = input_check_opposing(_verb_negative, _verb_positive, _player_index, _most_recent);
    
    switch (_opposing)
    {
        case  0: return  0; break;
        case -1: return -input_value(_verb_negative, _player_index); break;
        case  1: return  input_value(_verb_positive, _player_index); break;
        default: __input_error("Value opposing check unhandled");    break;
    }
}