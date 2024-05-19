// Feather disable all
/// @desc    Exclusively assigns a source to a player. All other players using the source will have it unassigned
///          If the player had any other sources assigned then they will be unassigned
/// @param   source
/// @param   [playerIndex=0]
/// @param   [autoProfile=true]
/// @param   [exclusive=true]

function input_source_set(_source, _player_index = 0, _auto_profile = true, _exclusive = true)
{
    __INPUT_GLOBAL_STATIC_LOCAL  //Set static _global
    __INPUT_VERIFY_PLAYER_INDEX
    
    if (_source == all)
    {
        if (_exclusive) input_source_clear(all);
    
        with(_global.__players[_player_index])
        {
            if (_global.__keyboard_allowed) __source_add(INPUT_KEYBOARD);
            if (_global.__mouse_allowed)    __source_add(INPUT_MOUSE);
            if (_global.__touch_allowed)    __source_add(INPUT_TOUCH);
            
            if (_global.__gamepad_allowed)
            {
                var _i = 0;
                repeat(array_length(INPUT_GAMEPAD))
                {
                    __source_add(INPUT_GAMEPAD[_i]);
                    ++_i;
                }
            }
            
            if (_auto_profile) __profile_set_auto();
        }
        
        return;
    }
    
    __INPUT_VERIFY_SOURCE
    __INPUT_VERIFY_SOURCE_ASSIGNABLE
    
    if (_exclusive) __input_source_relinquish(_source);

    with(_global.__players[_player_index])
    {
        __sources_clear();
        __source_add(_source);
        if (_auto_profile) __profile_set_auto();
    }
}
