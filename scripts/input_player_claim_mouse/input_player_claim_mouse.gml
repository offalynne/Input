/// @param [playerIndex]

function input_player_claim_mouse(_player_index = 0)
{
	__input_initialize();
    __INPUT_VERIFY_PLAYER_INDEX
    
    if (!global.__input_mouse_default_defined)
    {
        __input_error("Player ", _player_index, " cannot claim the mouse, no mouse bindings have been created");
    }
    
    __input_source_relinquish(INPUT_SOURCE.MOUSE);
    global.__input_players[_player_index].__add_source(INPUT_SOURCE.MOUSE);
    
    if (INPUT_KEYBOARD_AND_MOUSE_ALWAYS_PAIRED)
    {
        __input_source_relinquish(INPUT_SOURCE.KEYBOARD);
        global.__input_players[_player_index].__add_source(INPUT_SOURCE.KEYBOARD);
    }
}
