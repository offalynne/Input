function input_players_connected()
{
    if (INPUT_WARNING_DEPRECATED) __input_error("This function has been deprecated\n(Set INPUT_WARNING_DEPRECATED to <false> to ignore this warning)");
    
    return input_player_connected_count();
}