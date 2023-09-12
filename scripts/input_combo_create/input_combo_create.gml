// Feather disable all

/// Creates a new combo which can be accessed like any other verb
/// 
/// This function returns a struct (instance of __input_class_combo_definition) that you will need
/// to edit in order to flesh out the combo. The following methods are provided to build the combo:
///   .press(verb)
///   .release(verb)
///   .press_or_release(verb)
///   .hold(verb)
///   .charge(verb, [minTime=default])
/// 
/// You should execute methods in the order that verbs should activated to execute the combo.
/// Methods can be chained one after another as a fluent interface e.g.
/// 
///   input_combo_create("hadouken").press("down").press("right").press("punch")
/// 
/// @param   comboName                Name of the combo
/// @param   [phaseTimeout=default]   Maximum time allowed between phases
/// @param   [directional=true]       Whether the combo should adjust based on the first direction pressed

function input_combo_create(_name, _phase_timeout = INPUT_COMBO_DEFAULT_PHASE_TIMEOUT, _directional = true)
{
    __INPUT_GLOBAL_STATIC_LOCAL  //Set static _global
    
    __input_ensure_unique_verb_name(_name);
    
    var _combo_definition = new __input_class_combo_definition(_name, _phase_timeout, _directional);
    
    //Store this globally for uniqueness checks later
    _global.__all_verb_dict[$ _name] = true;
    array_push(_global.__all_verb_array, _name);
    
    _global.__combo_verb_dict[$ _name] = _combo_definition;
    array_push(_global.__combo_verb_array, _name);
    
    //Add this chord definition to all players
    var _p = 0;
    repeat(INPUT_MAX_PLAYERS)
    {
        with(_global.__players[_p])
        {
            __add_combo_state(_name, _combo_definition);
            __add_complex_verb(_name, __INPUT_VERB_TYPE.__CHORD);
        }
        
        ++_p;
    }
    
    return _combo_definition;
}