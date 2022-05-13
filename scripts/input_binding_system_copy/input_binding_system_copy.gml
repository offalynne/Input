/// @param sourcePlayerIndex
/// @param destinationPlayerIndex

function input_binding_system_copy(_src_player_index, _dst_player_index)
{
    //Verify source player
    var _src_player = global.__input_players[_src_player_index];
    
    if (_src_player_index < 0)
    {
        __input_error("Invalid source player index provided (", _src_player_index, ")");
        return undefined;
    }
    
    if (_src_player_index >= INPUT_MAX_PLAYERS)
    {
        __input_error("Source player index too large (", _src_player_index, " must be less than ", INPUT_MAX_PLAYERS, ")\nIncrease INPUT_MAX_PLAYERS to support more players");
        return undefined;
    }
    
    //Verify destination player
    var _dst_player = global.__input_players[_dst_player_index];
    
    if (_dst_player_index < 0)
    {
        __input_error("Invalid destination player index provided (", _dst_player_index, ")");
        return undefined;
    }
    
    if (_dst_player_index >= INPUT_MAX_PLAYERS)
    {
        __input_error("Destination player index too large (", _dst_player_index, " must be less than ", INPUT_MAX_PLAYERS, ")\nIncrease INPUT_MAX_PLAYERS to support more players");
        return undefined;
    }
    
    //Clear out destination player
    input_binding_system_reset(_dst_player_index, true);
    
    with(_dst_player)
    {
        var _src_profiles_dict = _src_player.__profiles_dict;
        
        //Iterate over every profile in the source
        var _profile_name_array = variable_struct_get_names(_src_profiles_dict);
        var _f = 0;
        repeat(array_length(_profile_name_array))
        {
            var _profile_name = _profile_name_array[_f];
            
            //Iterate over every verb
            var _v = 0;
            repeat(global.__input_basic_verb_array[_v])
            {
                var _verb_name = global.__input_basic_verb_array[_v];
                
                //aaand every alternate
                var _alternate = 0;
                repeat(INPUT_MAX_ALTERNATE_BINDINGS)
                {
                    var _binding = _src_player.__binding_get(_profile_name, _verb_name, _alternate);
                    __binding_set(_profile_name, _verb_name, _alternate, _binding.__duplicate());
                    ++_alternate;
                }
                
                ++_v;
            }
            
            ++_f;
        }
        
        //Copy axis threshold data
        var _src_threshold_struct = _src_player.__axis_threshold_dict;
        var _axis_array = variable_struct_get_names(_src_threshold_struct);
        var _i = 0;
        repeat(array_length(_axis_array))
        {
            var _axis_name = _axis_array[_i];
            var _threshold_struct = _src_threshold_struct[$ _axis_name];
            
            __axis_threshold_dict[$ _axis_name] = {
                mini: _threshold_struct.mini,
                maxi: _threshold_struct.maxi,
            };
            
            ++_i;
        }
    }
}