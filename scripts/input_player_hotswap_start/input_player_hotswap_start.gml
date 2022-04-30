/// @param [playerIndex=0]

function input_player_hotswap_start(_player_index = 0)
{
    __input_initialize();
    __INPUT_VERIFY_PLAYER_INDEX
    
    global.__input_player_hotswap = _player_index;
}