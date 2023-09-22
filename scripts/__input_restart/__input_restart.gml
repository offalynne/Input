// Feather disable all
function __input_restart()
{
    __INPUT_GLOBAL_STATIC_LOCAL  //Set static _global
    
    _global.__restart_time = _global.__current_time;
    __input_clear_all();
}