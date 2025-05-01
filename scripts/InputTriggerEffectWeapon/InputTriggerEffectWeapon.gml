// Feather disable all

/// Sets a player's trigger effect to "weapon" which simulates the feel of a trigger pull on a
/// firearm. The `start` and `end` parameters control where the break and release points are and
/// should be values from 0 to 1.
///
/// The trigger value should be either:
/// - gp_shoulderlb
/// - gp_shoulderrb
/// 
/// @param {Real} trigger
/// @param {Real} start
/// @param {Real} end
/// @param {Real} strength
/// @param {Real} [playerIndex=0]

function InputTriggerEffectWeapon(_trigger, _start, _end, _strength, _playerIndex = 0)
{
    static _playerArray = __InputTriggerEffectSystem().__playerArray;
    
    __INPUT_VALIDATE_PLAYER_INDEX
    
    _playerArray[_playerIndex].__SetTriggerEffect(_trigger, new __InputTriggerEffectClassWeapon(_trigger, _start, _end, _strength), true);
}
