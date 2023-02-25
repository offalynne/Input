/// @param source

function __input_source_relinquish(_source)
{
    __INPUT_GLOBAL_STATIC_LOCAL  //Set static _global
    
    var _i = 0;
    repeat(INPUT_MAX_PLAYERS)
    {
        _global.__players[_i].__source_remove(_source);
        ++_i;
    }
}