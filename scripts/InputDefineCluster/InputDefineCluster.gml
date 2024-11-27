// Feather disable all

/// Defines a verb cluster. Clusters are used for cluster checks such as `InputX()` and
/// `InputDirection()`.
/// 
/// @param {Enum.INPUT_CLUSTER,Real} clusterIndex
/// @param {Enum.INPUT_VERB,Real} verbUp
/// @param {Enum.INPUT_VERB,Real} verbRight
/// @param {Enum.INPUT_VERB,Real} verbDown
/// @param {Enum.INPUT_VERB,Real} verbLeft

function InputDefineCluster(_clusterIndex, _verbUp, _verbRight, _verbDown, _verbLeft)
{
    static _system = __InputSystem();
    
    if (GM_build_type == "run")
    {
        var _callstack = debug_get_callstack(2);
        var _previous = _callstack[1];
        _previous = string_copy(_previous, 1, string_length("gml_Script___InputConfigVerbs"))
        
        if (_previous != "gml_Script___InputConfigVerbs")
        {
            __InputError("InputDefineCluster() must only be called in __InputConfigVerbs()");
        }
    }
    
    with(_system)
    {
        var _definition = new __InputClassClusterDefinition(_clusterIndex, _verbUp, _verbRight, _verbDown, _verbLeft);
        __clusterDefinitionArray[_clusterIndex] = _definition;
    }
}