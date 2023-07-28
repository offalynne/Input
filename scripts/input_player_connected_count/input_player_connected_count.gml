// Feather disable all
/// @desc    Returns he number of players with connected devices
/// @param   [includeGhosts=true]

function input_player_connected_count(_include_ghosts = true)
{
    __INPUT_GLOBAL_STATIC_LOCAL  //Set static _global
    
    var _count = 0;
    var _p = 0;
    repeat(INPUT_MAX_PLAYERS)
    {
        with(_global.__players[_p])
        {
            if (__connected && (_include_ghosts || !__ghost))
            {
                _count++;
            }
        }
        
        ++_p;
    }
    
    return _count;
}
