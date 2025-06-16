// Feather disable all

/// Returns if a verb has been pressed during the specified duration, measured in
/// frames.
/// 
/// @param {Enum.INPUT_VERB,Real} verbIndex
/// @param {Real} duration
/// @param {Real} [playerIndex=0]

function InputBufferPressed(_verbIndex, _duration, _playerIndex = 0)
{
    static _system      = __InputSystem();
    static _playerArray = __InputSystemPlayerArray();
    
    __INPUT_VALIDATE_PLAYER_INDEX
    
    with(_playerArray[_playerIndex].__verbStateArray[_verbIndex])
    {
        return ((_system.__frame - __pressFrame) <= _duration);
    }
}