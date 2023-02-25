function __input_player_apply_trigger_effects(_player_index)
{
    __INPUT_GLOBAL_STATIC_LOCAL  //Set static _global
    
    if (_player_index == all)
    {
        var _i = 0;
        repeat(INPUT_MAX_PLAYERS)
        {
            __input_player_apply_trigger_effects(_i);
            ++_i;
        }
        
        return;
    }
    
    __INPUT_VERIFY_PLAYER_INDEX
       
    with(_global.__players[_player_index])
    {
       if (__trigger_effect_paused) return;
       
        __trigger_effect_set(gp_shoulderlb, __trigger_effect_left,  false);
        __trigger_effect_set(gp_shoulderrb, __trigger_effect_right, false);
    }
}