// Feather disable all

/// Resets the metadata for a player's cluster to the value set by `InputDefineCluster()`.
/// 
/// @param {Enum.INPUT_CLUSTER,Real} cluster
/// @param {Real} [playerIndex=0]

function InputClusterResetMetadata(_cluster, _playerIndex = 0)
{
    static _clusterDefinitionArray = __InputSystem().__clusterDefinitionArray;
    static _playerArray            = __InputSystemPlayerArray();
    
    __INPUT_VALIDATE_PLAYER_INDEX
    
    var _clusterMetadataArray = _playerArray[_playerIndex].__clusterMetadataArray;
    _clusterMetadataArray[@ _cluster] = variable_clone(_clusterDefinitionArray[_cluster].__metadata);
}