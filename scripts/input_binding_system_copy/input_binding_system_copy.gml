/// @param source
/// @param destination

function input_binding_system_copy(_player_index_s, _player_index_d)
{
    if (is_struct(_player_index_s))
    {
        var _player_s = _player_index_s;
    }
    else
    {
        var _player_s = global.__input_players[_player_index_s];
        
        if (_player_index_s < 0)
        {
            __input_error("Invalid source player index provided (", _player_index_s, ")");
            return undefined;
        }
        
        if (_player_index_s >= INPUT_MAX_PLAYERS)
        {
            __input_error("Source player index too large (", _player_index_s, " must be less than ", INPUT_MAX_PLAYERS, ")\nIncrease INPUT_MAX_PLAYERS to support more players");
            return undefined;
        }
    }
    
    if (is_struct(_player_index_d))
    {
        var _player_d = _player_index_d;
    }
    else
    {
        var _player_d = global.__input_players[_player_index_d];
        
        if (_player_index_d < 0)
        {
            __input_error("Invalid destination player index provided (", _player_index_d, ")");
            return undefined;
        }
        
        if (_player_index_d >= INPUT_MAX_PLAYERS)
        {
            __input_error("Destination player index too large (", _player_index_d, " must be less than ", INPUT_MAX_PLAYERS, ")\nIncrease INPUT_MAX_PLAYERS to support more players");
            return undefined;
        }
    }
    
    with(_player_d)
    {
        sources = array_create(array_length(global.__input_profile_name_array), undefined);
        
        var _source = 0;
        repeat(array_length(global.__input_profile_name_array))
        {
            var _profile_name = global.__input_profile_name_array[_source];
            
            var _source_verb_struct = _player_s.__profiles_dict[$ _profile_name];
            if (is_struct(_source_verb_struct))
            {
                var _verb_names = variable_struct_get_names(_source_verb_struct);
                var _v = 0;
                repeat(array_length(_verb_names))
                {
                    var _verb = _verb_names[_v];
                    var _alternate_array = _source_verb_struct[$ _verb];
                    if (is_array(_alternate_array))
                    {
                        var _alternate = 0;
                        repeat(array_length(_alternate_array))
                        {
                            var _binding = _alternate_array[_alternate];
                            if (is_struct(_binding)) __binding_set(_verb, _alternate, _binding.__duplicate());
                            ++_alternate;
                        }
                    }
                    
                    ++_v;
                }
            }
            
            ++_source;
        }
    }
}