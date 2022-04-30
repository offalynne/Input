/// @param source

function input_source_is_available(_source)
{
    __input_initialize();
    
    var _p = 0;
    repeat(INPUT_MAX_PLAYERS)
    {
        if (global.__input_players[_p].__source_using(_source)) return false;
        ++_p;
    }
    
    return true;
}