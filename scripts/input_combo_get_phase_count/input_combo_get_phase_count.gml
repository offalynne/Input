/// @desc    Returns the number of phases for a combo verb
/// @param   name

function input_combo_get_phase_count(_name)
{
    var _combo_definition = global.__input_combo_verb_dict[$ _name];
    if (!is_struct(_combo_definition))
    {
        __input_error("Combo not recognised (", _name, ")");
        return undefined;
    }
    
    return array_length(_combo_definition.__phase_array);
}
