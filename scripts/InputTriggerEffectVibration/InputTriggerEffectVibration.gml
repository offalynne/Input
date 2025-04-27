// Feather disable all

/// Sets a player's trigger effect to "vibration" which adds vibration to the pull of a trigger,
/// starting at a particular point. The `position` parameter should be a value from 0 to 1.
///
/// The trigger value should be either:
/// - gp_shoulderlb
/// - gp_shoulderrb
/// 
/// @param {Real} trigger
/// @param {Real} position
/// @param {Real} amplitude
/// @param {Real} frequency
/// @param {Real} [playerIndex=0]

function InputTriggerEffectVibration(_trigger, _position, _amplitude, _frequency, _playerIndex = 0)
{
    static _playerArray = __InputTriggerEffectSystem().__playerArray;
    
    _playerArray[_playerIndex].__SetTriggerEffect(_trigger, new __InputTriggerEffectClassVibration(_position, _amplitude, _frequency), true);
}
