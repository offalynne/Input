function input_players_connected()
{
    var _count = 0;
    
    var _p = 0;
    repeat(INPUT_MAX_PLAYERS)
    {
        if (input_player_connected(_p)) _count++;
        ++_p;
    }
    
    return _count;
}