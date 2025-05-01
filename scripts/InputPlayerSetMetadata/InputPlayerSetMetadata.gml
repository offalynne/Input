// Feather disable all

/// Sets metadata for a player. If the `makeCopy` parameter is set to `true` then a copy of the
/// metadata is stored; otherwise, the metadata is stored by reference if the metadata is a struct
/// or array.
/// 
/// @param {Any} data
/// @param {real} [playerIndex=0]
/// @param {Bool} [makeCopy=false]

function InputPlayerSetMetadata(_data, _playerIndex = 0, _makeCopy = false)
{
    static _playerArray = __InputSystemPlayerArray();
    
    __INPUT_VALIDATE_PLAYER_INDEX
    
    if (_makeCopy) _data = variable_clone(_data);
    _playerArray[_playerIndex].__metadata = _data;
}