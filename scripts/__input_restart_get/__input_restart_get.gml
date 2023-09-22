// Feather disable all
function __input_restart_get()
{
    __INPUT_GLOBAL_STATIC_LOCAL  //Set static _global
    return (_global.__restart_time == _global.__current_time);
}
