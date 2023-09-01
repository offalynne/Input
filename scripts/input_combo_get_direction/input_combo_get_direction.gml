// Feather disable all

/// 
/// 
/// @param   comboName
/// @param   [playerIndex=0]

function input_combo_get_direction(_name, _player_index = 0)
{
    __INPUT_GLOBAL_STATIC_LOCAL  //Set static _global
    __INPUT_VERIFY_PLAYER_INDEX
    
    var _combo_state = _global.__players[_player_index].__combo_state_dict[$ _name];
    if (not is_struct(_combo_state)) __input_error("Combo with name \"", _name, "\" doesn't exist");
    
    return _combo_state.__direction;
}