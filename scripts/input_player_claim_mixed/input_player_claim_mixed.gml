/// @param allowKeyboard
/// @param allowMouse
/// @param allowGamepads
/// @param [playerIndex]

function input_player_claim_mixed(_allow_keyboard, _allow_mouse, _allow_gamepads, _player_index = 0)
{
	__input_initialize();
    __INPUT_VERIFY_PLAYER_INDEX
    
    if (_allow_keyboard && !global.__input_any_keyboard_binding_defined)
    {
        __input_trace("Warning! Player ", _player_index, " cannot claim the keyboard, no keyboard bindings have been created");
        _allow_keyboard = false;
    }
    
    if (_allow_mouse && !global.__input_any_mouse_binding_defined)
    {
        __input_trace("Warning! Player ", _player_index, " cannot claim the mouse, no mouse bindings have been created");
        _allow_mouse = false;
    }
    
    if (_allow_gamepads && !global.__input_any_keyboard_binding_defined)
    {
        __input_trace("Warning! Player ", _player_index, " cannot claim gamepads, no gamepad bindings have been created");
        _allow_keyboard = false;
    }
    
    if (!_allow_keyboard && !_allow_mouse && !_allow_gamepads)
    {
        __input_error("At least one source type with bindings must be allowed");
    }
    
    input_player_clear_sources(all);
    
    if (_allow_keyboard || (_allow_mouse && INPUT_KEYBOARD_AND_MOUSE_ALWAYS_PAIRED)) global.__input_players[_player_index].__source_add(INPUT_SOURCE.KEYBOARD);
    if (_allow_mouse || (_allow_keyboard && INPUT_KEYBOARD_AND_MOUSE_ALWAYS_PAIRED)) global.__input_players[_player_index].__source_add(INPUT_SOURCE.MOUSE);
    if (_allow_gamepads) global.__input_players[_player_index].__source_add(INPUT_SOURCE.ALL_GAMEPADS);
}
