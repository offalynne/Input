// Feather disable all

/// Returns the vibration pause state for a player.
/// 
/// @param {Real} [playedIndex=0]

function InputVibrateGetPause(_playerIndex = 0)
{
    static _playerArray = __InputVibrateSystem().__playerArray;
    
    return _playerArray[_playerIndex].__paused;
}