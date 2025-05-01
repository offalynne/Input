// Feather disable all

/// Defines a verb cluster. Clusters are used for cluster checks such as `InputX()` and
/// `InputDirection()`.
/// 
/// The optional `axisBiasFactor` parameter allows you to bias the cluster along straight lines
/// along the x and y axes. This makes it easier for the player to input exactly horizontal and
/// exactly vertical movement. The value for this parameter should be from 0 to 1. Higher values
/// make the biasing behaviour stronger. The default value for `axisBiasFactor` is 0 which confers
/// no axis bias whatsoever.
///
/// `axisBiasDiagonals` controls whether the axis bias should also allow diagonal inputs. It
/// defaults to `false`: biasing will not select diagonal directioons. Setting this parameter to
/// `true` will allow diagonal directions.
/// 
/// @param {Enum.INPUT_CLUSTER,Real} clusterIndex
/// @param {Enum.INPUT_VERB,Real} verbUp
/// @param {Enum.INPUT_VERB,Real} verbRight
/// @param {Enum.INPUT_VERB,Real} verbDown
/// @param {Enum.INPUT_VERB,Real} verbLeft
/// @param {Real} [axisBiasFactor=0]
/// @param {Real} [axisBiasDiagonals=false]
/// @param {Any} [metadata=struct]

function InputDefineCluster(_clusterIndex, _verbUp, _verbRight, _verbDown, _verbLeft, _axisBiasFactor = 0, _axisBiasDiagonals = false, _metadata = {})
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
        var _definition = new __InputClassClusterDefinition(_clusterIndex, _verbUp, _verbRight, _verbDown, _verbLeft, _axisBiasFactor, _axisBiasDiagonals, _metadata);
        __clusterDefinitionArray[@ _clusterIndex] = _definition;
    }
}