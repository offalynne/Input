/// @param arrayOfPlayerIndexes

function input_player_share_keyboard(_array)
{
	__input_initialize();
    __INPUT_VERIFY_PLAYER_INDEX
    
    if (!global.__input_any_keyboard_binding_defined)
    {
        __input_error("Players ", _array, " cannot share the keyboard, no keyboard bindings have been created");
    }
    
    __input_source_relinquish(INPUT_KEYBOARD);
    if (INPUT_KEYBOARD_AND_MOUSE_ALWAYS_PAIRED) __input_source_relinquish(INPUT_MOUSE);
    
    var _i = 0;
    repeat(array_length(_array))
    {
        with(global.__input_players[_i])
        {
            __sources_clear();
            __source_add(INPUT_KEYBOARD);
            if (INPUT_KEYBOARD_AND_MOUSE_ALWAYS_PAIRED) __source_add(INPUT_MOUSE);
        }
        
        ++_i;
    }
}
