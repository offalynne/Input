/// @param verb/array
/// @param [playerIndex]

function input_held_time(_verb, _player_index = 0)
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
    
    //Return a negative number if the verb is inactive
    if (_verb_struct.consumed || !_verb_struct.held) return -1;
    
    return (__input_get_time() - _verb_struct.press_time);
}