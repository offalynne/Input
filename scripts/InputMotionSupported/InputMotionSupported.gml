// Feather disable all

/// @param {Real} [playerIndex=0]

function InputMotionSupported(_playerIndex = 0)
{
    __INPUT_VALIDATE_PLAYER_INDEX
    
     return (InputMotionGetDirect(InputPlayerGetDevice(_playerIndex)) != undefined);
}