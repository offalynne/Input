// Feather disable all

/// Returns the pause state for gamepad trigger effects for a player.
/// 
/// @param {Real} [playerIndex=0]

function InputTriggerEffectGetPause(_playerIndex = 0)
{
    static _playerArray = __InputTriggerEffectSystem().__playerArray;
    
    return _playerArray[_playerIndex].__paused;
}