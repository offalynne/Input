// Feather disable all

/// Sets the pause state for gamepad trigger effects for a player.
/// 
/// @param {Real} state
/// @param {Real} [playerIndex=0]

function InputTriggerEffectSetPause(_state, _playerIndex = 0)
{
    static _playerArray = __InputTriggerEffectSystem().__playerArray;
    
    __INPUT_VALIDATE_PLAYER_INDEX
    
    if (_playerIndex == INPUT_ALL_PLAYERS)
    {
        var _i = 0;
        repeat(INPUT_MAX_PLAYERS)
        {
            InputTriggerEffectSetPause(_state, _i);
            ++_i;
        }
        
        return;
    }
    
    _playerArray[_playerIndex].__SetPause(_state);
}