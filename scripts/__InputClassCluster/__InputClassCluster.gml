// Feather disable all

/// @param clusterIndex
/// @param verbUp
/// @param verbRight
/// @param verbDown
/// @param verbLeft
/// @param axisBiasFactor
/// @param axisBiasDiagonals
/// @param metadata

function __InputClassClusterDefinition(_clusterIndex, _verbUp, _verbRight, _verbDown, _verbLeft, _axisBiasFactor, _axisBiasDiagonals, _metadata) constructor
{
    __clusterIndex = _clusterIndex;
    
    __verbUp            = _verbUp;
    __verbRight         = _verbRight;
    __verbDown          = _verbDown;
    __verbLeft          = _verbLeft;
    __axisBiasFactor    = _axisBiasFactor;
    __axisBiasDiagonals = _axisBiasDiagonals;
    __metadata          = variable_clone(_metadata);
}