// Feather disable all

/// Returns the y-coordinate of the vector represented by the sum of the verb values.
/// 
/// @param {Enum.INPUT_CLUSTER,Real} clusterIndex
/// @param {Real} [playerIndex=0]

function InputY(_clusterIndex, _playerIndex = 0)
{
    static _playerArray = __InputSystemPlayerArray();
    
    __INPUT_VALIDATE_PLAYER_INDEX
    
    return _playerArray[_playerIndex].__clusterYArray[_clusterIndex];
}