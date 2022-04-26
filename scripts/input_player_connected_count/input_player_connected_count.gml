function input_player_connected_count()
{
	__input_initialize();
    __INPUT_VERIFY_PLAYER_INDEX
    
    var _count = 0;
    var _p = 0;
    repeat(INPUT_MAX_PLAYERS)
    {
        if (global.__input_players[_player_index].__is_connected()) _count++;
        ++_p;
    }
    
    return _count;
}