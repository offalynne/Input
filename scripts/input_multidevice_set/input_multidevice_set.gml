/// @param [playerIndex=0]

function input_multidevice_set(_player_index = 0)
{
	__input_initialize();
    __INPUT_VERIFY_PLAYER_INDEX
    
    global.__input_multidevice_player = _player_index;
    input_player_claim(all, _player_index);
}
