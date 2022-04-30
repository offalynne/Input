/// @param gampead
/// @param arrayOfPlayerIndexes

function input_player_share_gamepad(_gamepad, _array)
{
	__input_initialize();
    __INPUT_VERIFY_PLAYER_INDEX
    
    if (!global.__input_any_gamepad_binding_defined)
    {
        __input_error("Players ", _array, " cannot share gamepad ", _gamepad, ", no keyboard bindings have been created");
    }
    
    __input_source_relinquish(INPUT_SOURCE.GAMEPAD, _gamepad);
    
    var _i = 0;
    repeat(array_length(_array))
    {
        with(global.__input_players[_player_index])
        {
            __sources_clear();
            __source_add(INPUT_SOURCE.GAMEPAD, _gamepad);
        }
        
        ++_i;
    }
}
