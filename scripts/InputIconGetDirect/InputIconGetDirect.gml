// Feather disable all

/// Returns the icon data associated with a binding for a particular gamepad type, or the keyboard
/// and mouse device (`INPUT_KBM`) if `forGamepad` is set to `false`.
/// 
/// @param {Any} binding
/// @param {Boolean} forGamepad
/// @param {Real} gamepadType

function InputIconGetDirect(_binding, _forGamepad, _gamepadType)
{
    static _system          = __InputIconSystem();
    static _keyboardIconMap = _system.__keyboardIconMap;
    static _gamepadTypeMap  = _system.__gamepadTypeMap;
    
    if (_binding == undefined)
    {
        return _system.__empty;
    }
    
    if (not _forGamepad)
    {
        return _keyboardIconMap[? _binding] ?? _system.__unsupported;
    }
    else
    {
        var _gamepadMap = _gamepadTypeMap[? _gamepadType];
        if (_gamepadMap == undefined)
        {
            _gamepadMap = _gamepadTypeMap[? INPUT_GAMEPAD_TYPE_UNKNOWN];
            
            if (_gamepadMap == undefined)
            {
                return _system.__unsupported;
            }
        }
        
        return (_gamepadMap[? _binding] ?? _system.__unsupported);
    }
}