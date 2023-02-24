/// @desc    Exclusively assigns a source to a player. All other players using the source will have it unassigned
///          If the player had any other sources assigned then they will be unassigned
/// @param   source
/// @param   [playerIndex=0]
/// @param   [autoProfile=true]

function input_source_set(_source, _player_index = 0, _auto_profile = true)
{
    __input_initialize();
    __INPUT_VERIFY_PLAYER_INDEX
    
    if (_source == all)
    {
        input_source_clear(all);
    
        with(global.__input_players[_player_index])
        {
            __source_add(INPUT_KEYBOARD);
            __source_add(__INPUT_TOUCH_PRIMARY? INPUT_TOUCH : INPUT_MOUSE);
            
            var _i = 0;
            repeat(INPUT_MAX_GAMEPADS)
            {
                __source_add(INPUT_GAMEPAD[_i]);
                ++_i;
            }
            
            if (_auto_profile) __profile_set_auto();
        }
        
        return;
    }
    
    __INPUT_VERIFY_SOURCE
    __INPUT_VERIFY_SOURCE_ASSIGNABLE
    
    __input_source_relinquish(_source);
    with(global.__input_players[_player_index])
    {
        __sources_clear();
        __source_add(_source);
        if (_auto_profile) __profile_set_auto();
    }
}