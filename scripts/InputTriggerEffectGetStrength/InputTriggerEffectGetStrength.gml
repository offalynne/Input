// Feather disable all

/// Returns the pause state for gamepad trigger effects for a player.
/// 
/// @param {Real} [playerIndex=0]

function InputTriggerEffectGetStrength(_playerIndex = 0)
{
    static _playerArray = __InputTriggerEffectSystem().__playerArray;
    
    __INPUT_VALIDATE_PLAYER_INDEX
    
    return _playerArray[_playerIndex].__strength;
}