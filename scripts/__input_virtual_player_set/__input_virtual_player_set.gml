/// @param playerStruct

function __input_virtual_player_set(_playerStruct)
{
    __INPUT_GLOBAL_STATIC_LOCAL  //Set static _global
    
    if (_playerStruct != _global.__touch_player)
    {
        _global.__touch_player = _playerStruct;
        
        var _i = 0;
        repeat(array_length(_global.__virtual_array))
        {
            _global.__virtual_array[_i].__clear_state();
            ++_i;
        }
    }
}