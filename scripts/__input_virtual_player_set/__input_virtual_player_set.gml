/// @param playerStruct

function __input_virtual_player_set(_playerStruct)
{
    if (_playerStruct != global.__input_touch_player)
    {
        global.__input_touch_player = _playerStruct;
        
        var _i = 0;
        repeat(array_length(global.__input_virtual_array))
        {
            global.__input_virtual_array[_i].__clear_state();
            ++_i;
        }
    }
}