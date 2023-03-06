/// @desc    Returns an array of verb groups names, arranged in no particular order

function input_verb_groups_get()
{
    __INPUT_GLOBAL_STATIC_LOCAL  //Set static _global
    
    return variable_struct_get_names(_global.__group_to_verbs_dict);
}