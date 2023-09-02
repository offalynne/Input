// Feather disable all

/// Returns whether the given combo is defined as directional
/// 
/// Please not that this function will return <false> if no combo parameters have been set
/// 
/// @param   comboName

function input_combo_get_directional(_name)
{
    __INPUT_GLOBAL_STATIC_LOCAL  //Set static _global
    
    if (_global.__combo_params.__reset) return false;
    
    var _combo_def = _global.__combo_verb_dict[$ _name];
    if (not is_struct(_combo_def)) __input_error("Combo with name \"", _name, "\" doesn't exist");
    
    return _combo_def.__directional;
}