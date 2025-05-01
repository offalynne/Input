// Feather disable all

/// Sets the metadata for a player's cluster. This will overwrite any metadata that was set by
/// `InputDefineCluster()`. If the `makeCopy` parameter is set to `true` then a copy of the
/// metadata is stored; otherwise, the metadata is stored by reference if the metadata is a struct
/// or array.
/// 
/// @param {Enum.INPUT_CLUSTER,Real} cluster
/// @param {Any} data
/// @param {Real} [playerIndex=0]
/// @param {Bool} [makeCopy=false]

function InputClusterSetMetadata(_cluster, _data, _playerIndex = 0, _makeCopy = false)
{
    static _playerArray = __InputSystemPlayerArray();
    
    __INPUT_VALIDATE_PLAYER_INDEX
    
    var _clusterMetadataArray = _playerArray[_playerIndex].__clusterMetadataArray;
    _clusterMetadataArray[@ _cluster] = _makeCopy? variable_clone(_data) : _data;
}