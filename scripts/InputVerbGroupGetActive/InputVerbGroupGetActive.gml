// Feather disable all

/// Returns if a verb group is active, which they are by default. A verb group can be deactivated
/// by calling `InputVerbGroupSetActive()`.
/// 
/// @param verbGroupIndex
/// @param [playerIndex=0]

function InputVerbGroupGetActive(_verbGroupIndex, _playerIndex = 0)
{
    static _verbGroupInactiveArray = __InputVerbGroupSystem().__verbGroupInactiveArray;
    
    __INPUT_VALIDATE_PLAYER_INDEX;
    
    return not (_verbGroupInactiveArray[_playerIndex] & (1 << _verbGroupIndex));
}