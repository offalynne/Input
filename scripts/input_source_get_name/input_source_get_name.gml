/// @param source

function input_source_get_name(_source)
{
    switch(_source)
    {
        case INPUT_SOURCE.NONE:               return "none";               break;
        case INPUT_SOURCE.KEYBOARD_AND_MOUSE: return "keyboard and mouse"; break;
        case INPUT_SOURCE.GAMEPAD:            return "gamepad";            break;
    }
    
    return "unknown";
}