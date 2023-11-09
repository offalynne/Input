// Feather disable all
//// @desc    Returns an array of players using the indicated source(s)
//// @param   source

function input_players_using_source(_sources)
{
    static _result = [];
    array_resize(_result, 0);
    
    __INPUT_GLOBAL_STATIC_LOCAL  //Set static _global    
    
    if (not is_array(_sources))
    {
        _sources = [_sources];
    }
        
    var _source_index = 0;
    var _source = undefined;
    
    var _player_index = 0;
    repeat(INPUT_MAX_PLAYERS)
    {
        if (_global.__players[_player_index].__connected)
        {
            _source_index = 0;
            repeat(array_length(_sources))
            {
                _source = _sources[_source_index];            
                if (_source != INPUT_GAMEPAD)
                {
                    __INPUT_VERIFY_SOURCE
                }
                
                if (_global.__players[_player_index].__source_contains(_source))
                {
                    array_push(_result, _player_index);
                    break;
                }
                
                ++_source_index;
            }
        }
            
        ++_player_index;
    }
    
    return _result;
}
