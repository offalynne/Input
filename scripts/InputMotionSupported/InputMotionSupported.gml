// Feather disable all

/// @param {Real} [playerIndex=0]

function InputMotionSupported(_playerIndex = 0)
{
     return (InputMotionGetDirect(InputPlayerGetDevice(_playerIndex)) != undefined);
}