/// @param name
/// @param [playerIndex]

function input_combo_get_phase(_name, _player_index = 0)
{
    __INPUT_VERIFY_PLAYER_INDEX
    
    var _combo_state = global.__input_players[_player_index].combo_state_dict[$ _name];
    if (!is_struct(_combo_state))
    {
        __input_error("Combo not recognised (", _name, ")");
        return undefined;
    }
    
    return _combo_state.__phase;
}