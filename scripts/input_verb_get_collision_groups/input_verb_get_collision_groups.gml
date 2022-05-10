/// @param verb

function input_verb_get_collision_groups(_verb_name)
{
    __input_initialize();
    __INPUT_VERIFY_BASIC_VERB_NAME
    
    return global.__input_verb_collision_group_dict[$ _verb_name];
}