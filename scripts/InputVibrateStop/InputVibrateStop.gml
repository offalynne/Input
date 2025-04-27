// Feather disable all

/// Stops all vibration events immediately.
/// 
/// @param {Real} [playedIndex=0]

function InputVibrateStop(_playerIndex = 0)
{
    static _playerArray = __InputVibrateSystem().__playerArray;
    
    array_resize(_playerArray[_playerIndex].__eventArray, 0);
}