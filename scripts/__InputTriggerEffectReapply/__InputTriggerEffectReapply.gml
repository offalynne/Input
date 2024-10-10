// Feather disable all

/// @param playerIndex

function __InputTriggerEffectReapply(_playerIndex = 0)
{
    static _playerArray = __InputTriggerEffectSystem().__playerArray;
    
    if (_playerIndex == all)
    {
        var _i = 0;
        repeat(INPUT_MAX_PLAYERS)
        {
            __InputTriggerEffectReapply(_i);
            ++_i;
        }
        
        return;
    }
    
    with(_playerArray[_playerIndex])
    {
       if (__paused) return;
       
        __SetTriggerEffect(gp_shoulderlb, __effectLeft,  false);
        __SetTriggerEffect(gp_shoulderrb, __effectRight, false);
    }
}
