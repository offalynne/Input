/// @param source
/// @param arrayOfPlayerIndexes

function input_source_share(_source, _array)
{
	__input_initialize();
    __INPUT_VERIFY_SOURCE
    __INPUT_VERIFY_PLAYER_INDEX
    __INPUT_VERIFY_SOURCE_ASSIGNABLE
    
    __input_source_relinquish(_source);
    
    var _i = 0;
    repeat(array_length(_array))
    {
        var _player_index = _array[_i];
        __INPUT_VERIFY_PLAYER_INDEX
        
        with(global.__input_players[_player_index])
        {
            __sources_clear();
            __source_add(_source);
        }
        
        ++_i;
    }
}