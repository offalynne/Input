function __input_get_previous_time()
{
    __INPUT_GLOBAL_STATIC_LOCAL
    return (INPUT_TIMER_MILLISECONDS? _global.__previous_current_time : (_global.__frame - 1));
}