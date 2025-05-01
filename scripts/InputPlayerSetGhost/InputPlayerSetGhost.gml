// Feather disable all

/// Sets the "ghost" state for a player. A player that is set as a ghost will always return
/// themselves as connected but will not collect input from their device (if one is set).
/// 
/// N.B. A ghost player will **not** have their device reset. A ghost player can have a device
///      assigned to them. This may cause issues elsewhere so make sure you're managed the device
///      of a ghost player if required.
/// 
/// @param {Boolean} state
/// @param {Real} [playerIndex=0]
/// @param {Real} [forceGenericDevice=true]

function InputPlayerSetGhost(_state, _playerIndex = 0)
{
    static _playerArray = __InputSystemPlayerArray();
    
    __INPUT_VALIDATE_PLAYER_INDEX
    
    _playerArray[_playerIndex].__ghost = _state;
}