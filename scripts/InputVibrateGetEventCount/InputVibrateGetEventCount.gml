// Feather disable all

/// Returns the number of vibration events currently being handled for a player. This function will
/// not check if the player is using a connected gamepad with vibration support and will return the
/// the number of on-going vibration events regardless of the player's device state.
/// 
/// @param {Real} [playedIndex=0]

function InputVibrateGetEventCount(_playerIndex = 0)
{
    static _playerArray = __InputVibrateSystem().__playerArray;
    
    __INPUT_VALIDATE_PLAYER_INDEX
    
    return array_length(_playerArray[_playerIndex].__eventArray);
}