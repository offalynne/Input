/// @param [playerIndex=0]

function input_binding_scan_abort(_player_index = 0)
{
    __input_initialize();
    __INPUT_VERIFY_PLAYER_INDEX
    
    with(global.__input_players[_player_index])
    {
        if (__rebind_state > 0) __binding_scan_failure(INPUT_BINDING_SCAN_EVENT.ABORTED);
    }
}