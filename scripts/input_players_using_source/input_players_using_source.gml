// Feather disable all
/// @desc    Returns an array of players using the indicated source(s)
/// 
/// @param   source
/// @param   [firstPlayer=false]

function input_players_using_source(_sources, _first_player = false)
{
    __INPUT_GLOBAL_STATIC_LOCAL  //Set static _global    
    static _result = [];
    
    //Don't mess with the results array if we're not going to return an array
    if (not _first_player)
    {
        array_resize(_result, 0);
    }
    
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
                    //Early-out if we just want the first player
                    if (_first_player) return _player_index;
                    
                    array_push(_result, _player_index);
                    break;
                }
                
                ++_source_index;
            }
        }
            
        ++_player_index;
    }
    
    //Return <undefined> specifically if we're only looking for the first player
    return _first_player? undefined : _result;
}
