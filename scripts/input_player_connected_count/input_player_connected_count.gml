/// @desc    Returns he number of players with connected devices

function input_player_connected_count()
{
	__input_initialize();
    
    var _count = 0;
    var _p = 0;
    repeat(INPUT_MAX_PLAYERS)
    {
        if (global.__input_players[_p].__connected) _count++;
        ++_p;
    }
    
    return _count;
}