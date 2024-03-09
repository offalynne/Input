use_debug_overlay = false;
test_index = 0;

if (!INPUT_ON_WEB && !INPUT_ON_CONSOLE)
{
    use_debug_overlay = true;
    
    try
    {
        input_gamepad_tester_set(true);
    }
    catch(_e)
    {
        show_debug_message("Error in Input gamepad tester \n===\n" + string(_e[$ "message"]) + "===");
        use_debug_overlay = false;
    }
}
