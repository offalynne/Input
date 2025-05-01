// Feather disable all

/// Disables the trigger effect for a player. The trigger value should be either:
/// - gp_shoulderlb
/// - gp_shoulderrb
/// 
/// @param {Real} trigger
/// @param {Real} [playerIndex=0]

function InputTriggerEffectOff(_trigger, _playerIndex = 0)
{
    static _playerArray = __InputTriggerEffectSystem().__playerArray;
    
    __INPUT_VALIDATE_PLAYER_INDEX
    
    _playerArray[_playerIndex].__SetTriggerEffect(_trigger, new __InputTriggerEffectClassOff(), true);
}
