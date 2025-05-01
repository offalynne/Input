// Feather disable all

/// Returns the metadata assigned to a player by `InputPlayerSetMetadata()`. If the `makeCopy`
/// parameter is set to `true` then a copy of the metadata is returned; otherwise, the metadata
/// is returned as a reference if the metadata is a struct or array.
/// 
/// @param {Real} [playerIndex=0]
/// @param {Bool} [makeCopy=false]

function InputPlayerGetMetadata(_playerIndex = 0, _makeCopy = false)
{
    static _playerArray = __InputSystemPlayerArray();
    
    __INPUT_VALIDATE_PLAYER_INDEX
    
    var _data = _playerArray[_playerIndex].__metadata;
    return _makeCopy? variable_clone(_data) : _data;
}