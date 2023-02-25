function __input_error()
{
    var _string = "";
    var _i = 0;
    repeat(argument_count)
    {
        _string += string(argument[_i]);
        ++_i;
    }
    
    if (os_browser == browser_not_a_browser)
    {
        show_error("Input " + __INPUT_VERSION + ":\n" + _string + "\n ", false);
    }
    else
    {
        show_error("Input " + __INPUT_VERSION + ":\n" + _string + "\n" + string(debug_get_callstack()), false);
    }
}