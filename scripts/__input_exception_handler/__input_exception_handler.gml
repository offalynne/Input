// Feather disable all
function __input_exception_handler()
{
    __input_trace(argument0);
    
    show_message(argument0.longMessage);
    
    if (show_question("Would you like to copy this error to your clipboard?"))
    {
        clipboard_set_text(argument0);
    }
}
