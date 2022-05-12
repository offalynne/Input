function input_multiplayer_is_finished()
{
    __input_initialize();
    
    var _connected = input_players_connected();
    return ((_connected >= global.__input_multiplayer_min) && (_connected <= global.__input_multiplayer_max));
}