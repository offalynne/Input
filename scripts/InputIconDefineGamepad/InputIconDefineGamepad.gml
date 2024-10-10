// Feather disable all

/// Sets icon data to return for a particular binding name when the player is using the specified
/// gamepad type.
/// 
/// Please see `InputVerbGetBindingName()` for a list of binding names.
/// 
/// @param {Real} gamepadType
/// @param {Any} binding
/// @param {Any} iconData

function InputIconDefineGamepad(_gamepadType, _binding, _iconData)
{
    static _gamepadTypeMap = __InputIconSystem().__gamepadTypeMap;
    
    var _gamepadIconMap = _gamepadTypeMap[? _gamepadType];
    if (_gamepadIconMap == undefined)
    {
        _gamepadIconMap = ds_map_create();
        _gamepadTypeMap[? _gamepadType] = _gamepadIconMap;
    }
    
    _gamepadIconMap[? _binding] = _iconData;
}