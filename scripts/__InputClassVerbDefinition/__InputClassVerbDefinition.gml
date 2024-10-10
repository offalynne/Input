// Feather disable all

/// @param index
/// @param exportName
/// @param defaultKbmBinding
/// @param defaultGamepadBinding

function __InputClassVerbDefinition(_index, _exportName, _kbmBinding, _gamepadBinding) constructor
{
    //Fix use of strings
    if (is_array(_kbmBinding))
    {
        var _i = 0;
        repeat(array_length(_kbmBinding))
        {
            if (is_string(_kbmBinding[_i]))
            {
                _kbmBinding[_i] = ord(_kbmBinding[_i]);
            }
            
            ++_i;
        }
    }
    
    __verbIndex      = _index;
    __exportName       = _exportName;
    __kbmBinding     = is_array(_kbmBinding)? _kbmBinding : [_kbmBinding];
    __gamepadBinding = is_array(_gamepadBinding)? _gamepadBinding : [_gamepadBinding];
}