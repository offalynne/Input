// Feather disable all

/// Sets icon data to return for a particular binding name when the player is using the keyboard
/// and mouse device (INPUT_KBM).
/// 
/// Please see `InputVerbGetBindingName()` for a list of binding names.
/// 
/// @param {Any} binding
/// @param {Any} icon

function InputIconDefineKeyboard(_binding, _iconData)
{
    static _keyboardIconMap = __InputIconSystem().__keyboardIconMap;
    
    if (is_string(_binding)) _binding = ord(_binding);
    
    _keyboardIconMap[? _binding] = _iconData;
}