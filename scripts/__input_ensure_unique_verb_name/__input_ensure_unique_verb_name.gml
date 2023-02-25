function __input_ensure_unique_verb_name(_name)
{
    if (variable_struct_exists(global.__input_basic_verb_dict, _name))
    {
        __input_error("A basic verb named \"", _name, "\" already exists");
        return;
    }
    
    if (variable_struct_exists(global.__input_chord_verb_dict, _name))
    {
        __input_error("A chord named \"", _name, "\" already exists");
        return;
    }
}