/// @desc    Returns the source type for this binding, one of the following:
///              INPUT_KEYBOARD
///              INPUT_MOUSE
///              INPUT_TOUCH
///              INPUT_GAMEPAD
///          If the binding is invalid or the source type cannot be determined, <undefined> is returned.
///          As with other functions, if INPUT_ASSIGN_KEYBOARD_AND_MOUSE_TOGETHER is set to <true> then
///          INPUT_KEYBOARD and INPUT_MOUSE are interchangeable.
/// @param   binding

function input_binding_get_source_type(_binding)
{
    if (!input_value_is_binding(_binding)) return undefined;
    return _binding.__source_type_get(_binding);
}
