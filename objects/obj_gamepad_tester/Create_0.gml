test_index = 0;

if (INPUT_ON_PC)
{
    try
    {
        input_gamepad_tester_set(true);
    }
    catch(_e)
    {
        show_debug_message("Warning: Debug overlay unavailable");
    }
}