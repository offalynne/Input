function __input_ensure_unique_verb_name(_name)
{
    __INPUT_GLOBAL_STATIC_LOCAL  //Set static _global
    
    if (variable_struct_exists(_global.__basic_verb_dict, _name))
    {
        __input_error("A basic verb named \"", _name, "\" already exists");
        return;
    }
    
    if (variable_struct_exists(_global.__chord_verb_dict, _name))
    {
        __input_error("A chord named \"", _name, "\" already exists");
        return;
    }
}