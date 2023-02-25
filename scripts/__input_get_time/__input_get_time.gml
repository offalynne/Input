function __input_get_time()
{
    __INPUT_GLOBAL_STATIC_LOCAL
    return (INPUT_TIMER_MILLISECONDS? global.__input_current_time : global.__input_frame);
}