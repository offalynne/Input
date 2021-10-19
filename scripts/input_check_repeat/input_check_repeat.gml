/// @param verb/array
/// @param [playerIndex]
/// @param [delay]
/// @param [predelay]

function input_check_repeat(_verb, _player_index = 0, _delay = INPUT_REPEAT_DEFAULT_DELAY, _predelay = INPUT_REPEAT_DEFAULT_PREDELAY)
{
    if (_player_index < 0)
    {
        __input_error("Invalid player index provided (", _player_index, ")");
        return undefined;
    }
    
    if (_player_index >= INPUT_MAX_PLAYERS)
    {
        __input_error("Player index too large (", _player_index, " must be less than ", INPUT_MAX_PLAYERS, ")\nIncrease INPUT_MAX_PLAYERS to support more players");
        return undefined;
    }
    
    var _verb_struct = global.__input_players[_player_index].verbs[$ _verb];
    if (!is_struct(_verb_struct))
    {
        __input_error("Verb not recognised (", _verb, ")");
        return undefined;
    }
    
    if (_verb_struct.consumed) return false;
    if (!_verb_struct.held) return false;
    
    var _time = __input_get_time() - _verb_struct.press_time - _predelay;
    if (_time < 0) return false;
    
    var _prev_time = __input_get_previous_time() - _verb_struct.press_time - _predelay;
    return (floor(_time / _delay) > floor(_prev_time / _delay));
}