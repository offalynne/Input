// Feather disable all

/// Returns the length of the vector represented by the sum of the verb values.
/// 
/// @param {Enum.INPUT_CLUSTER,Real} clusterIndex
/// @param {Real} [playerIndex=0]

function InputDistance(_clusterIndex, _playerIndex = 0)
{
    static _playerArray = __InputSystemPlayerArray();
    
    __INPUT_VALIDATE_PLAYER_INDEX
    
    with(_playerArray[_playerIndex])
    {
        return point_distance(0, 0, __clusterXArray[_clusterIndex], __clusterYArray[_clusterIndex]);
    }
}
