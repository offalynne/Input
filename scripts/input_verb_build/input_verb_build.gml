/// @param verb
/// @param defaultBinding
/// @param [alternate]

function input_verb_build(_verb, _binding, _alternate = 0)
{
	__input_initialize();
    
    //Validate parameters
    if (_alternate < 0)
    {
        __input_error("Invalid \"alternate\" argument (", _alternate, ")");
        return undefined;
    }
    
    if (_alternate >= INPUT_MAX_ALTERNATE_BINDINGS)
    {
        __input_error("\"alternate\" argument too large (", _alternate, " must be less than ", INPUT_MAX_ALTERNATE_BINDINGS, ")\nIncrease INPUT_MAX_ALTERNATE_BINDINGS for more alternate binding slots");
        return undefined;
    }
    
    if (!input_value_is_binding(_binding))
    {
        __input_error("Value provided is not a binding");
        return undefined;
    }
    
    //Get the name of the config we want to write to
    var _config_name = global.__input_default_player.get_binding_config_name(_binding);
    
    //If we haven't seen this verb before...
    if (!variable_struct_exists(global.__input_verb_dict, _verb))
    {
        //Validate the verb name
        __input_ensure_unique_verb_name(_verb);
        
        //And then register it
        global.__input_verb_dict[$ _verb] = true;
        array_push(global.__input_verb_array, _verb);
        
        //Ensure binding slots for all players
        with(global.__input_default_player)
        {
            global.__input_default_player.__ensure_verb(_config_name, _verb);
        }
        
        var _p = 0;
        repeat(INPUT_MAX_PLAYERS)
        {
            global.__input_players[_p].__ensure_verb(_config_name, _verb);
            ++_p;
        }
    }
    
    //Set the binding on the default player
    with(global.__input_default_player)
    {
        __set_binding(_config_name, _verb, _alternate, _binding);
    }
}
