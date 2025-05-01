// Feather disable all

/// Sets the strength of trigger effects for the player.
///
/// @param {Real} strength
/// @param {Real} [playerIndex=0]

function InputTriggerEffectSetStrength(_strength, _playerIndex = 0)
{
    static _playerArray = __InputTriggerEffectSystem().__playerArray;
    
    __INPUT_VALIDATE_PLAYER_INDEX
    
    if (_playerIndex == INPUT_ALL_PLAYERS)
    {
        var _i = 0;
        repeat(INPUT_MAX_PLAYERS)
        {
            InputTriggerEffectSetStrength(_strength, _i);
            ++_i;
        }
        
        return;
    }
    
    _strength = clamp(_strength, 0, 1);
    
    with(_playerArray[_playerIndex])
    {
        if (__strength != _strength)
        {
            __strength = _strength;
            __InputTriggerEffectReapply(_playerIndex);
        }
    }
}
