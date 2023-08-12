// Feather disable all
/// @desc    Gets gamepad trigger effect state for a player
/// @param   trigger
/// @param   [playerIndex=0]

function input_trigger_effect_get_state(_trigger, _player_index = 0)
{
    __INPUT_GLOBAL_STATIC_LOCAL  //Set static _global
    __INPUT_VERIFY_PLAYER_INDEX

    if not ((_trigger == gp_shoulderlb) || (_trigger == gp_shoulderrb))
    {
        __input_error("Value ", _trigger ," not a gamepad trigger");
    }

    var _player  = _global.__players[_player_index];
    var _gamepad = input_player_get_gamepad(_player_index);
    if (_gamepad < 0) return undefined;
    
    if (_player.__trigger_effect_paused) return INPUT_TRIGGER_STATE.EFFECT_INTERCEPTED;
    
    if (os_type == os_ps5) return ps5_gamepad_get_trigger_effect_state(_gamepad, _trigger);
    
    var _effect = undefined;
    if (_trigger == gp_shoulderlb)
    {
        if (_player.__trigger_intercepted_left) return INPUT_TRIGGER_STATE.EFFECT_INTERCEPTED;        
        _effect = _player.__trigger_effect_left;
    }
    else if (_trigger == gp_shoulderrb)
    {
        if (_player.__trigger_intercepted_right) return INPUT_TRIGGER_STATE.EFFECT_INTERCEPTED;        
        _effect = _player.__trigger_effect_right;
    }
    else
    {
        __input_error("Value ", _trigger ," not a gamepad trigger");
        return false;
    }

    if not (is_struct(_effect)) return __INPUT_TRIGGER_EFFECT.__TYPE_OFF;
    return _effect.__steam_get_state(_gamepad, _trigger);
}
