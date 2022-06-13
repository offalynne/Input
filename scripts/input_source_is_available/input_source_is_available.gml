/// @desc    Returns if a source is available i.e. hasn't been assigned to a player yet
/// @param   source

function input_source_is_available(_source)
{
    __input_initialize();
    
    var _p = 0;
    repeat(INPUT_MAX_PLAYERS)
    {
        if (global.__input_players[_p].__source_contains(_source)) return false;
        ++_p;
    }
    
    return true;
}