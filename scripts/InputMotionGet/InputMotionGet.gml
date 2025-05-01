// Feather disable all

/// Returns `undefined` if motion is unsupported for the target player, otherwise returns a struct
/// containing accelerometer and gyroscope values:
/// 
/// {
///     .accelerationX
///     .accelerationY
///     .accelerationZ
///     .angularVelocityX
///     .angularVelocityY
///     .angularVelocityZ
/// } 
/// 
/// Values will inherently be noisy and some smoothing will be required to make them usable.
///
/// @param {Real} [playerIndex=0]

function InputMotionGet(_playerIndex = 0)
{
    __INPUT_VALIDATE_PLAYER_INDEX
    
     return InputMotionGetDirect(InputPlayerGetDevice(_playerIndex));
}