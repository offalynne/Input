/// @desc    Returns a struct that describes a combo verb
///          A combo verb is considered active when all of its input phases have been completed
///          
///          The returned struct has some methods available to configure the combo, all of which
///          return the struct itself and thus form a fluent interface:
///              .press(verb)
///              .releae(verb)
///              .press_or_release(verb)
///              .hold(verb)
///              .timeout(time)
/// 
///          Here is an example of the Konami Code:
///              input_combo_create("konami")
///              .press("up")
///              .press("up")
///              .press("down")
///              .press("down")
///              .press("left")
///              .press("right")
///              .press("left")
///              .press("right")
///              .press("cancel")
///              .press("accept");
///          
/// @param   name
/// @param   [defaultTimeout]

function input_combo_create(_name, _default_timeout = INPUT_TIMER_MILLISECONDS? 333 : 20)
{
    __input_initialize();
    
    __input_ensure_unique_verb_name(_name);
    
    var _combo_definition = new __input_class_combo_definition(_name, _default_timeout);
    
    //Store this globally for uniqueness checks later
    global.__input_all_verb_dict[$ _name] = true;
    array_push(global.__input_all_verb_array, _name);
    
    global.__input_combo_verb_dict[$ _name] = _combo_definition;
    array_push(global.__input_combo_verb_array, _name);
    
    //Add this combo definition to all players
    var _p = 0;
    repeat(INPUT_MAX_PLAYERS)
    {
        global.__input_players[_p].__add_combo(_name);
        ++_p;
    }
    
    //Return the combo struct so that the developer can add phases to it
    return _combo_definition;
}
