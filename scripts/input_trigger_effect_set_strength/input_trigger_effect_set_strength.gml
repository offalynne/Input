/// @param strength
/// @param [playerIndex=0]

function input_trigger_effect_set_strength(_strength, _player_index = 0)
{
    __INPUT_VERIFY_PLAYER_INDEX
    
    _strength = clamp(_strength, 0, 1);
    
    global.__input_players[_player_index].__trigger_effect_strength = _strength;
    
    __input_player_apply_trigger_effects(all);
}