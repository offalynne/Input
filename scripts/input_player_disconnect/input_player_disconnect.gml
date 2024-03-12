// Feather disable all
/// @desc    Unassigns all sources for the player
/// @param   [playerIndex=0]

function input_player_disconnect(_player_index = 0)
{
    input_source_clear(_player_index);
}
