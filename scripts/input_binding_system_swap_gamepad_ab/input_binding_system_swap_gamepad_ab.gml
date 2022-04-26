/// @param state

function input_binding_system_swap_gamepad_ab(_state)
{
	__input_initialize();
	
    //The himbo of error checks - simple, dumb, but loveable
    if (array_length(global.__input_verb_array) > 0)
    {
        __input_error("input_binding_system_swap_gamepad_ab() should be called before setting up any verbs");
    }
    
    global.__input_swap_ab = _state;
}