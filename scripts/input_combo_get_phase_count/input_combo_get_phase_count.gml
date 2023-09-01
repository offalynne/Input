// Feather disable all

/// Returns the number of phases for the given combo
/// 
/// @param   comboName

function input_combo_get_phase_count(_name)
{
    __INPUT_GLOBAL_STATIC_LOCAL  //Set static _global
    
    var _combo_def = _global.__combo_verb_dict[$ _name];
    if (not is_struct(_combo_def)) __input_error("Combo with name \"", _name, "\" doesn't exist");
    
    return array_length(_combo_def.__phase_array);
}