// Feather disable all
/// @desc    Returns if a source is available i.e. hasn't been assigned to a player yet
/// @param   source

function input_source_is_available(_source)
{
    __INPUT_GLOBAL_STATIC_LOCAL  //Set static _global
    
    var _p = 0;
    repeat(INPUT_MAX_PLAYERS)
    {
        if (_global.__players[_p].__source_contains(_source)) return false;
        ++_p;
    }
    
    return true;
}
