/// @param [playerIndex]

function input_player_clear_sources(_player_index = 0)
{
	__input_initialize();
    
    if (_player_index == all)
    {
        var _i = 0;
        repeat(INPUT_MAX_PLAYERS)
        {
            global.__input_players[_i].__clear_sources();
            ++_i;
        }
        
        return;
    }
    
    __INPUT_VERIFY_PLAYER_INDEX
    
    global.__input_players[_player_index].__clear_sources();
}
