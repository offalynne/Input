// Feather disable all

/// Returns `undefined` if motion is unsupported for the target device, otherwise returns a struct
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
/// @param {Real} device

function InputMotionGetDirect(_device)
{
     static _deviceMap = __InputMotionSystem().__deviceMap;
     return _deviceMap[? _device];
}