/// @param [playerIndex=0]

function input_player_multidevice_set(_player_index = 0)
{
	__input_initialize();
    __INPUT_VERIFY_PLAYER_INDEX
    
    global.__input_multidevice_player = _player_index;
    
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
}
