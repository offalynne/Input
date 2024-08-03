// Feather disable all
/// @desc    Returns parameters for binding scanning, as set by input_biding_scan_set_params()
/// 
/// @param   [playerIndex=0]

function input_binding_scan_params_get(_player_index = 0)
{
    __INPUT_GLOBAL_STATIC_LOCAL  //Set static _global
    __INPUT_VERIFY_PLAYER_INDEX
    
    with(_global.__players[_player_index])
    {
        return {
            __ignore_array:  is_struct(__rebind_ignore_struct)? variable_struct_get_names(__rebind_ignore_struct) : undefined,
            __allow_array:   is_struct(__rebind_allow_struct )? variable_struct_get_names(__rebind_allow_struct ) : undefined,
            __source_filter: __rebind_source_filter,
        }
    }
}
