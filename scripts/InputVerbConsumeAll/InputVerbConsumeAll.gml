// Feather disable all

/// "Consumes" all verbs for a player, causing them to be immediately deactivated and return a
/// value of zero until a verb is retriggered (e.g. by released a keyboard key and pressed it
/// again).
/// 
/// @param {Real} [playerIndex=0]

function InputVerbConsumeAll(_playerIndex = 0)
{
    static _playerArray = __InputSystemPlayerArray();
    static _verbCount   = __InputSystem().__verbCount;
    
    __INPUT_VALIDATE_PLAYER_INDEX
    
    with(_playerArray[_playerIndex])
    {
        var _i = 0;
        repeat(_verbCount)
        {
            InputVerbConsume(_i);
            ++_i;
        }
    }
}