// Feather disable all

/// Returns an array of all verb indexes that have been defined by `InputDefineVerb()`. The verb
/// indexes will not necessarily be sequential or ordered.

function InputPlugInGetAllVerbs()
{
    static _verbDefIndexArray = __InputSystem().__verbDefIndexArray;
    
    return _verbDefIndexArray;
}