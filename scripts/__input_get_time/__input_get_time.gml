function __input_get_time()
{
    return (INPUT_TIMER_MILLISECONDS? global.__input_current_time : global.__input_frame);
}