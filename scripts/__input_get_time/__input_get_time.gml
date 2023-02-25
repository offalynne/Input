function __input_get_time()
{
    __INPUT_GLOBAL_STATIC_LOCAL
    return (INPUT_TIMER_MILLISECONDS? _global.__current_time : _global.__frame);
}