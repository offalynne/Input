/// @param source
/// @param [playerIndex=0]

function input_player_claim(_source, _player_index = 0)
{
	__input_initialize();
    __INPUT_VERIFY_PLAYER_INDEX
    
    if (_source == all)
    {
        input_player_clear_sources(all);
    
        with(global.__input_players[_player_index])
        {
            __source_add(INPUT_KEYBOARD);
            __source_add(INPUT_MOUSE);
            
            var _i = 0;
            repeat(__INPUT_MAX_TRACKED_GAMEPADS)
            {
                __source_add(INPUT_GAMEPAD[_i]);
                ++_i;
            }
        }
        
        return;
    }
    
    __INPUT_VERIFY_SOURCE
    __INPUT_VERIFY_SOURCE_ASSIGNABLE
    
    __input_source_relinquish(_source);
    global.__input_players[_player_index].__source_add(_source);
    
    if (INPUT_ASSIGN_KEYBOARD_AND_MOUSE_TOGETHER)
    {
        if (_source == INPUT_KEYBOARD)
        {
            __input_source_relinquish(INPUT_MOUSE);
            global.__input_players[_player_index].__source_add(INPUT_MOUSE);
        }
        else if (_source == INPUT_MOUSE)
        {
            __input_source_relinquish(INPUT_KEYBOARD);
            global.__input_players[_player_index].__source_add(INPUT_KEYBOARD);
        }
    }
}
