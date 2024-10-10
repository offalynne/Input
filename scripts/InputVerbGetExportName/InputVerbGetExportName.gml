// Feather disable all

/// Returns the export name for a verb, as defined by `InputDefineVerb()`.
/// 
/// @param {Enum.INPUT_VERB,Real} verbIndex

function InputVerbGetExportName(_verbIndex)
{
    static _verbDefinitionArray = __InputSystem().__verbDefinitionArray;
    
    var _verbDefinition = _verbDefinitionArray[_verbIndex];
    return (_verbDefinition == undefined)? undefined : _verbDefinition.__exportName;
}