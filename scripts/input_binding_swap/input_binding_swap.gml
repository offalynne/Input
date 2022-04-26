/// @param verbA
/// @param alternateA
/// @param verbB
/// @param alternateB
/// @param [source]
/// @param [playerIndex]

function input_binding_swap(_verb_a, _alternate_a, _verb_b, _alternate_b, _source = undefined, _player_index = 0)
{
	__input_initialize();
    __INPUT_VERIFY_PLAYER_INDEX
    
    //Ensure that we have the correct config category for this source for this player
    var _config_name = global.__input_players[_player_index].__get_config_name_from_source(_source);
    
    var _binding_a = input_binding_get(_verb_a, _config_name, _player_index, _alternate_a);
    var _binding_b = input_binding_get(_verb_b, _config_name, _player_index, _alternate_b);
    
    if (_binding_b == undefined)
    {
        input_binding_remove(_verb_a, _config_name, _player_index, _alternate_a);
    }
    else
    {
        input_binding_set(_verb_a, _binding_b, _player_index, _alternate_a);
    }
    
    if (_binding_a == undefined)
    {
        input_binding_remove(_verb_b, _config_name, _player_index, _alternate_b);
    }
    else
    {
        input_binding_set(_verb_b, _binding_a, _player_index, _alternate_b);
    }
}