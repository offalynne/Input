//Feather disable all

/// Resets the parameters used for the combo system.
/// Please note that combos will be forced to be non-directional if no combo parameters are set

function input_combo_params_reset()
{
    __INPUT_GLOBAL_STATIC_LOCAL  //Set static _global
    
    with(_global.__combo_params)
    {
        __reset                 = true;
        __side_on               = undefined;
        __forward_verb          = undefined;
        __counterclockwise_verb = undefined;
        __backward_verb         = undefined;
        __clockwise_verb        = undefined;
        __reference_direction   = undefined;
    }
    
    if (INPUT_COMBO_DEBUG) __input_trace("Combo params reset");
}