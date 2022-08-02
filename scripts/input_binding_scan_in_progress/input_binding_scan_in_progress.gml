/// @desc    Returns whether the given player is currently scanning for bindings
/// @param   {Real} _player_index
/// @returns {Bool}

function input_binding_scan_in_progress(_player_index = 0)
{
    __input_initialize();
    __INPUT_VERIFY_PLAYER_INDEX
    
    with(global.__input_players[_player_index])
    {
        return (__rebind_state > 0);
    }
}