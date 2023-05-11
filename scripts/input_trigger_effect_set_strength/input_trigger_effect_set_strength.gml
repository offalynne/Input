/// @desc    Sets the strength of trigger effects for the player
/// @param   strength
/// @param   [playerIndex=0]

function input_trigger_effect_set_strength(_strength, _player_index = 0)
{
    __INPUT_GLOBAL_STATIC_LOCAL  //Set static _global
    
    if (_player_index == all)
    {
        var _i = 0;
        repeat(INPUT_MAX_PLAYERS)
        {
            input_trigger_effect_set_strength(_strength, _i);
            ++_i;
        }
        
        return;
    }
    
    __INPUT_VERIFY_PLAYER_INDEX
    
    _strength = clamp(_strength, 0, 1);
    
    with(_global.__players[_player_index])
    {
        if (__trigger_effect_strength != _strength)
        {
            __trigger_effect_strength = _strength;
            __input_player_apply_trigger_effects(_player_index);
        }
    }
}