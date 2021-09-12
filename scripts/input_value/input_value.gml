/// @param verb/array
/// @param [playerIndex]

function input_value(_verb, _player_index = 0)
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
    
    if (is_array(_verb))
    {
        var _sum = 0;
        
        var _i = 0;
        repeat(array_length(_verb))
        {
            _sum += input_value(_verb[_i], _player_index);
            ++_i;
        }
        
        return _sum;
    }
    
    var _verb_struct = global.__input_players[_player_index].verbs[$ _verb];
    if (!is_struct(_verb_struct))
    {
        __input_error("Verb not recognised (", _verb, ")");
        return undefined;
    }
    
    if (_verb_struct.consumed) return false;
    
    return _verb_struct.value;
}