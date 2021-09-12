/// @param verbA
/// @param alternateA
/// @param verbB
/// @param alternateB
/// @param [source]
/// @param [playerIndex]

function input_binding_swap(_verb_a, _alternate_a, _verb_b, _alternate_b, _source = undefined, _player_index = 0)
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
    
    //Ensure that we have the correct config category for this source for this player
    var _config_category = global.__input_players[_player_index].convert_source_enum_to_config_category(_source);
    
    var _binding_a = input_binding_get(_verb_a, _config_category, _player_index, _alternate_a);
    var _binding_b = input_binding_get(_verb_b, _config_category, _player_index, _alternate_b);
    
    if (_binding_b == undefined)
    {
        input_binding_remove(_verb_a, _config_category, _player_index, _alternate_a);
    }
    else
    {
        input_binding_set(_verb_a, _binding_b, _player_index, _alternate_a);
    }
    
    if (_binding_a == undefined)
    {
        input_binding_remove(_verb_b, _config_category, _player_index, _alternate_b);
    }
    else
    {
        input_binding_set(_verb_b, _binding_a, _player_index, _alternate_b);
    }
}