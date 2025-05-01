// Feather disable all

/// @param index
/// @param exportName
/// @param defaultKbmBinding
/// @param defaultGamepadBinding
/// @param metadata

function __InputClassVerbDefinition(_index, _exportName, _kbmBinding, _gamepadBinding, _metadata) constructor
{
    //Fix use of strings
    if (is_array(_kbmBinding))
    {
        var _i = 0;
        repeat(array_length(_kbmBinding))
        {
            if (is_string(_kbmBinding[_i]))
            {
                _kbmBinding[@ _i] = ord(_kbmBinding[_i]);
            }
            
            ++_i;
        }
    }
    else if (is_string(_kbmBinding))
    {
        _kbmBinding = ord(_kbmBinding);
    }
    
    __verbIndex      = _index;
    __exportName       = _exportName;
    __kbmBinding     = is_array(_kbmBinding)? _kbmBinding : [_kbmBinding];
    __gamepadBinding = is_array(_gamepadBinding)? _gamepadBinding : [_gamepadBinding];
    __metadata       = variable_clone(_metadata);
}