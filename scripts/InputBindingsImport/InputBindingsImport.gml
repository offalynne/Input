// Feather disable all

/// Restores bindings from a struct created by `InputBindingsExport()`.
/// 
/// N.B. Care should be taken not to change export names between savefile versions or the library
///      will not be able to import old bindings from savefiles.
/// 
/// @param {Bool} forGamepad
/// @param {Struct} data
/// @param {Real} [playerIndex=0]

function InputBindingsImport(_forGamepad, _data, _playerIndex = 0)
{
    static _playerArray = __InputSystemPlayerArray();
    static _verbCount   = __InputSystem().__verbCount;
    
    var _bindingArray = _forGamepad? _playerArray[_playerIndex].__gamepadBindingArray : _playerArray[_playerIndex].__kbmBindingArray;
    var _i = 0;
    repeat(_verbCount)
    {
        var _exportName = InputVerbGetExportName(_i);
        if (_exportName != undefined)
        {
            var _alternates = _data[$ _exportName];
            _bindingArray = (_alternates == undefined)? [] : variable_clone(_alternates);
        }
        
        ++_i;
    }
}