// Feather disable all
function __input_clear_all()
{
    __INPUT_GLOBAL_STATIC_LOCAL  //Set static _global
    
    _global.__cleared = true;
    input_verb_consume(all, all);
}