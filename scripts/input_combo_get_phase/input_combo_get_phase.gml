// Feather disable all

/// Returns what phase a given a combo is in for the specified player
/// 
/// This function will return 0 if the combo is waiting for the first phase to be triggered
/// This function will return 1 more than the number of defined phases if a combo has been
/// finished in its entirety
/// 
/// @param   comboName
/// @param   [playerIndex=0]

function input_combo_get_phase(_name, _player_index = 0)
{
    __INPUT_GLOBAL_STATIC_LOCAL  //Set static _global
    __INPUT_VERIFY_PLAYER_INDEX
    
    var _combo_state = _global.__players[_player_index].__combo_state_dict[$ _name];
    if (not is_struct(_combo_state)) __input_error("Combo with name \"", _name, "\" doesn't exist");
    
    return _combo_state.__phase;
}