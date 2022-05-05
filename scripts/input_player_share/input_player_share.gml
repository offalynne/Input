/// @param source
/// @param arrayOfPlayerIndexes

function input_player_share(_source, _array)
{
	__input_initialize();
    __INPUT_VERIFY_SOURCE
    __INPUT_VERIFY_PLAYER_INDEX
    __INPUT_VERIFY_SOURCE_ASSIGNABLE
    
    __input_source_relinquish(_source);
    
    if (INPUT_KEYBOARD_AND_MOUSE_ALWAYS_PAIRED)
    {
        if (_source == INPUT_KEYBOARD) __input_source_relinquish(INPUT_MOUSE);
        if (_source == INPUT_MOUSE) __input_source_relinquish(INPUT_KEYBOARD);
    }
    
    var _i = 0;
    repeat(array_length(_array))
    {
        var _player_index = _array[_i];
        __INPUT_VERIFY_PLAYER_INDEX
        
        with(global.__input_players[_player_index])
        {
            __sources_clear();
            
            __source_add(_source);
            
            if (INPUT_KEYBOARD_AND_MOUSE_ALWAYS_PAIRED)
            {
                if (_source == INPUT_KEYBOARD) __source_add(INPUT_MOUSE);
                if (_source == INPUT_MOUSE) __source_add(INPUT_KEYBOARD);
            }
        }
        
        ++_i;
    }
}
