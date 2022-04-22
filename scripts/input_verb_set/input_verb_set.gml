/// @param verb
/// @param value
/// @param [playerIndex]
/// @param [analogue=true]

function input_verb_set(_verb, _value, _player_index = 0, _analogue = true)
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
    
    global.__input_players[_player_index].set_verb(_verb, _value, _analogue);
}