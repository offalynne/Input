// Feather disable all

/// Retyrbs tge gamepad trigger effect state for a player.
/// 
/// @param   trigger
/// @param   [playerIndex=0]

function InputTriggerEffectGetState(_trigger, _playerIndex = 0)
{
    static _playerArray = __InputTriggerEffectSystem().__playerArray;
    
    __INPUT_VALIDATE_PLAYER_INDEX
    
    if not ((_trigger == gp_shoulderlb) || (_trigger == gp_shoulderrb))
    {
        __InputError("Value ", _trigger ," not a gamepad trigger");
    }
    
    var _device = InputPlayerGetDevice(_playerIndex);
    if ((_device < 0) || (not InputDeviceIsConnected(_device))) return undefined;
    
    var _struct = _playerArray[_playerIndex];
    if (_struct.__paused) return INPUT_TRIGGER_STATE.EFFECT_INTERCEPTED;
    
    if (INPUT_ON_PS5) return ps5_gamepad_get_trigger_effect_state(_device, _trigger);
    
    var _effect = undefined;
    if (_trigger == gp_shoulderlb)
    {
        if (_struct.__interceptedLeft) return INPUT_TRIGGER_STATE.EFFECT_INTERCEPTED;        
        _effect = _struct.__effectLeft;
    }
    else if (_trigger == gp_shoulderrb)
    {
        if (_struct.__interceptedRight) return INPUT_TRIGGER_STATE.EFFECT_INTERCEPTED;        
        _effect = _struct.__effectRight;
    }
    else
    {
        __InputError("Value ", _trigger ," not a gamepad trigger");
        return false;
    }

    if not (is_struct(_effect)) return __INPUT_TRIGGER_EFFECT.__TYPE_OFF;
    return _effect.__SteamGetState(_device, _trigger);
}