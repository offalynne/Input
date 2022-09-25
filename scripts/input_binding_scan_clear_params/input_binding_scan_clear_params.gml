/// @desc    Clears parameters for binding scanning to defaults
/// 
/// @param   [playerIndex=0]

function input_binding_scan_clear_params(_player_index = 0)
{
    __input_initialize();
    __INPUT_VERIFY_PLAYER_INDEX
    
    with(global.__input_players[_player_index])
    {
        __rebind_ignore_struct = undefined;
        __rebind_allow_struct  = undefined;
    }
}