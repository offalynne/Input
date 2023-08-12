// Feather disable all
/// @desc    Returns whether enough players have connected for valid gameplay

function input_join_is_finished()
{
    __INPUT_GLOBAL_STATIC_LOCAL  //Set static _global
    
    var _connected = input_player_connected_count();
    return ((_connected >= _global.__join_player_min) && (_connected <= _global.__join_player_max));
}
