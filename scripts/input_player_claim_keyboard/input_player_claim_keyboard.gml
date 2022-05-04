/// @param [playerIndex]

function input_player_claim_keyboard(_player_index = 0)
{
	__input_initialize();
    __INPUT_VERIFY_PLAYER_INDEX
    
    if (!global.__input_any_keyboard_binding_defined)
    {
        __input_error("Player ", _player_index, " cannot claim the keyboard, no keyboard bindings have been created");
    }
    
    __input_source_relinquish(INPUT_KEYBOARD);
    global.__input_players[_player_index].__source_add(INPUT_KEYBOARD);
    
    if (INPUT_KEYBOARD_AND_MOUSE_ALWAYS_PAIRED)
    {
        __input_source_relinquish(INPUT_MOUSE);
        global.__input_players[_player_index].__source_add(INPUT_MOUSE);
    }
}
