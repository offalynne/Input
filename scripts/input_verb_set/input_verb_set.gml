/// @param verb
/// @param value
/// @param [playerIndex]

function input_verb_set()
{
    var _verb         = argument[0];
    var _value        = argument[1];
    var _player_index = ((argument_count > 2) && (argument[2] != undefined))? argument[2] : 0;
    
    if (_player_index < 0)
    {
        __input_error("Invalid player index provided (", _player_index, ")");
        return undefined;
    }
    
    if (_player_index >= INPUT_MAX_PLAYERS)
    {
        __input_error("Player index too large (", _player_index, " vs. ", INPUT_MAX_PLAYERS, ")\nIncrease INPUT_MAX_PLAYERS to support more players");
        return undefined;
    }
    
    global.__input_players[_player_index].set_verb(_verb, _value);
}