/// @param state

function input_hotswap_set(_state)
{
	__input_initialize();
    
    if (_state != global.__input_hotswap_enable) {}
    
    global.__input_hotswap_enable = _state;
}