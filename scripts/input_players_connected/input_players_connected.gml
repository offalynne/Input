function input_players_connected()
{
    if (INPUT_WARNING_DEPRECATED) __input_error("This function has been deprecated\nPlease use input_player_connected_count() instead\n(Set INPUT_WARNING_DEPRECATED to <false> to ignore this warning)");
    
    return input_player_connected_count();
}