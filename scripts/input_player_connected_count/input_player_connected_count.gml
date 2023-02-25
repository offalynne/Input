/// @desc    Returns he number of players with connected devices

function input_player_connected_count()
{
    __INPUT_GLOBAL_STATIC_LOCAL  //Set static _global
    
    var _count = 0;
    var _p = 0;
    repeat(INPUT_MAX_PLAYERS)
    {
        if (_global.__players[_p].__connected) _count++;
        ++_p;
    }
    
    return _count;
}