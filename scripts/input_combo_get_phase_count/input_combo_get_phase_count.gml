/// @param name

function input_combo_get_phase_count(_name)
{
    var _combo_definition = global.__input_combo_dict[$ _name];
    if (!is_struct(_combo_definition))
    {
        __input_error("Combo not recognised (", _name, ")");
        return undefined;
    }
    
    return array_length(_combo_definition.__phase_array);
}
