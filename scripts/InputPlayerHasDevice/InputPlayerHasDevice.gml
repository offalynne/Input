// Feather disable all

/// Returns if the player has any device set (i.e. not INPUT_NO_DEVICE).
/// 
/// @param {Real} [playerIndex=0]

function InputPlayerHasDevice(_playerIndex = 0)
{
    __INPUT_VALIDATE_PLAYER_INDEX
    
    return (InputPlayerGetDevice(_playerIndex) != INPUT_NO_DEVICE);
}