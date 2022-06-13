/// @desc    Returns which phase of a combo verb the player is on, from 0 to <n>
///          A value of 0 indicates that the combo has not been started and is waiting for player input
///          A value of <n> indicates the combo has been completed and is currently active
/// @param   name
/// @param   [playerIndex=0]

function input_combo_get_phase(_name, _player_index = 0)
{
    __INPUT_VERIFY_PLAYER_INDEX
    
    var _combo_state = global.__input_players[_player_index].__combo_state_dict[$ _name];
    if (!is_struct(_combo_state))
    {
        __input_error("Combo not recognised (", _name, ")");
        return undefined;
    }
    
    return _combo_state.__phase;
}