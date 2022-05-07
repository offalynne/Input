/// @param state

function input_multidevice_set(_state)
{
	__input_initialize();
    
    if (_state != global.__input_multidevice_enable) {}
    
    global.__input_multidevice_enable = _state;
    input_player_claim(all, 0);
}