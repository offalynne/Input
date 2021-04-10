/// @param verbA
/// @param alternateA
/// @param verbB
/// @param alternateB
/// @param [source]
/// @param [playerIndex]

function input_binding_swap()
{
    var _verb_a       = argument[0];
    var _alternate_a  = argument[1];
    var _verb_b       = argument[2];
    var _alternate_b  = argument[3];
    var _source       = (argument_count > 4)? argument[4] : undefined;
    var _player_index = ((argument_count > 5) && (argument[5] != undefined))? argument[5] : 0;
    
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
    
    if (_source == undefined) _source = global.__input_players[_player_index].source;
    
    var _binding_a = input_binding_get(_verb_a, _source, _player_index, _alternate_a);
    var _binding_b = input_binding_get(_verb_b, _source, _player_index, _alternate_b);
    
    if (_binding_a == undefined)
    {
        input_binding_remove(_verb_a, _source, _player_index, _alternate_a);
    }
    else
    {
        input_binding_set(_verb_a, _binding_b, _player_index, _alternate_a);
    }
    
    if (_binding_b == undefined)
    {
        input_binding_remove(_verb_b, _source, _player_index, _alternate_b);
    }
    else
    {
        input_binding_set(_verb_b, _binding_a, _player_index, _alternate_b);
    }
}