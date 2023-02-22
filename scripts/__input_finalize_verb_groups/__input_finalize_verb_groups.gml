#macro INPUT_VERB_GROUPS __input_initialize(); for(var _i = 0; _i < 2; _i++) if (_i == 1) __input_finalize_verb_groups() else global.__input_group_to_verbs_dict

function __input_finalize_verb_groups()
{
    if (global.__input_initialization_phase != "__input_config_verbs_and_bindings") return;
    
    if (!is_struct(global.__input_group_to_verbs_dict))
    {
        __input_error("INPUT_VERB_GROUPS must contain a struct (was ", typeof(global.__input_group_to_verbs_dict), ")\nDocumentation on INPUT_VERB_GROUPS can be found offline in __input_config_verbs()\nOnline documentation can be found at https://jujuadams.github.io/Input");
    }
    
    global.__input_verb_group_array = variable_struct_get_names(global.__input_group_to_verbs_dict);
    
    var _i = 0;
    repeat(array_length(global.__input_verb_group_array))
    {
        var _group_name = global.__input_verb_group_array[_i];
        var _group_array = global.__input_group_to_verbs_dict[$ _group_name];
        
        //Ensure all players have the verb group created
        global.__input_default_player.__verb_group_ensure(_group_name);
        
        var _p = 0;
        repeat(INPUT_MAX_PLAYERS)
        {
            global.__input_players[_p].__verb_group_ensure(_group_name);
            ++_p;
        }
        
        //Build the verb->group dictionary
        var _j = 0;
        repeat(array_length(_group_array))
        {
            var _verb = _group_array[_j];
            
            if (!variable_struct_exists(global.__input_basic_verb_dict, _verb)) __input_error("Verb \"", _verb, "\" doesn't exist\nPlease check INPUT_VERB_GROUPS matches INPUT_DEFAULT_PROFILES");
            if (variable_struct_exists(global.__input_verb_to_group_dict, _verb)) __input_error("Verb \"", _verb, "\" already has a group (", _group_name, ")");
            global.__input_verb_to_group_dict[$ _verb] = _group_name;
            
            ++_j;
        }
        
        ++_i;
    }
    
    if (__INPUT_DEBUG_VERBS) __input_trace("Verb groups are ", global.__input_verb_to_group_dict);
}