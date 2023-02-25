/// @desc    Creates a null binding that can never be activated

function input_binding_empty()
{
    static _global = __input_state();
    
    return (new __input_class_binding());
}