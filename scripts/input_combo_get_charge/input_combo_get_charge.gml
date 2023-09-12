// Feather disable all

/// Returns the value of the most recently executed charge phase
/// 
/// If a combo contains no charge phase, this function returns 0
/// 
/// @param   comboName
/// @param   [playerIndex=0]

function input_combo_get_charge(_name, _player_index = 0)
{
    __INPUT_GLOBAL_STATIC_LOCAL  //Set static _global
    __INPUT_VERIFY_PLAYER_INDEX
    
    var _combo_state = _global.__players[_player_index].__combo_state_dict[$ _name];
    if (not is_struct(_combo_state)) __input_error("Combo with name \"", _name, "\" doesn't exist");
    
    with(_combo_state)
    {
        if ((__charge_start_time == undefined) || (__charge_start_time == undefined)) return 0;
        return (__charge_end_time - __charge_start_time);
    }
}