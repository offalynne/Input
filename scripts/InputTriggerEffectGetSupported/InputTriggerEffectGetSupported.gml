// Feather disable all

/// Returns whether trigger effects are *probably* supported for the device assigned to a player.
/// This can only ever be approximate as many factors influence whether trigger effects will work
/// properly.
/// 
/// @param {Real} [playedIndex=0]

function InputTriggerEffectGetSupported(_playerIndex = 0)
{
    var _device = InputPlayerGetDevice(_playerIndex);
    if (_device < 0) return false;
    if (InputDeviceGetGamepadType(_device) != INPUT_GAMEPAD_TYPE_PS5) return false;
    
    return (INPUT_ON_PS5 || InputGetSteamInfo(INPUT_STEAM_INFO.STEAMWORKS));
}