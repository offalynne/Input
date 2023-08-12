// Feather disable all
/// @desc    Sets pause state for gamepad trigger effects for a player
/// @param   state
/// @param   [playerIndex=0]

function input_trigger_effect_set_pause(_state, _player_index = 0)
{
    __INPUT_GLOBAL_STATIC_LOCAL  //Set static _global
    
    if (_player_index == all)
    {
        var _i = 0;
        repeat(INPUT_MAX_PLAYERS)
        {
            input_trigger_effect_set_pause(_state, _i);
            ++_i;
        }
        
        return;
    }
    
    __INPUT_VERIFY_PLAYER_INDEX
    
    _global.__players[_player_index].__trigger_effect_pause(_state);
}
