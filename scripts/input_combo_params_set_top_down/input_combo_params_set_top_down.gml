// Feather disable all

/// Sets up the combo system for use with top-down games
/// Verbs should be specified in a counter-clockwise direction. You can define these in any
/// direction you like but we recommend the following usage for consistency:
///   
///   input_combo_params_set_top_down("right", "up", "left", "down", 0)
/// 
/// @param   forwardVerb
/// @param   counterclockwiseVerb
/// @param   backwardVerb
/// @param   clockwiseVerb
/// @param   referenceDirection

function input_combo_params_set_top_down(_forward_verb, _counterclockwise_verb, _backward_verb, _clockwise_verb, _reference_direction)
{
    __INPUT_GLOBAL_STATIC_LOCAL  //Set static _global
    
    with(_global.__combo_params)
    {
        __reset                 = false;
        __side_on               = false;
        __forward_verb          = _forward_verb;
        __counterclockwise_verb = _counterclockwise_verb;
        __backward_verb         = _backward_verb;
        __clockwise_verb        = _clockwise_verb;
        __reference_direction   = _reference_direction;
    }
    
    if (INPUT_COMBO_DEBUG) __input_trace("Combo params set for top-down usage (forward=\"", _forward_verb, "\", counter-clockwise=\"", _counterclockwise_verb, "\", backward=\"", _backward_verb, "\", clockwise=\"", _clockwise_verb, "\", reference direction=", _reference_direction, ")");
}