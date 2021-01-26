/// @param binding

function __input_binding_get_source(_binding)
{
    if ((_binding.type == "key")
    ||  (_binding.type == "mouse button")
    ||  (_binding.type == "mouse wheel up")
    ||  (_binding.type == "mouse wheel down"))
    {
        return INPUT_SOURCE.KEYBOARD_AND_MOUSE;
    }
    else if ((_binding.type == "gamepad button")
         ||  (_binding.type == "gamepad axis"))
    {
        return INPUT_SOURCE.GAMEPAD;
    }
    
    __input_error("Binding type \"", _binding.type, "\" unrecognised");
    return undefined;
}