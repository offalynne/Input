function __input_get_previous_time()
{
    return (INPUT_TIMER_MILLISECONDS? global.__input_previous_current_time : (global.__input_frame - 1));
}