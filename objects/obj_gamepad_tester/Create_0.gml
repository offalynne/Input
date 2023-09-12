test_index = 0;

if (INPUT_ON_PC)
{
    try
    {
        input_gamepad_tester_set(true);
    }
    catch(_e)
    {
        show_debug_message("Error in Input gamepad tester \n===\n" + string(_e[$ "message"]) + "===");
    }
}
