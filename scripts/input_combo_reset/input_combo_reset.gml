// Feather disable all

/// Resets a combo for the given player
/// 
/// You can use the GML keyword <all> for the combo name to reset every combo
/// 
/// @param   comboName
/// @param   [playerIndex=0]

function input_combo_reset(_name, _player_index = 0)
{
    __INPUT_GLOBAL_STATIC_LOCAL  //Set static _global
    
    if (_name == all)
    {
        var _i = 0;
        repeat(array_length(_global.__combo_verb_array))
        {
            input_combo_reset(_global.__combo_verb_array[_i], _player_index);
            ++_i;
        }
        
        return;
    }
    
    __INPUT_VERIFY_PLAYER_INDEX
    
    var _combo_state = _global.__players[_player_index].__combo_state_dict[$ _name];
    if (not is_struct(_combo_state)) __input_error("Combo with name \"", _name, "\" doesn't exist");
    
    _combo_state.__reset();
}