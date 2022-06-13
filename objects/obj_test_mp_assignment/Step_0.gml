switch(input_source_mode_get())
{
    case INPUT_SOURCE_MODE.JOIN:
        if (input_multiplayer_is_finished())
        {
            if (input_check_pressed("accept", 0) || input_check_pressed("accept", 1) || input_check_pressed("accept", 2))
            {
                //We had three players connect and one of them pressed Accept
                success = true;
                input_source_mode_set(INPUT_SOURCE_MODE.FIXED);
            }
        }
    break;
    
    case INPUT_SOURCE_MODE.FIXED:
        if (input_check_pressed("pause", 0) || input_check_pressed("pause", 1) || input_check_pressed("pause", 2))
        {
            success = false;
            input_source_mode_set(INPUT_SOURCE_MODE.JOIN);
        }
    break;
}