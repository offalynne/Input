/// @param source

function __input_source_relinquish(_source)
{
    __INPUT_GLOBAL_STATIC_LOCAL
    
    var _i = 0;
    repeat(INPUT_MAX_PLAYERS)
    {
        global.__input_players[_i].__source_remove(_source);
        ++_i;
    }
}