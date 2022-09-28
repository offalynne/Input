/// @desc    Returns parameters for binding scanning, as set by input_biding_scan_set_params()
/// 
/// @param   [playerIndex=0]

function input_binding_scan_get_params(_player_index = 0)
{
    __input_initialize();
    __INPUT_VERIFY_PLAYER_INDEX
    
    with(global.__input_players[_player_index])
    {
        return {
            ignore_array: is_struct(__rebind_ignore_struct)? variable_struct_get_names(__rebind_ignore_struct) : undefined,
            allow_array:  is_struct(__rebind_allow_struct )? variable_struct_get_names(__rebind_allow_struct ) : undefined,
        }
    }
}