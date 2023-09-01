// Feather disable all

/// Sets up the combo system for use with side-on games (fighting games, platformers etc.)
/// 
/// @param   forwardVerb
/// @param   backwardVerb
/// @param   referenceDirection

function input_combo_params_set_side_on(_forward_verb, _backward_verb, _reference_direction)
{
    __INPUT_GLOBAL_STATIC_LOCAL  //Set static _global
    
    with(_global.__combo_params)
    {
        __reset                 = false;
        __side_on               = true;
        __forward_verb          = _forward_verb;
        __counterclockwise_verb = undefined;
        __backward_verb         = _backward_verb;
        __clockwise_verb        = undefined;
        __reference_direction   = _reference_direction;
    }
    
    if (INPUT_COMBO_DEBUG) __input_trace("Combo params set for side-on usage (forward=\"", _forward_verb, "\", backward=\"", _backward_verb, "\", reference direction=", _reference_direction, ")");
}