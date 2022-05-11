#macro INPUT_VERB_COLLISION_GROUPS __input_initialize(); for(var _i = 0; _i < 2; _i++) if (_i == 1) __input_finalize_collision_groups(_collision_source_dict) else var _collision_source_dict

function __input_finalize_collision_groups(_collision_source_dict)
{
    if (!is_struct(_collision_source_dict))
    {
        __input_error("INPUT_VERB_COLLISION_GROUPS must contain a struct (was ", typeof(_collision_source_dict), ")\nDocumentation on INPUT_VERB_COLLISION_GROUPS can be found offline in __input_config_default_profiles()\nOnline documentation can be found at https://jujuadams.github.io/Input");
    }
    
    var _group_names_array = variable_struct_get_names(_collision_source_dict);
    
    var _i = 0;
    repeat(array_length(_group_names_array))
    {
        var _group_name = _group_names_array[_i];
        var _group_array = _collision_source_dict[$ _group_name];
            
        if (!variable_struct_exists(global.__input_verb_group_state_dict, _group_name))
        {
            if (INPUT_DEBUG_VERBS) __input_trace("Creating verb group \"", _group_name, "\"");
            global.__input_verb_group_state_dict[$ _group_name] = true;
        }
        
        var _j = 0;
        repeat(array_length(_group_array))
        {
            var _verb = _group_array[_j];
            var _verb_group_array = global.__input_verb_collision_group_dict[$ _verb];
            
            if (!is_array(_verb_group_array))
            {
                _verb_group_array = [];
                global.__input_verb_collision_group_dict[$ _verb] = _verb_group_array;
            }
            
            array_push(_verb_group_array, _group_name);
            
            ++_j;
        }
        
        ++_i;
    }
    
    if (INPUT_DEBUG_VERBS) __input_trace("Verb collision groups are ", global.__input_verb_collision_group_dict);
}