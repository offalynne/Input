/// feather disable all

/// Defines a verb and its default bindings for keyboard+mouse and gamepad. The `exportName`
/// parameters defines the name of the verb when exported with InputBindingsExport().
///
/// N.B. Care should be taken not to change export names between savefile versions or the library
///      will not be able to import old bindings from savefiles etc.
/// 
/// Bindings can be specifed in one of the following ways:
/// 
/// - gp_* constants
/// - vk_* constants
/// - mb_* constants
/// - Single-character strings for keyboard keys e.g. "A"
/// 
/// Bindings can also be specified as an array of bindings e.g. `[vk_up, "W"]`.
/// 
/// @param {Enum.INPUT_VERB,Real} verbIndex
/// @param {String} exportName
/// @param {Any} defaultKbmBinding
/// @param {Any} defaultGamepadBinding
/// @param {Any} [metadata=struct]

function InputDefineVerb(_verbIndex, _exportName, _kbmBinding, _gamepadBinding, _metadata = {})
{
    static _system = __InputSystem();
    
    if (GM_build_type == "run")
    {
        var _callstack = debug_get_callstack(2);
        var _previous = _callstack[1];
        _previous = string_copy(_previous, 1, string_length("gml_Script___InputConfigVerbs"))
        
        if (_previous != "gml_Script___InputConfigVerbs")
        {
            __InputError("InputDefineVerb() must only be called in __InputConfigVerbs()");
        }
    }
    
    with(_system)
    {
        var _definition = new __InputClassVerbDefinition(_verbIndex, _exportName, _kbmBinding, _gamepadBinding, _metadata);
        
        __verbDefinitionArray[@ _verbIndex]   = _definition;
        __verbExportNameDict[$ _exportName] = _definition;
        
        if (array_get_index(__verbDefIndexArray, _verbIndex) < 0)
        {
            array_push(__verbDefIndexArray, _verbIndex);
        }
    }
}