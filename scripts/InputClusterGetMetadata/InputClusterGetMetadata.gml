// Feather disable all

/// Returns the metadata assigned to a player's cluster. If the `makeCopy` parameter is set to
/// `true` then a copy of the metadata is stored; otherwise, the metadata is stored by reference if
/// the metadata is a struct or array.
/// 
/// @param {Enum.INPUT_CLUSTER,Real} cluster
/// @param {Real} [playerIndex=0]
/// @param {Bool} [makeCopy=false]

function InputClusterGetMetadata(_cluster, _playerIndex = 0, _makeCopy = false)
{
    static _playerArray = __InputSystemPlayerArray();
    
    __INPUT_VALIDATE_PLAYER_INDEX
    
    var _data = _playerArray[_playerIndex].__clusterMetadataArray[_cluster];
    return _makeCopy? variable_clone(_data) : _data;
}