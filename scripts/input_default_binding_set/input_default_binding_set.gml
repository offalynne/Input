/// @param verb
/// @param binding
/// @param [alternate]

function input_default_binding_set(_verb, _binding, _alternate = 0)
{
	__input_initialize();
    __input_verb_define(_verb);
    
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
    
    with(global.__input_default_player)
    {
        var _config_category = get_binding_config_category(_binding);
        __input_trace("Setting default binding for config=", _config_category, ", verb=", _verb, ", alt=", _alternate, " to \"", input_binding_get_name(_binding), "\"");
        set_binding(_config_category, _verb, _alternate, _binding);
    }
    
    var _p = 0;
    repeat(INPUT_MAX_PLAYERS)
    {
        //Make sure to create a new binding struct for each player as we don't want a change in one place to propagate to all players
        _binding = _binding.__duplicate();
        set_binding(_config_category, _verb, _alternate, _binding);
        ++_p;
    }
}
