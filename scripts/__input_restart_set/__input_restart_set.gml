// Feather disable all
function __input_restart_set(_state)
{
    __INPUT_GLOBAL_STATIC_LOCAL  //Set static _global
    if (_state && !_global.__restart)
    {
        input_verb_consume(all, all);
    }
    _global.__restart = _state;
}
