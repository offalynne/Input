function input_system_reset()
{
    var _p = 0;
    repeat(INPUT_MAX_PLAYERS)
    {
        input_player_reset(_p);
        ++_i;
    }
}