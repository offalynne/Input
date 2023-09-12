//Feather disable all

/// Returns the parameters being used for the combo system.
/// 
/// The returned struct contains the following member variables:
///   .reset
///   .side_on
///   .forward_verb
///   .counterclockwise_verb
///   .backward_verb
///   .clockwise_verb
///   .reference_direction

function input_combo_params_get()
{
    __INPUT_GLOBAL_STATIC_LOCAL  //Set static _global
    
    static _result = {};
    
    with(_global.__combo_params)
    {
        _result.reset                 = __reset;
        _result.side_on               = __side_on;
        _result.forward_verb          = __forward_verb;
        _result.counterclockwise_verb = __counterclockwise_verb;
        _result.backward_verb         = __backward_verb;
        _result.clockwise_verb        = __clockwise_verb;
        _result.reference_direction   = __reference_direction;
    }
    
    return _result;
}