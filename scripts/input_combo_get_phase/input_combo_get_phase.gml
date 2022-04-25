/// @param name
/// @param [playerIndex]

function input_combo_get_phase(_name, _player_index = 0)
{
    if (_player_index < 0)
    {
        __input_error("Invalid player index provided (", _player_index, ")");
        return undefined;
    }
    
    if (_player_index >= INPUT_MAX_PLAYERS)
    {
        __input_error("Player index too large (", _player_index, " must be less than ", INPUT_MAX_PLAYERS, ")\nIncrease INPUT_MAX_PLAYERS to support more players");
        return undefined;
    }
    
    var _combo_state = global.__input_players[_player_index].combo_state_dict[$ _name];
    if (!is_struct(_combo_state))
    {
        __input_error("Combo not recognised (", _name, ")");
        return undefined;
    }
    
    return _combo_state.__phase;
}