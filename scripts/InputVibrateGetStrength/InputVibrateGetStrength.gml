// Feather disable all

/// Returns the vibration strength from a player.
/// 
/// @param {Real} [playedIndex=0]

function InputVibrateGetStrength(_playerIndex = 0)
{
    static _playerArray = __InputVibrateSystem().__playerArray;
    
    return _playerArray[_playerIndex].__strength;
}