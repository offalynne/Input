// Feather disable all

/// Deactivates all verb groups.
/// 
/// N.B. Be careful with the function! It's possible to accidentally lock your players out of
///      controlling the game.
/// 
/// @param [playerIndex=0]

function InputVerbGroupDeactivateAll(_playerIndex = 0)
{
    static _verbGroupInactiveArray = __InputVerbGroupSystem().__verbGroupInactiveArray;
    
    __INPUT_VALIDATE_PLAYER_INDEX;
    
    _verbGroupInactiveArray[@ _playerIndex] = 0x00;
}