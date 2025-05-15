// Feather disable all

/// Activates all verb groups.
/// 
/// @param [playerIndex=0]

function InputVerbGroupActivateAll(_playerIndex = 0)
{
    static _verbGroupInactiveArray = __InputVerbGroupSystem().__verbGroupInactiveArray;
    
    __INPUT_VALIDATE_PLAYER_INDEX;
    
    _verbGroupInactiveArray[@ _playerIndex] = 0x00;
}