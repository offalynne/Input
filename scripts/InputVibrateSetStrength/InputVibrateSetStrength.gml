// Feather disable all

/// Sets the vibration strength for a player, from 0 (no vibration ever) to 1 (full strength).
/// 
/// @param {Real} strength
/// @param {Real} [playedIndex=0]

function InputVibrateSetStrength(_strength, _playerIndex = 0)
{
    static _playerArray = __InputVibrateSystem().__playerArray;
    
    _playerArray[_playerIndex].__strength = clamp(_strength, 0, 1);
}