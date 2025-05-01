// Feather disable all

/// Returns if the player is using a connected device. INPUT_TOUCH and INPUT_KBM will always
/// be considered connected on a desktop and mobile platform respectively. INPUT_GENERIC_DEVICE
/// will always be considered connected.
/// 
/// @param {Real} [playerIndex=0]

function InputPlayerIsConnected(_playerIndex = 0)
{
    static _playerArray = __InputSystemPlayerArray();
    
    __INPUT_VALIDATE_PLAYER_INDEX
    
    with(_playerArray[_playerIndex])
    {
        return ((__status == INPUT_PLAYER_STATUS.NEWLY_CONNECTED) || (__status == INPUT_PLAYER_STATUS.CONNECTED));
    }
}