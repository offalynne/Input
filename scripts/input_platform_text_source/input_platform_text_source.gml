function input_platform_text_source()
{
    if (__INPUT_ON_WEB || __INPUT_ON_CONSOLE)
    {
        return "async";
    }
    else if (__INPUT_ON_MOBILE)
    {
        return "virtual";
    }
    else
    {
        return "keyboard";
    }
    
    __input_error("Failed to identify platform text source");
}
