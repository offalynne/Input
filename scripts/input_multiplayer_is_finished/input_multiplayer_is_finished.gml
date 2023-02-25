/// @desc    Returns whether enough players have connected for valid gameplay

function input_multiplayer_is_finished()
{
    static _global = __input_state();
    
    var _connected = input_player_connected_count();
    return ((_connected >= global.__input_multiplayer_min) && (_connected <= global.__input_multiplayer_max));
}