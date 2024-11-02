// Feather disable all

/// Returns a struct that contains the bindings set for a player. This can be saved to a savefile
/// and restored using `InputBindingsImport()`.
/// 
/// N.B. Care should be taken not to change export names between savefile versions or the library
///      will not be able to import old bindings from savefiles.
/// 
/// @param {Bool} forGamepad
/// @param {Real} [playerIndex=0]

function InputBindingsExport(_forGamepad, _playerIndex = 0)
{
    static _playerArray         = __InputSystemPlayerArray();
    static _verbDefinitionArray = __InputSystem().__verbDefinitionArray;
    static _verbCount           = __InputSystem().__verbCount;
    
    var _output = {};
    
    var _bindingArray = _forGamepad? _playerArray[_playerIndex].__gamepadBindingArray : _playerArray[_playerIndex].__kbmBindingArray;
    var _i = 0;
    repeat(_verbCount)
    {
        _output[$ InputVerbGetExportName(_i)] = variable_clone(_bindingArray[_i]);
        ++_i;
    }
    
    return _output;
}