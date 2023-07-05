function __InputBindingImport(_struct)
{
    switch(__InputConstantToSourceType(_struct[$ "bind"]))
    {
        case __INPUT_SOURCE.KEYBOARD:
            return (new __InputClassBindingKey()).__Import(_struct);
        break;
        
        case __INPUT_SOURCE.MOUSE:
            return (new __InputClassBindingMouse()).__Import(_struct);
        break;
        
        case __INPUT_SOURCE.GAMEPAD:
            return (new __InputClassBindingGamepad()).__Import(_struct);
        break;
        
        default:
            if (variable_struct_exists(_struct, "bind"))
            {
                __input_error("Binding \"", _struct[$ "bind"], "\" not supported");
            }
            else
            {
                __input_error("Binding not found");
            }
        break;
    }
}