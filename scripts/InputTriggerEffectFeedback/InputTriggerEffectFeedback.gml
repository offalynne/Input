// Feather disable all

/// Sets a player's trigger effect to "feedback" which adds resistance to the pull of a trigger,
/// starting at a particular point. The `position` parameter should be a value from 0 to 1.
///
/// The trigger value should be either:
/// - gp_shoulderlb
/// - gp_shoulderrb
/// 
/// @param {Real} trigger
/// @param {Real} position
/// @param {Real} strength
/// @param {Real} [playerIndex=0]

function InputTriggerEffectFeedback(_trigger, _position, _strength, _playerIndex = 0)
{
    static _playerArray = __InputTriggerEffectSystem().__playerArray;
    
    __INPUT_VALIDATE_PLAYER_INDEX
    
    _playerArray[_playerIndex].__SetTriggerEffect(_trigger, new __InputTrggerEffectClassFeedback(_position, _strength), true);
}
