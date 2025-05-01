// Feather disable all

/// Returns the direction of the vector represented by the sum of the verb values.
/// 
/// @param {Any} default
/// @param {Enum.INPUT_CLUSTER,Real} clusterIndex
/// @param {Real} [playerIndex=0]

function InputDirection(_default, _clusterIndex, _playerIndex = 0)
{
    static _playerArray = __InputSystemPlayerArray();
    
    __INPUT_VALIDATE_PLAYER_INDEX
    
    with(_playerArray[_playerIndex])
    {
        var _x = __clusterXArray[_clusterIndex];
        var _y = __clusterYArray[_clusterIndex];
        
        if ((_x == 0) && (_y == 0)) return _default;
        return point_direction(0, 0, _x, _y);
    }
}
